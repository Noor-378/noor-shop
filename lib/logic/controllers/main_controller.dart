import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:noor_store/view/screens/cart_screen.dart';
import 'package:noor_store/view/screens/category_screen.dart';
import 'package:noor_store/view/screens/favorites_screen.dart';
import 'package:noor_store/view/screens/home_screen.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  ScrollController scrollController = ScrollController();
  AdvancedDrawerController advancedDrawer = AdvancedDrawerController();

  late RxList<Widget> tabs;
  final titles = ["Noor Shop", "Categories", "Favorites", "Cart"].obs;

  @override
  void onInit() {
    super.onInit();

    // ✅ initialize after scrollController is created
    tabs =
        [
          HomeScreen(),
          const CategoryScreen(),
          const FavoritesScreen(),
          CartScreen(),
        ].obs;
  }

  void changeIndex(index) {
    currentIndex.value = index;
    update();
  }
}
