import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:noor_store/model/category_model.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/utils/my_string.dart';

class CategoryServices {
  static Future<List<String>> getCategory() async {
    var response = await http.get(Uri.parse('$baseUrl/products/categories'));
    log("$baseUrl/products/categories/ ${response.body}");

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return categoryModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load product");
    }
  }
}

class AllCategorySercvises {
  static Future<List<ProductModel>> getAllCatehory(String categoryNames) async {
    var response = await http.get(
      Uri.parse('$baseUrl/products/category/$categoryNames'),
    );
    log("message'$baseUrl/products/category/$categoryNames");

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return productModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load product");
    }
  }
}
