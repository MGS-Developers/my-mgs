import {ScoreNode, Event} from "./types";
import * as admin from 'firebase-admin';
import {getEventGroup} from "./points_finder";

export default async function addScoreNodeToFeed(scoreNode: ScoreNode, [event, ref]: [Event, admin.firestore.DocumentReference]) {
    const eventId = scoreNode.eventId;
    const eventGroup = await getEventGroup(ref);
    if (!eventGroup) return;

    await admin.firestore()
        .collection('sd_feed')
        .doc(eventId)
        .set({
            event: {
                // this needs to contain all the data necessary to reconstruct both the Event and the EventGroup
                // to minimise document reads
                id: eventId,
                groupId: eventGroup.id,
                scoreSpecId: eventGroup.scoreSpecId,
                yearGroup: event.yearGroup,
                name: eventGroup.name,
                subEvent: event.subEvent,
                subEventCount: eventGroup.subEventCount,
            },
            timestamp: admin.firestore.Timestamp.now(),
        }, {merge: true});
}
