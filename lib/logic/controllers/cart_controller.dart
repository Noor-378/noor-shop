import 'package:get/get.dart';
import 'package:noor_store/model/product_model.dart';

class CartController extends GetxController {
  var productMap = {};

  void addProductToCart(ProductModel productModel) {
    if (productMap.containsKey(productModel)) {
      productMap[productModel] += 1;
      productMap.entries
          .map((e) => e.key.price * e.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);
      update();
    } else {
      productMap[productModel] = 1;
      update();
    }
  }

  bool isInCart(ProductModel product) {
    return productMap.containsKey(product);
  }

  void removeOneProductFromCart(ProductModel productModel) {
    productMap.removeWhere((key, value) => key == productModel);
    update();
  }

  void removeProductsFromCart(ProductModel productModel) {
    if (productMap.containsKey(productModel) && productMap[productModel] == 1) {
      productMap.removeWhere((key, value) => key == productModel);
      update();
    } else {
      productMap[productModel] -= 1;
      update();
    }
  }

  void clearAllProducts() {
    productMap.clear();
    update();
  }

  get productPrice =>
      productMap.entries.map((e) => e.key.price * e.value).toList();
  String get productsSubTotal {
    if (productMap.isEmpty) return "0.00";

    final total = productMap.entries
        .map((e) => e.key.price * e.value)
        .fold(0.0, (sum, element) => sum + element);

    return total.toStringAsFixed(2);
  }
}
