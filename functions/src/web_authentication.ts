import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import {v4 as uuid} from 'uuid';
import {randomBytes} from "crypto";
import {sha256} from "./helpers";

// called from website to start the authentication process
export const getQrCodeData = functions.region('europe-west2').https.onCall(async () => {
    const sessionId = uuid();
    const sessionSecret = randomBytes(256).toString('base64');

    await admin.firestore()
        .collection('web_auth_sessions')
        .doc(sessionId)
        .set({
            hashedSecret: sha256(sessionSecret),
            createdAt: admin.firestore.Timestamp.now(),
            ready: false,
        });

    return {
        sessionId,
        sessionSecret,
    }
});

interface QrCodeVerificationData {
    token: string;
    secret: string;
    yearGroup: number;
}

interface QrCodeVerificationResponse {
    verified: boolean;
}

// called from app when a QR code is scanned (containing the unhashed secret)
export const verifyQrCode = functions
    .region('europe-west2')
    .https
    .onCall(async (data: Partial<QrCodeVerificationData>): Promise<QrCodeVerificationResponse> => {
    if (!data.token || !data.secret || !data.yearGroup) {
        return {verified: false};
    }

    let decodedToken: admin.auth.DecodedIdToken;
    try {
        decodedToken = await admin.auth().verifyIdToken(data.token);
    } catch (e) {
        return {verified: false};
    }

    const matchingSessions = await admin.firestore()
        .collection('web_auth_sessions')
        .where('hashedSecret', '==', sha256(data.secret))
        .limit(1)
        .get();

    if (matchingSessions.empty) {
        return {verified: false};
    }

    const session = matchingSessions.docs[0];
    if (session.data().ready !== false) return {verified: false};

    const signInToken = await admin.auth().createCustomToken(decodedToken.uid);
    await admin.firestore()
        .collection('web_auth_tokens')
        .doc(session.id)
        .set({
            token: signInToken,
            yearGroup: data.yearGroup,
        });

    await session.ref.update({
        ready: true,
    });

    return {
        verified: true,
    };
});

interface RetrieveTokenData {
    sessionSecret: string;
    sessionId: string;
}

interface RetrieveTokenResponse {
    token?: string;
    yearGroup?: number;
}

// called from website once session is ready
export const retrieveSignInToken = functions
    .region('europe-west2')
    .https
    .onCall(async (data: Partial<RetrieveTokenData>): Promise<RetrieveTokenResponse> => {
    if (!data.sessionId || !data.sessionSecret) {
        return {};
    }

    const session = await admin.firestore()
        .collection('web_auth_sessions')
        .doc(data.sessionId)
        .get();

    if (!session.exists) return {};
    if (session.data()?.hashedSecret !== sha256(data.sessionSecret)) return {};

    const tokenResponse = await admin.firestore()
        .collection('web_auth_tokens')
        .doc(data.sessionId)
        .get();
    if (!tokenResponse.exists) return {};

    const token = tokenResponse.data()?.token;
    const yearGroup = tokenResponse.data()?.yearGroup;
    await tokenResponse.ref.delete();

    return {
        token,
        yearGroup,
    }
});
