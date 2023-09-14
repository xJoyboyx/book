import 'package:in_app_purchase/in_app_purchase.dart';

Future<List<ProductDetails>> fetchIAPDetails() async {
  const Set<String> _kIds = {'theme2_pixels'};
  final response = await InAppPurchase.instance.queryProductDetails(_kIds);
  return response.productDetails;
}
