import forge from "node-forge";
import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
import { totp } from 'otplib';
import shajs from "sha.js";

export const getPublicKey = async (): Promise<[forge.util.ByteStringBuffer, forge.util.ByteStringBuffer]> => {
    const config = await admin.remoteConfig().getTemplate();
    const key = config.parameters['enrollment_public_key'].defaultValue as admin.remoteConfig.ExplicitParameterValue;
    const iv = config.parameters['enrollment_iv'].defaultValue as admin.remoteConfig.ExplicitParameterValue;
    const bufferIV = forge.util.createBuffer(iv.value, 'utf8');
    const bufferKey = forge.util.createBuffer(key.value, 'utf8');
    return [bufferKey, bufferIV];
}

export const getTotpSecret = (): string => {
    return functions.config().mgsauth.totpsecret;
}

export const getCurrentToken = () => {
    const totpSecret = getTotpSecret();
    return totp.generate(totpSecret);
}

export const encryptTotpKey = (
    publicKey: forge.util.ByteStringBuffer,
    iv: forge.util.ByteStringBuffer,
    token: string,
): string => {
    const cipher = forge.cipher.createCipher('AES-CBC', publicKey);
    cipher.start({iv});
    cipher.update(
        forge.util.createBuffer(token, 'utf8'),
    );
    cipher.finish();
    const encryptedAes = cipher.output.toHex();

    return Buffer.from(encryptedAes, 'hex').toString('base64');
}

export const hashAdminToken = (token: string): string => {
    return shajs('sha256').update(token).digest('hex');
}
