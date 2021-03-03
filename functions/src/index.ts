import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { v4 as uuid } from 'uuid';
import QRCode from 'qrcode';
import {encryptTotpKey, getCurrentToken, getPublicKey, getTotpSecret, hashAdminToken} from './helpers';
import { totp } from 'otplib';

admin.initializeApp();

interface NotificationData {
    topic: string;
    title: string;
    caption: string;
    imageUrl: string;
    resourceType: number;
    resourceId: string;
    token: string;
}

export const sendNotification = functions
    .region('europe-west2')
    .https.onCall(async (data: Partial<NotificationData>): Promise<boolean> => {
        if (!data.token || !data.title || !data.caption || !data.topic) {
            return false;
        }

        let verifiedToken: admin.auth.DecodedIdToken;
        try {
            verifiedToken = await admin.auth().verifyIdToken(data.token);
        } catch (e) {
            return false;
        }

        const userResponse = await admin.firestore()
            .collection('tokens')
            .doc(verifiedToken.uid)
            .get();

        const user = userResponse.data();
        if (!userResponse.exists || !user) return false;
        if (!user.perms.includes('notifications')) return false;

        const payload = {
            topic: data.topic,
            title: data.title,
            body: data.caption,
        } as {
            [key: string]: any;
        };

        if (data.imageUrl) {
            payload.imageUrl = data.imageUrl;
        }

        if (data.resourceId && data.resourceType) {
            payload.resourceType = data.resourceType.toString();
            payload.resourceId = data.resourceId;
        }

        await admin.messaging().send({
            topic: data.topic,
            data: payload,
        });
        return true;
    });

interface SignInTokenData {
    privateKey?: string;
}

export const getSignInToken = functions
    .region('europe-west2')
    .https.onCall(async (data: SignInTokenData) => {
        if(!data.privateKey) {
            return null;
        }

        const secret = getTotpSecret();
        if (!totp.check(data.privateKey, secret)) {
            return null;
        }

        const userId = uuid();
        return await admin.auth().createCustomToken(userId);
    });

interface AdminSignInData {
    token?: string;
}

export const getAdminSignInToken = functions
    .region('europe-west2')
    .https.onCall(async (data: AdminSignInData) => {
        if (!data.token) {
            return null;
        }

        const hashedToken = hashAdminToken(data.token);
        const response = await admin.firestore().collection('tokens')
            .doc(hashedToken)
            .get();

        if (!response.exists) {
            return null;
        }

        return await admin.auth().createCustomToken(hashedToken, {
            adminEnabled: true,
        });
    });

interface QrCodeData {
    password?: string;
}

export const getQrCode = functions
    .region('europe-west2')
    .https.onCall(async (data: QrCodeData) => {
        const password = data.password as string;

        if (!password) {
            return null;
        }

        const correctPassword = functions.config().mgsauth.sitepassword;
        if (password !== correctPassword) {
            return null;
        }

        const token = getCurrentToken();
        const [publicKey, iv] = await getPublicKey();
        const encryptedAes = encryptTotpKey(publicKey, iv, token);

        return await QRCode.toString('mymgs-privkey-' + encryptedAes, {
            width: 400,
            margin: 0,
            type: 'svg',
        });
    });
