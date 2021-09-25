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
const region = functions.region('europe-west2').https;

const ensurePermission = async (context: functions.https.CallableContext) => {
    const uid = context.auth?.uid;
    if (!uid) {
        return false;
    }

    const token = await admin.firestore().collection('tokens').doc(uid).get();
    if (!token.exists) {
        return false;
    }

    return token.data()!.perms.includes('charity_shop_orders');
}

interface CreatePaymentIntentRequest {
    items: {
        id: string;
        name: string;
        price: number;
        quantity: number;
    }[];
}
const createPaymentIntent = async (test: boolean, stripe: Stripe, data: CreatePaymentIntentRequest) => {
    const items = data.items.filter(e => e.quantity > 0);

    let total = 0;
    let description = "";
    for (const item of items) {
        total += item.price * item.quantity;
        description += `${item.name} (${item.id}) x${item.quantity}; `;
    }

    const paymentIntent = await stripe.paymentIntents.create({
        amount: total,
        currency: 'GBP',
        description,
    });

    const userCode = randomCode(5);
    await admin.firestore().collection('payment_confirmations')
        .add({
            createdAt: admin.firestore.Timestamp.now(),
            userCode,
            paymentIntentId: paymentIntent.id,
            items: items.map(e => {
                return {
                    id: e.id,
                    quantity: e.quantity,
                }
            }),
            total,
            test,
            fulfilled: false,
        })

    return {
        secret: paymentIntent.client_secret,
        userCode,
    };
}
export const createPaymentIntentTest = region.onCall((data: CreatePaymentIntentRequest) => createPaymentIntent(true, stripeTest, data));
export const createPaymentIntentLive = region.onCall((data: CreatePaymentIntentRequest) => createPaymentIntent(false, stripeLive, data));

const getPaymentIntent = async (context: functions.https.CallableContext, stripe: Stripe, id: string) => {
    if (!(await ensurePermission(context))) {
        return null;
    }

    const paymentIntent = await stripe.paymentIntents.retrieve(id);
    let cardLast4: string | undefined = undefined;
    if (paymentIntent.charges.data.length > 0) {
        cardLast4 = paymentIntent.charges.data[0].payment_method_details?.card?.last4 ?? undefined;
    }

    const refunds = await stripe.refunds.list({
        payment_intent: paymentIntent.id,
    })
    const refunded = refunds.data.length > 0;

    return {
        paid: paymentIntent.status === "succeeded" && !refunded,
        status: paymentIntent.status,
        total: paymentIntent.amount,
        cardLast4,
        refunded,
    }
}
export const getPaymentIntentTest = region.onCall((data: string, context) => getPaymentIntent(context, stripeTest, data));
export const getPaymentIntentLive = region.onCall((data: string, context) => getPaymentIntent(context, stripeLive, data));

export const togglePaymentFulfillment = region.onCall(async (orderId: string, context) => {
    if (!(await ensurePermission(context))) {
        return false;
    }

    const order = await admin.firestore().collection('payment_confirmations')
        .doc(orderId)
        .get();
    if (!order.exists) {
        return false;
    }

    await admin.firestore().collection('payment_confirmations')
        .doc(orderId)
        .update({
            fulfilled: !order.data()!.fulfilled,
        });
    return true;
});

const refundPaymentIntent = async (context: functions.https.CallableContext, stripe: Stripe, id: string) => {
    if (!(await ensurePermission(context))) {
        return false;
    }

    await stripe.refunds.create({
        payment_intent: id,
        reason: 'requested_by_customer',
    });

    return true;
}
export const refundPaymentIntentTest = region.onCall((id: string, context) => refundPaymentIntent(context, stripeTest, id));
export const refundPaymentIntentLive = region.onCall((id: string, context) => refundPaymentIntent(context, stripeLive, id));
