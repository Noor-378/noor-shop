import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:noor_store/model/product_model.dart';

class CartController extends GetxController {
  var productMap = {};
  final storage = GetStorage();

  @override
  void onInit() {
    _loadCart();
    super.onInit();
  }

  void _loadCart() {
    List? data = storage.read("cartList");
    if (data != null) {
      for (var e in data) {
        final product = ProductModel.fromJson(e);
        productMap[product] = 1;
      }
    }
  }

  void addProductToCart(ProductModel productModel) {
    if (productMap.containsKey(productModel)) {
      productMap.remove(productModel);
    } else {
      productMap[productModel] = 1;
    }

    _saveCart();
    update();
  }

  void _saveCart() {
    storage.write("cartList", productMap.keys.map((e) => e.toJson()).toList());
  }

  bool isInCart(ProductModel product) {
    return productMap.keys.any((p) => p.id == product.id);
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
