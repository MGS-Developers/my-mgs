import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import {Form, ScoreNode} from "./types";
import {getEvent, positionToPoints} from "./points_finder";
import {reassignFormPositions} from "./form_position";
import addScoreNodeToFeed from "./score_to_feed";

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

export const sdCalculateFormPosition = functions.region('europe-west2')
    .firestore.document('sd_forms/{sd_form}')
    .onUpdate(async (change) => {
        const newData = change.after.data() as Form;
        await reassignFormPositions(newData.yearGroup);
    });
