import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:noor_store/logic/controllers/auth_controller.dart';
import 'package:noor_store/logic/controllers/cart_controller.dart';
import 'package:noor_store/logic/controllers/theme_controller.dart';
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/utils/themes/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  await GetStorage.init();

  Get.put(AuthController());
    Get.put(CartController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: ThemeData(
      //   useMaterial3: false,
      //   colorSchemeSeed:
      //       Get.isDarkMode
      //           ? LightAppColors.secondColor
      //           : LightAppColors.mainColor,
      // ),
      theme: LightTheme.light,
      themeMode: ThemeController().themeDataGet,
      // darkTheme: DarkTheme.dark,
      // home: const WelcomeScreen(),
      initialRoute:
          FirebaseAuth.instance.currentUser != null ||
                  GetStorage().read<bool>("auth") == true
              ? AppRoutes.mainSreen
              : AppRoutes.welcome,
      getPages: AppRoutes.routes,
    );
  }
}
