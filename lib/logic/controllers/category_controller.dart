import 'package:get/get.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/services/category_services.dart';

class CategoryController extends GetxController {
  var categoryNameList = <String>[].obs;
  var categoryList = <ProductModel>[].obs;

  var isCatgeoryLoading = false.obs;
  var isAllCategory = false.obs;

  List<String> imageCategory = <String>[].obs;

  final Map<String, String> categoryImages = {
    "electronics":
        "https://images.unsplash.com/photo-1518770660439-4636190af475",
    "jewelery": "https://images.unsplash.com/photo-1515562141207-7a88fb7ce338",
    "men's clothing":
        "https://images.unsplash.com/photo-1521334884684-d80222895322",
    "women's clothing":
        "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  };

  @override
  void onInit() {
    super.onInit();
    getCategorys();
  }

  void getCategorys() async {
    var categoryName = await CategoryServices.getCategory();

    try {
      isCatgeoryLoading(true);

      if (categoryName.isNotEmpty) {
        categoryNameList.assignAll(categoryName);

        imageCategory.assignAll(
          categoryName
              .map(
                (e) =>
                    categoryImages[e] ??
                    "https://via.placeholder.com/600x400?text=Category",
              )
              .toList(),
        );
      }
    } finally {
      isCatgeoryLoading(false);
    }
  }

  getAllCategorys(String namecategory) async {
    isAllCategory(true);
    categoryList.value = await AllCategorySercvises.getAllCatehory(
      namecategory,
    );
    isAllCategory(false);
  }

  getCategoryIndex(int index) async {
    await getAllCategorys(categoryNameList[index]);
  }
}
