import {AbsoluteScoreNode, StandingRecord} from "./types";
import * as admin from 'firebase-admin';

export default async function saveNewRecordValue(absolute: AbsoluteScoreNode, yearGroup: number, eventGroupId: string): Promise<boolean> {
    const standingRecordResponse = await admin.firestore().collection('sd_standing_records')
        .where('eventGroupId', '==', eventGroupId)
        .where('yearGroup', '==', yearGroup)
        .get();

    const standingRecordRef = standingRecordResponse.docs[0];
    const standingRecord = standingRecordRef?.data() as StandingRecord | undefined;
    if (!standingRecord) return false;

    await standingRecordRef.ref.update({
        new: {
            name: absolute.competitorName,
            value: absolute.value,
        }
    } as Partial<StandingRecord>);

    return absolute.value > standingRecord.value;
}
