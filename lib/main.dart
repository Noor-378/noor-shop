import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/auth_controller.dart';
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/utils/themes/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController());

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
      // darkTheme: DarkTheme.dark,
      // home: const WelcomeScreen(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.routes,
    );
  }
}
