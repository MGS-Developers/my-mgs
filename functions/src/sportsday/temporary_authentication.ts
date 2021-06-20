import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
import {v4 as uuid} from 'uuid'

export const sportsDayTemporaryAuth = functions.region('europe-west2').https.onCall(() => {
    const id = 'sd-' + uuid()
    return admin.auth().createCustomToken(id, { isSportsDayUser: true })
})
