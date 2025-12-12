import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/utils/my_string.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';

class ProductServices {
  // List<ProductModel>? noor;
  static Future<List<ProductModel>> getProduct() async {
    var response = await http.get(Uri.parse("$baseUrl/products"));
    log("$baseUrl/products: ${response.statusCode} : ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return productModelFromJson(jsonData);
    } else {
      customGetSnackbar(
        title: "Error",
        messageText: "Somthing went wrong ${response.statusCode}",
      );
      return throw Exception(
        "error: status Code: ${response.statusCode}\n response: $response ",
      );
    }
  }
}
// https://fakestoreapi.com/products