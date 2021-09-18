class PricingHelpers {
  static String getDisplayPrice(int decimalPrice) {
    return "£" + (decimalPrice / 100).toStringAsFixed(2);
  }
}
