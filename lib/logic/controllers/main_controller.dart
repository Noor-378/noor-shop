import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:noor_store/view/screens/category_screen.dart';
import 'package:noor_store/view/screens/favorites_screen.dart';
import 'package:noor_store/view/screens/home_screen.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  ScrollController scrollController = ScrollController();
  AdvancedDrawerController advancedDrawer = AdvancedDrawerController();
  final tabs = const [HomeScreen(), CategoryScreen(), FavoritesScreen()].obs;
  void change(index) {
    currentIndex.value = index;
    update();
  }

  final titles = ["Noor Shop", "Categories", "Favorites"].obs;
}
