import * as admin from "firebase-admin";
import {Event, PointAlloc} from "./types";

export const positionToPoints = async (position: number, eventId: string): Promise<number | undefined> => {
    const eventResponse = await admin.firestore()
        .collectionGroup('sd_events')
        .where('_id', '==', eventId)
        .get();

    const eventData = eventResponse.docs[0];
    const eventGroupRef = eventData?.ref.parent.parent;
    if (!eventGroupRef) return;

    const event = eventData.data() as Event;

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