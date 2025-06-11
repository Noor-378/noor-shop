import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
