import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import {Form, ScoreNode} from "./types";
import {getFormTotal, positionToPoints} from "./points_finder";
import {reassignFormPositions} from "./form_position";

export const sdPropagateScore = functions.region('europe-west2')
    .firestore.document('sd_score_nodes/{sd_score_node}')
    .onWrite(async (change) => {
        const newData = change.after.data() as ScoreNode;
        let formId;
        if (!newData) {
            const oldData = change.before.data() as ScoreNode;
            formId = oldData.formId;
        } else {
            formId = newData.formId;
        }

        const batch = admin.firestore().batch();
        if (newData) {
            const points = await positionToPoints(newData.position, newData.eventId);
            if (!points) return;

            // use a batch write to ensure clients don't have dodgy double reads
            batch.update(change.after.ref, {
                calculatedPoints: points,
            });
        }

        const formRef = admin.firestore().collection('sd_forms').doc(formId);
        const formTotal = await getFormTotal(formRef.id);
        batch.update(formRef, {
            'points.total': formTotal,
        });

        await batch.commit();
    });

export const sdCalculateFormPosition = functions.region('europe-west2')
    .firestore.document('sd_forms/{sd_form}')
    .onUpdate(async (change) => {
        const newData = change.after.data() as Form;
        await reassignFormPositions(newData.yearGroup);
    });
