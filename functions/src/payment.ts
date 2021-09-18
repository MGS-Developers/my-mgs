import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import Stripe from 'stripe';
import {randomCode} from "./helpers";
const stripeTest = new Stripe(functions.config().stripe.test, {
    apiVersion: '2020-08-27',
});
const stripeLive = new Stripe(functions.config().stripe.live, {
    apiVersion: '2020-08-27',
});

interface CreatePaymentIntentRequest {
    items: {
        id: string;
        name: string;
        price: number;
        quantity: number;
    }[];
}
const createPaymentIntent = async (stripe: Stripe, data: CreatePaymentIntentRequest) => {
    let total = 0;
    let description = "";
    for (const item of data.items) {
        total += item.price * item.quantity;
        description += `${item.name} (${item.id}) x${item.quantity};`;
    }

    const paymentIntent = await stripe.paymentIntents.create({
        amount: total,
        currency: 'GBP',
        description,
    });

    const userCode = randomCode(5);
    await admin.firestore().collection('payment_confirmations')
        .add({
            userCode,
            paymentIntentId: paymentIntent.id,
        })

    return {
        secret: paymentIntent.client_secret,
        userCode,
    };
}

const region = functions.region('europe-west2').https;
export const createPaymentIntentTest = region.onCall(async (data: CreatePaymentIntentRequest) => createPaymentIntent(stripeTest, data));
export const createPaymentIntentLive = region.onCall(async (data: CreatePaymentIntentRequest) => createPaymentIntent(stripeLive, data));
