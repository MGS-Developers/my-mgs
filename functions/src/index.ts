import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { v4 as uuid } from 'uuid';
import QRCode from 'qrcode';
import { encryptTotpKey, getCurrentToken, getPublicKey, getTotpSecret } from './helpers';
import { totp } from 'otplib';

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

        const secret = getTotpSecret();
        if (!totp.check(data.privateKey, secret)) {
            return null;
        }

        const userId = uuid();
        return await admin.auth().createCustomToken(userId);
    });

export const getQrCode = functions
    .region('europe-west2')
    .https.onRequest(async (req, res) => {
        const password = req.query.password as string;

        if (!password) {
            res.status(400).send('Please provide the `password` parameter');
            return;
        }

        const correctPassword = functions.config().mgsauth.sitepassword;
        if (password !== correctPassword) {
            res.status(403).send('Incorrect password');
            return;
        }

        const token = getCurrentToken();
        const [publicKey, iv] = await getPublicKey();

        const encryptedAes = encryptTotpKey(publicKey, iv, token);

        const qrCode = await QRCode.toBuffer('mymgs-privkey-' + encryptedAes);
        res.end(qrCode, 'binary');
    });
