import * as admin from "firebase-admin";
import {Event, EventGroup, PointAlloc, ScoreNode} from "./types";

export const getEvent = async (eventId: string): Promise<[Event, admin.firestore.DocumentReference]> => {
    const eventResponse = await admin.firestore()
        .collectionGroup('sd_events')
        .where('_id', '==', eventId)
        .get();

    const eventData = eventResponse.docs[0];
    return [eventData.data() as Event, eventData.ref];
}

export const getEventGroup = async (eventRef: admin.firestore.DocumentReference): Promise<EventGroup | undefined> => {
    const eventGroupRef = eventRef.parent.parent;
    if (!eventGroupRef) return undefined;

    const response = await eventGroupRef.get();
    return {
        ...response.data(),
        id: response.id,
    } as EventGroup | undefined;
}

export const positionToPoints = async (position: number, [event, eventRef]: [Event, admin.firestore.DocumentReference]): Promise<number | undefined> => {
    const eventGroupRef = eventRef.parent.parent;
    if (!eventGroupRef) return;

    const scoreSpecRef = eventGroupRef.parent.parent;
    if (!scoreSpecRef) return;

    const pointAllocResponse = await scoreSpecRef
        .collection('sd_point_allocs')
        .where('position', '==', position)
        .where('subEvent', '==', event.subEvent)
        .get();

    const pointAllocData = pointAllocResponse.docs[0];
    if (!pointAllocData) return;

    const pointAlloc = {
        ...pointAllocData.data() as PointAlloc,
        'id': pointAllocData.id,
    };

    return pointAlloc.points;
}

export const getFormTotal = async (formId: string): Promise<number> => {
    const scoreNodeResponse = await admin.firestore()
        .collection('sd_score_nodes')
        .where('formId', '==', formId)
        .get();

    let total = 0;

    for (const scoreNodeData of scoreNodeResponse.docs) {
        const scoreNode = scoreNodeData.data() as ScoreNode;
        total += scoreNode.calculatedPoints || 0;
    }

    return total;
}
