import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const delimitedBatchDelete = async (snapshot: admin.firestore.QuerySnapshot): Promise<void> => {
    const batches: admin.firestore.WriteBatch[] = [
        admin.firestore().batch(),
    ];
    let currentBatchSize = 0;

    snapshot.forEach(doc => {
        if (currentBatchSize == 500) {
            batches.push(admin.firestore().batch());
            currentBatchSize = 0;
        }

        const currentBatch = batches[batches.length - 1];
        currentBatch.delete(doc.ref);
        currentBatchSize++;
    });

    for (const batch of batches) {
        await batch.commit();
    }
}

export const commitCleanup = async (collection: string, timestampField: string, millisAgo: number): Promise<void> => {
    const maximumTime = Date.now() - millisAgo;
    const docs = await admin.firestore()
        .collection(collection)
        .where(timestampField, '<', admin.firestore.Timestamp.fromMillis(maximumTime))
        .get();

    await delimitedBatchDelete(docs);
}

export const cleanup = functions.region('europe-west2').https
    .onRequest(async (_, res) => {
        const oneMonth = 28 * 24 * 60 * 60 * 1000;
        await commitCleanup('logs', 'timestamp', oneMonth);

        const oneHour = 60 * 60 * 1000;
        await commitCleanup('setup_codes', 'createdAt', oneHour);
        await commitCleanup('web_auth_sessions', 'createdAt', oneHour);

        res.sendStatus(200);
    });
