import * as admin from 'firebase-admin';

admin.initializeApp();

export {sendNotification} from './notifications';
export {getAdminSignInToken, confirmEmail, sendEmail} from './authentication';
export {sdPropagateScore, sdCalculateFormPosition, sdTestBrokenRecord} from './sportsday/sportsday';
export {getSendingSecret, studentSendMessage} from './safeguarding';
export {getQrCodeData, verifyQrCode, retrieveSignInToken} from './web_authentication';
export {cleanup} from './cleanup';
export {sportsDayTemporaryAuth} from './sportsday/temporary_authentication'
export {
    createPaymentIntentLive,
    createPaymentIntentTest,
    getPaymentIntentLive,
    getPaymentIntentTest,
    refundPaymentIntentLive,
    refundPaymentIntentTest,
    togglePaymentFulfillment,
} from './payment'
