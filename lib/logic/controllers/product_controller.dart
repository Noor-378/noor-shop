import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/services/product_services.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
  var productModel = <ProductModel>[].obs;
  var isLeading = true.obs;
  void getProducts() async {
    
    var product = await ProductServices.getProduct();
    // try{}finally{}  // enter the finally after finishing the try
    // try{}catch(e){} // enter the catch if the try have any error
    try {
      isLeading(true);
      if (product.isNotEmpty) {
        productModel.addAll(product);
      }
    } finally {
      isLeading(false);
    }
  }
}
