import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/services/product_services.dart';

class ProductController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    getProducts();
    _loadFavorites();
    tabController = TabController(length: 2, vsync: this);

    super.onInit();
  }

  void _loadFavorites() {
    List? data = storage.read("isFavoritesList");
    if (data != null) {
      favoritesList.value = data.map((e) => ProductModel.fromJson(e)).toList();
    }
  }

  var productModel = <ProductModel>[].obs;
  var favoritesList = <ProductModel>[].obs;
  var storage = GetStorage();
  var isLoading = true.obs;
  void getProducts() async {
    var product = await ProductServices.getProduct();
    // try{}finally{}  // enter the finally after finishing the try
    // try{}catch(e){} // enter the catch if the try have any error
    try {
      isLoading(true);
      update();
      if (product.isNotEmpty) {
        productModel.addAll(product);
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  void manageFavorites(int productId) async {
    var existingIndex = favoritesList.indexWhere(
      (element) => element.id == productId,
    );
    if (existingIndex >= 0) {
      favoritesList.removeAt(existingIndex);
      await storage.remove("isFavoritesList");
    } else {
      favoritesList.add(
        productModel.firstWhere((element) => element.id == productId),
      );
      storage.write(
        "isFavoritesList",
        favoritesList.map((e) => e.toJson()).toList(),
      );
    }
    isFavorites(productId);
  }

  bool isFavorites(int productId) {
    return favoritesList.any((element) => element.id == productId);
  }

  var isGridView = true.obs;
  toggleGrid() {
    isGridView.value = !isGridView.value;
    update();
  }
}
