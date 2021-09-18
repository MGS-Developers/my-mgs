import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mymgs/data/shop.dart';
import 'package:mymgs/data_classes/charities_shop_item.dart';
import 'package:mymgs/helpers/pricing.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/screens/shop/charities_shop_complete.dart';
import 'package:mymgs/screens/shop/charities_shop_item_preview.dart';
import 'package:mymgs/widgets/button.dart';

class CharitiesShopCart extends StatefulWidget {
  final Map<CharitiesShopItem, int> cart;
  final CartUpdateFunc onCartUpdate;
  final VoidCallback onComplete;
  const CharitiesShopCart({
    Key? key,
    required this.cart,
    required this.onCartUpdate,
    required this.onComplete,
  });

  _CharitiesShopCartState createState() => _CharitiesShopCartState();
}

class _CharitiesShopCartState extends State<CharitiesShopCart> {
  late Map<CharitiesShopItem, int> cart;
  @override
  void initState() {
    super.initState();
    setState(() {
      cart = Map<CharitiesShopItem, int>.from(widget.cart);
    });
  }

  void _previewItem(CharitiesShopItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return CharitiesShopItemPreview(
          item: item,
          onCartUpdate: (newCart) {
            setState(() {
              this.cart = newCart;
            });
            widget.onCartUpdate(newCart);
          },
          cart: cart,
        );
      }
    );
  }

  bool loading = false;
  Future<void> _checkout() async {
    setState(() {
      loading = true;
    });

    final paymentDetails = await CharitiesShopData.initialisePayment(cart);

    Stripe.publishableKey = kReleaseMode ? "pk_live_51HPO0pAX0ZOeVncMw6tMyIknpgulhkRW9HFk6t0yRTL2uT66zTG3ni6FwRNUNgzFCvZHkhnJ7VhNpWjygFcveL8E004fI2jZr1"
        : "pk_test_51HPO0pAX0ZOeVncMCKt0vqAi2SjCaIls4e5fCW9j9W7y3HpUe81IxXnZfBnA47nPebF7hf3ZNQE00tz3uEeA9P1X001wv0ouIU";
    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      applePay: true,
      googlePay: true,
      testEnv: !kReleaseMode,
      merchantCountryCode: 'GB',
      merchantDisplayName: "MGS Charities Store",
      paymentIntentClientSecret: paymentDetails.secret,
    ));

    try {
      await Stripe.instance.presentPaymentSheet();
      widget.onComplete();
      Navigator.of(context).pushReplacement(platformPageRoute(
        context: context,
        builder: (_) => CharitiesShopComplete(userCode: paymentDetails.userCode),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong! You haven't been charged."),
        duration: Duration(seconds: 5),
      ));
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nonEmptyList = cart.entries.where((e) => e.value > 0);
    var total = 0;
    for (final data in nonEmptyList) {
      total += data.key.price * data.value;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping cart"),
      ),
      body: nonEmptyList.length == 0 ?
        Center(
          child: Text(
            "Your cart is empty.",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).horizontalReaderPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: nonEmptyList.length,
              itemBuilder: (context, index) {
                final data = nonEmptyList.elementAt(index);
                final item = data.key, quantity = data.value;

                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("x" + quantity.toString()),
                  trailing: Text(
                    PricingHelpers.getDisplayPrice(quantity * item.price),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () => _previewItem(item),
                  enabled: !loading,
                );
              },
            ),

            const SizedBox(height: 15),
            Text(
              "Total: " + PricingHelpers.getDisplayPrice(total),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 15),
            Text(
              "After paying, you'll be given a code you can take to our collection point at XYZ at any time.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 5),
            MGSButton(
              label: "Checkout",
              onPressed: _checkout,
              enabled: !loading,
            ),
          ],
        ),
      ),
    );
  }
}
