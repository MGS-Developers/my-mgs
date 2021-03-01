// linearly interpolate between two boundaries and a value
// lower/upper input bounds: y1/y2
// lower/upper output bounds: x1/x2
// input value: x
import 'dart:convert';
import 'dart:math';

double lerp(double y1, double y2, double x1, double x2, double x) {
  if (x > x2) return y2;
  if (x < x1) return y1;

  return y1 + (y2 - y1) / (x2 - x1) * (x - x1);
}

String randomHeroKey() {
  final random = Random();
  final values = List.generate(10, (index) => random.nextInt(255));
  return base64UrlEncode(values);
}
