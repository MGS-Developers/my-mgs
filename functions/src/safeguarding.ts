import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import {randomBytes} from 'crypto';
import {sha256} from "./helpers";

interface SendingSecretRequest {
    caseId?: string;
}

export const getSendingSecret = functions.region('europe-west2').https
    .onCall(async (data: SendingSecretRequest, context): Promise<string | null> => {
        if (data.caseId == null || context.auth == null) return null;

        const secretDoc = admin.firestore()
            // this collection is not covered by any security rules, meaning only admin clients can read/write
            .collection('safeguarding_secrets')
            .doc(data.caseId);

        const newSecret = randomBytes(256).toString('base64');
        let secretAlreadyExists = false;

        // runs inside a transaction to prevent duplication while a query is running
        await admin.firestore().runTransaction(async transaction => {
            const existingSecretResponse = await transaction.get(secretDoc);
            if (existingSecretResponse.exists) {
                secretAlreadyExists = true;
                return;
            }

            await transaction.set(secretDoc, {
                secret: sha256(newSecret),
            });
        });

        if (secretAlreadyExists) {
            return null;
        } else {
            return newSecret;
        }
    });

interface SendMessageRequest {
    caseId?: string;
    encryptedMessage?: string;
    secret?: string;
    messageId?: string;
}

export const studentSendMessage = functions.region('europe-west2').https
    .onCall(async (data: SendMessageRequest, context): Promise<boolean> => {
        if (
            data.caseId == null ||
            data.encryptedMessage == null ||
            data.secret == null ||
            data.messageId == null ||
            context.auth == null
        ) {
            return false;
        }

        const secretResponse = await admin.firestore()
            .collection('safeguarding_secrets')
            .doc(data.caseId)
            .get();
        if (!secretResponse.exists || secretResponse.data()?.secret !== sha256(data.secret)) {
            return false;
        }

        await admin.firestore()
            .collection('safeguarding_cases')
            .doc(data.caseId)
            .collection('messages')
            .doc(data.messageId)
            .set({
                caseId: data.caseId,
                recipientIsStudent: false,
                sentAt: admin.firestore.Timestamp.now(),
                message: data.encryptedMessage,
            });

        return true;
    });
