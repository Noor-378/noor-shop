import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:noor_store/logic/bindings/auth_binding.dart';
import 'package:noor_store/logic/bindings/main_binding.dart';
import 'package:noor_store/logic/bindings/product_binding.dart';
import 'package:noor_store/view/screens/auth/forget_password_screen.dart';
import 'package:noor_store/view/screens/auth/login_screen.dart';
import 'package:noor_store/view/screens/auth/signup_screen.dart';
import 'package:noor_store/view/screens/main_screen.dart';
import 'package:noor_store/view/screens/welcome_screen.dart';

class AppRoutes {
  //initialRoute

  static const welcome = Routes.welcomeScreen;
  static const mainSreen = Routes.mainScreen;
  //getPages

  static final routes = [
    GetPage(name: Routes.welcomeScreen, page: () => const WelcomeScreen()),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.singupScreen,
      page: () => SignupScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [AuthBinding(), MainBinding(), ProductBinding()],
    ),
  ];
}

class Routes {
  static const String welcomeScreen = "/welcomeScreen";
  static const String loginScreen = "/loginScreen";
  static const String singupScreen = "/singupScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String mainScreen = "/mainScreen";
  static const String settingsScreen = "/settingsScreen";
}
