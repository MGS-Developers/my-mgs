import * as functions from 'firebase-functions';
import {ScoreNode} from "./types";
import {positionToPoints} from "./points_finder";

export const sdPropagateScore = functions.region('europe-west2')
    .firestore.document('sd_score_nodes/{sd_score_node}')
    .onWrite(async (change, context) => {
        const newData = change.after.data() as ScoreNode;
        if (!newData) return;

        const points = await positionToPoints(newData.position, newData.eventId);
        if (!points) return;

        await change.after.ref.update({
            calculatedPoints: points,
        });
    });