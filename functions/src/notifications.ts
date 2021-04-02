import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface NotificationData {
    topic: string;
    title: string;
    caption: string;
    imageUrl: string;
    resourceType: number;
    resourceId: string;
    token: string;
    scope: string;
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

        if (data.scope) {
            payload.scope = data.scope;
        }

        await admin.messaging().send({
            topic: data.topic,
            data: payload,
        });
        return true;
    });
