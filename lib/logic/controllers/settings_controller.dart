import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:noor_store/utils/my_string.dart';

class SettingsController extends GetxController {
  var swithchValue = false.obs;
  var storage = GetStorage();
  var langLocal = ene;
  var userName = "";
  var userImage = "";
  var userEmail = "";

  String capitalize(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(" ");
  }

  //Language

  @override
  void onInit() async {
    super.onInit();

    userName = await storage.read("user_name");
    userEmail = await storage.read("user_email");
    userImage = await storage.read("user_image");
    langLocal = await getLanguage;
  }

  void saveLanguage(String lang) async {
    await storage.write("lang", lang);
  }

  Future<String> get getLanguage async {
    return await storage.read("lang") ?? ene;
  }

  void changeLanguage(String typeLang) {
    saveLanguage(typeLang);
    if (langLocal == typeLang) {
      return;
    }

    if (typeLang == frf) {
      langLocal = frf;
      saveLanguage(frf);
    } else if (typeLang == ara) {
      langLocal = ara;
      saveLanguage(ara);
    } else {
      langLocal = ene;
      saveLanguage(ene);
    }
    update();
  }
}
