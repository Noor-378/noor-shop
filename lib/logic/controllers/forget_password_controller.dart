import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController forgetPasswordController = TextEditingController();
  bool mainButton = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  void showMainButtonFunction() {
    void checkFields() {
      if (forgetPasswordController.text.isNotEmpty) {
        mainButton = true;
      } else {
        mainButton = false;
      }
      update();
    }

    forgetPasswordController.addListener(checkFields);
  }

  @override
  void onInit() {
    showMainButtonFunction();
    super.onInit();
  }

  void resetPassword() async {
    try {
      await auth.sendPasswordResetEmail(
        email: forgetPasswordController.text.trim(),
      );
      Get.back();
      customGetSnackbar(
        title: "Password Reset Email Sent",
        messageText: "Please check your inbox to reset your password.",
      );
    } on FirebaseAuthException catch (e) {
      String title = "";
      String message = "";
      if (e.code == 'user-not-found') {
        title = "User Not Found";
        message = "No user found for that email.";
      } else {
        title = e.code;
        message = e.message.toString();
      }

      customGetSnackbar(title: title, messageText: message);
    }
  }
}
