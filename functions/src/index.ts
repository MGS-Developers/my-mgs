import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { v4 as uuid } from 'uuid';

admin.initializeApp();

interface SignInTokenData {
    privateKey?: string;
}

export const getSignInToken = functions
    .region('europe-west2')
    .https.onCall(async (data: SignInTokenData) => {
        if(!data.privateKey) {
            return null;
        }

        const validPrivateKey: string = functions.config().mgsauth.privkey;
        if (data.privateKey !== validPrivateKey) {
            return null;
        }

        const userId = uuid();
        return await admin.auth().createCustomToken(userId);
    });
