import 'package:get/get.dart';

import 'package:noor_store/logic/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    // Get.lazyPut(() => CartController());
    // Get.put(CategoryController());
  }
}
