import * as functions from "firebase-functions";
import {sha256, randomCode} from "./helpers";
import * as admin from "firebase-admin";
import {v4 as uuid} from "uuid";
import {createTransport} from "nodemailer";

interface AdminSignInData {
    token?: string;
}
export const getAdminSignInToken = functions
    .region('europe-west2')
    .https.onCall(async (data: AdminSignInData, context) => {
        if (!data.token) {
            return null;
        }

        const hashedToken = sha256(data.token);
        const response = await admin.firestore().collection('tokens')
            .doc(hashedToken)
            .get();

        if (!response.exists) {
            return null;
        }

        const ip = context.rawRequest.header('x-forwarded-for') || context.rawRequest.socket.remoteAddress;
        await admin.firestore().collection('logs').add({
            event: 'admin_authentication',
            timestamp: admin.firestore.Timestamp.now(),
            uid: hashedToken,
            ip,
        });

        return await admin.auth().createCustomToken(hashedToken, {
            adminEnabled: true,
        });
    });

interface SendEmailData {
    email?: string;
}
export const sendEmail = functions
    .region('europe-west2')
    .https.onCall(async (data: SendEmailData): Promise<string | undefined> => {
        if (!data.email || !data.email.endsWith('@mgs.org')) {
            return;
        }

        if (data.email === "store_review@mgs.org") {
            return functions.config().review.secret;
        }

        const sessionId = uuid();
        const code = randomCode(6);
        await admin.firestore()
            .collection('setup_codes')
            .doc(sessionId)
            .set({
                code,
                createdAt: admin.firestore.Timestamp.now(),
            });

        const transporter = createTransport({
            host: functions.config().smtp.host,
            port: parseInt(functions.config().smtp.port),
            auth: {
                user: functions.config().smtp.user,
                pass: functions.config().smtp.pass,
            }
        });

        try {
            await transporter.sendMail({
                from: functions.config().smtp.sender,
                sender: functions.config().smtp.sender,
                to: data.email,
                replyTo: functions.config().smtp.reply_to,
                subject: 'Confirm your email for MyMGS',
                text: `Your MyMGS setup code is ${code}`,
            });
        } catch (e) {
            return;
        }

        return sessionId;
    });

interface ConfirmEmailData {
    sessionId?: string;
    code?: string;
}
export const confirmEmail = functions
    .region('europe-west2')
    .https.onCall(async (data: ConfirmEmailData): Promise<string | undefined> => {
        if (!data.sessionId || !data.code) {
            return;
        }

        if (data.sessionId === functions.config().review.secret) {
            return admin.auth().createCustomToken(data.sessionId, {
                storeReview: true,
            });
        }

        const sessionResponse = await admin.firestore()
            .collection('setup_codes')
            .doc(data.sessionId)
            .get();

        if (!sessionResponse.exists) {
            return;
        }

        if (sessionResponse.data()?.code !== data.code) {
            return;
        }

        // delete the setup session for security
        await sessionResponse.ref.delete();

        // generate a new uuid to avoid any accidental path of association with the user's email address
        const userId = uuid();
        return admin.auth().createCustomToken(userId);
    });