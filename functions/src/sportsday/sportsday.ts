import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import {Form, ScoreNode} from "./types";
import {getEvent, positionToPoints} from "./points_finder";
import {reassignFormPositions} from "./form_position";
import addScoreNodeToFeed from "./score_to_feed";
import saveNewRecordValue from "./records";

export const sdPropagateScore = functions.region('europe-west2')
    .firestore.document('sd_score_nodes/{sd_score_node}')
    .onWrite(async (change) => {
        const newData = change.after.data() as ScoreNode;
        const oldData = change.before.data() as ScoreNode;
        let formId;
        if (!newData) {
            formId = oldData.formId;
        } else {
            formId = newData.formId;
        }

        if (newData?.position === oldData?.position) return;

        const batch = admin.firestore().batch();
        let pointsToAdd = 0;
        if (newData) {
            const eventTuple = await getEvent(newData.eventId);
            await addScoreNodeToFeed(newData, eventTuple);

            const points = await positionToPoints(newData.position, eventTuple);
            if (!points) return;

            // use a batch write to ensure clients don't have dodgy double reads
            batch.update(change.after.ref, {
                calculatedPoints: points,
            });

            if (oldData?.calculatedPoints) {
                pointsToAdd = points - oldData.calculatedPoints;
            } else {
                pointsToAdd = points;
            }
        } else if (oldData) {
            pointsToAdd = -(oldData.calculatedPoints || 0);
        }

        const formRef = admin.firestore().collection('sd_forms').doc(formId);
        batch.update(formRef, {
            'points.total': admin.firestore.FieldValue.increment(pointsToAdd),
        });

        await batch.commit();
    });

export const sdTestBrokenRecord = functions.region('europe-west2')
    .firestore.document('sd_score_nodes/{sd_score_node}')
    .onWrite(async change => {
        const newData = change.after.data() as ScoreNode;
        const oldData = change.before.data() as ScoreNode;
        if (newData?.absolute?.competitorName === oldData?.absolute?.competitorName
            && newData?.absolute?.value === oldData?.absolute?.value) return;

        if (newData) {
            // run these before getEvent to reduce read count
            if (newData.position !== 1 || newData.absolute === undefined) return;

            const [event, ref] = await getEvent(newData.eventId);
            // only first place competitors in a-races can beat records
            if (event.subEvent !== 0) return;

            const absolute = newData.absolute;
            const eventGroupId = ref.parent.parent?.id;
            if (!eventGroupId) return;

            let yearGroup: number | undefined;
            const formId = newData.formId;
            if (formId.startsWith('10')) {
                yearGroup = 10;
            } else {
                yearGroup = parseInt(formId[0]);
            }

            if (isNaN(yearGroup)) return;
            const isNew = await saveNewRecordValue(absolute, yearGroup, eventGroupId);

            await change.after.ref.update({
                'absolute.isNewRecord': isNew,
            });
        }
    });

export const sdCalculateFormPosition = functions.region('europe-west2')
    .firestore.document('sd_forms/{sd_form}')
    .onUpdate(async (change) => {
        const newData = change.after.data() as Form;
        const oldData = change.before.data() as Form;

        // if the quantity of points is unchanged, then this function is just being called as the result of another function call changing this form's position.
        if (oldData?.points?.total === newData?.points?.total) return;
        await reassignFormPositions(newData.yearGroup);
    });
