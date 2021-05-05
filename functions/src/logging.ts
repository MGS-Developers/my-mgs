import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import {detailedDiff} from "deep-object-diff";

const ignoredCollections = [
    'sd_score_nodes',
    'content_reports',
    'safeguarding_cases',
    'logs',
    'setup_codes',
];

export const logging = functions.region('europe-west2')
    .firestore.document('{collection}/{id}')
    .onWrite(async (change, context) => {
        if (ignoredCollections.includes(context.params.collection) || !change.after.exists) {
            return;
        }

        const log = {
            event: 'document',
            timestamp: admin.firestore.Timestamp.now(),
            path: change.before.ref.path,
            authentication: context.authType || 'unknown',
            changes: detailedDiff(change.before.data() || {}, change.after.data() || {}),
        } as {
            [key: string]: any;
        };

        if (change.after.data()?.changeMadeBy) {
            log.uid = change.after.data()!.changeMadeBy;
        } else if (change.before.data()?.changeMadeBy) {
            log.uid = change.before.data()!.changeMadeBy;
        }

        await admin.firestore().collection('logs').add(log);
    });
