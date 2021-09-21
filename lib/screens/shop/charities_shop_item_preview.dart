import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/charities_shop_item.dart';
import 'package:mymgs/helpers/pricing.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/icon_button.dart';
import 'package:mymgs/widgets/nullable_image.dart';

typedef CartUpdateFunc = void Function(Map<CharitiesShopItem, int> cart);
class CharitiesShopItemPreview extends StatefulWidget {
  final CharitiesShopItem item;
  final CartUpdateFunc onCartUpdate;
  final Map<CharitiesShopItem, int> cart;
  const CharitiesShopItemPreview({
    required this.item,
    required this.onCartUpdate,
    required this.cart,
  });
  _CharitiesShopItemPreviewState createState() => _CharitiesShopItemPreviewState();
}

class _CharitiesShopItemPreviewState extends State<CharitiesShopItemPreview> {
  late int quantity;
  @override
  void initState() {
    super.initState();
    quantity = widget.cart[widget.item] ?? 0;
  }

  Map<CharitiesShopItem, int> _cloneCart() {
    return Map<CharitiesShopItem, int>.from(widget.cart);
  }

  void _removeItem() {
    final cart = _cloneCart();
    if (cart.containsKey(widget.item) && quantity > 0) {
      cart[widget.item] = quantity - 1;
      setState(() {
        quantity--;
      });
      widget.onCartUpdate(cart);
    }
  }

  void _addItem() {
    if (quantity >= 5) {
      return;
    }

    final cart = _cloneCart();
    cart[widget.item] = quantity + 1;
    setState(() {
      quantity++;
    });
    widget.onCartUpdate(cart);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive(context).horizontalReaderPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: NullableImage(
                    image: item.image,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 5),
                Text(
                  PricingHelpers.getDisplayPrice(item.price),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyText1,
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    MGSIconButton(
                      icon: Icons.remove,
                      tooltip: "Remove",
                      onPressed: _removeItem,
                    ),
                    Expanded(
                      child: Text(
                        quantity.toString(),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MGSIconButton(
                      icon: Icons.add,
                      tooltip: "Add to Cart",
                      onPressed: _addItem,
                    )
                  ],
                ),
              ],
            ),
          ),
        )],
      ),
    );
  }
}
