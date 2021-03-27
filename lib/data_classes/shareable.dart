import 'package:mymgs/data/sharing.dart';
import 'package:mymgs/helpers/deep_link.dart';

mixin Shareable {
  late DeepLinkResource resource;
  late String id;

  Future<void> share() => shareShareable(this);
}
