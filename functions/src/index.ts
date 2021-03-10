import * as admin from 'firebase-admin';
import { getAdminSignInToken, confirmEmail, sendEmail } from './authentication';
import { sendNotification } from './notifications';
import { sdPropagateScore } from './sportsday/sportsday';

admin.initializeApp();

export {sendNotification};
export {getAdminSignInToken, confirmEmail, sendEmail};
export {sdPropagateScore};