import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/data/shop.dart';
import 'package:mymgs/data_classes/charities_shop_item.dart';
import 'package:mymgs/helpers/pricing.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/screens/shop/charities_shop_cart.dart';
import 'package:mymgs/screens/shop/charities_shop_item_preview.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/rounded_card_thumbnail.dart';
import 'package:mymgs/widgets/spinner.dart';

class CharitiesShop extends StatefulWidget {
  const CharitiesShop();
  _CharitiesShopState createState() => _CharitiesShopState();
}

class _CharitiesShopState extends State<CharitiesShop> {
  final future = CharitiesShopData.getItems();
  Map<CharitiesShopItem, int> cart = {};
  bool showIntroCover = false;

  @override
  void initState() {
    super.initState();

    getSetting<bool?>('is_charities_shop_opened')
    .then((value) {
      setState(() {
        if (value == true) {
          showIntroCover = false;
        } else {
          showIntroCover = true;
        }
      });
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
          },
          cart: cart,
        );
      }
    );
  }

  void _viewCart() {
    Navigator.of(context).push(platformPageRoute(
      context: context,
      builder: (_) => CharitiesShopCart(
        cart: cart,
        onCartUpdate: (newCart)  {
          setState(() {
            this.cart = newCart;
          });
        },
        onComplete: () {
          setState(() {
            this.cart = {};
          });
        }
      )
    ));
  }

  void _dismissIntro() async {
    setState(() {
      showIntroCover = false;
    });
    await saveSetting('is_charities_shop_opened', true);
  }

  @override
  Widget build(BuildContext context) {
    if (showIntroCover) {
      return Scaffold(
        appBar: DrawerAppBar("Introduction to Charities"),
        body: Padding(
          padding: Responsive(context).centeredSetupPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to MGS Charities!",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Our brand-new shop offers a range of convenient low-price tech, with all proceeds donated to XYZ.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Order on your phone via debit card, Apple Pay, or Google Pay, and collect at our stall within 5 days.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              MGSButton(
                label: "Start shopping!",
                onPressed: _dismissIntro,
              ),
            ],
          ),
        ),
      );
    }

    var totalProducts = 0;
    for (final itemCount in cart.values) {
      totalProducts += itemCount;
    }

    return Scaffold(
      appBar: DrawerAppBar("Charities Shop"),
      floatingActionButton: Badge(
        badgeContent: Text(
          totalProducts.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        position: BadgePosition.topEnd(end: 0, top: 0),
        animationType: BadgeAnimationType.scale,
        padding: EdgeInsets.all(8),
        child: FloatingActionButton.large(
          heroTag: "charities_shop",
          onPressed: _viewCart,
          child: Icon(Icons.shopping_basket),
        )
      ),
      body: FutureBuilder<List<CharitiesShopItem>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Spinner(),
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return Center(
              child: Text("No items found"),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: Responsive(context).horizontalListPadding),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return ListTile(
                key: Key(item.id),
                title: Text(item.name),
                subtitle: Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => _previewItem(item),

                leading: RoundedCardThumbnail(image: item.image),
                trailing: Text(
                  PricingHelpers.getDisplayPrice(item.price),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
