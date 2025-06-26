import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:noor_store/model/facebook_model.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/routes/routes.dart';

class AuthController extends GetxController {
  // Common Controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final singupUserNameController = TextEditingController();
  final singupEmailController = TextEditingController();
  final singupPasswordController = TextEditingController();
  final forgetPasswordEmailController = TextEditingController();

  // Common States
  bool obscureText = true;
  bool obscureEye = false;
  bool keepMeLogin = true;
  bool loginMainButton = false;
  bool singupMainButton = false;
  bool forgetPasswordMainButton = false;

  // Firebase
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookModel? facebookModel;

  String displayUserName = '';
  String displayUserImage = '';

  @override
  void onInit() {
    setupListenersForLogin();
    setupListenersForSingup();
    setupListenersForForgetPassword();
    super.onInit();
  }

  void setupListenersForLogin() {
    loginEmailController.addListener(checkFieldsForLogin);
    loginPasswordController.addListener(checkFieldsForLogin);
  }

  void checkFieldsForLogin() {
    loginMainButton =
        loginEmailController.text.isNotEmpty &&
        loginPasswordController.text.isNotEmpty;

    obscureEye = loginPasswordController.text.isNotEmpty;
    update();
  }

  void setupListenersForSingup() {
    singupEmailController.addListener(checkFieldsForSingup);
    singupPasswordController.addListener(checkFieldsForSingup);
    singupUserNameController.addListener(checkFieldsForSingup);
  }

  void checkFieldsForSingup() {
    singupMainButton =
        singupEmailController.text.isNotEmpty &&
        singupPasswordController.text.isNotEmpty &&
        singupUserNameController.text.isNotEmpty;

    obscureEye = singupPasswordController.text.isNotEmpty;
    update();
  }

  void setupListenersForForgetPassword() {
    forgetPasswordEmailController.addListener(checkFieldsForForgetPassword);
  }

  void checkFieldsForForgetPassword() {
    forgetPasswordMainButton = forgetPasswordEmailController.text.isNotEmpty;

    update();
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    update();
  }

  void toggleKeepMeLogin() {
    keepMeLogin = !keepMeLogin;
    update();
  }

  void signupUsingFirebase() async {
    // ignore: unused_local_variable
    String name = singupUserNameController.text.trim();
    String email = singupEmailController.text.trim();
    String password = singupPasswordController.text;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            displayUserName = name;
            auth.currentUser!.updateDisplayName(displayUserName);
          });
      final user = FirebaseAuth.instance.currentUser;

      Get.offNamed(Routes.loginScreen);
      user!.sendEmailVerification();
      customGetSnackbar(
        title: "Verification",
        messageText: "Please check your inbox to Verify your email.",
      );
    } on FirebaseAuthException catch (e) {
      String title = "";
      // String title = e.code.replaceAll(RegExp("-"), " "); // to remove the -
      String message = "";
      if (e.code == 'weak-password') {
        title = "Weak Password";
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        title = "Email Already Registered";
        message = 'The account already exists for that email.';
      } else {
        title = e.code;
        message = e.message.toString();
      }
      customGetSnackbar(title: title, messageText: message);
      update();
    } catch (e) {
      customGetSnackbar(title: "Error!", messageText: e.toString());
    }
  }

  Future<void> loginUsingFirebase() async {
    try {
      final email = loginEmailController.text.trim();
      final password = loginPasswordController.text;

      await auth.signInWithEmailAndPassword(email: email, password: password);

      if (!auth.currentUser!.emailVerified) {
        customGetSnackbar(
          title: "Verification",
          messageText: "Check your inbox to verify your email.",
        );
        return;
      }

      Get.offAllNamed(Routes.mainScreen);
      customGetSnackbar(
        title: "Welcome Back",
        messageText: "Login successful!",
      );
    } on FirebaseAuthException catch (e) {
      final msg = _handleAuthError(e);
      customGetSnackbar(title: msg['title']!, messageText: msg['message']!);
    }
  }

  Future<void> resetPassword() async {
    try {
      await auth.sendPasswordResetEmail(
        email: forgetPasswordEmailController.text.trim(),
      );
      Get.back();
      customGetSnackbar(
        title: "Reset Email Sent",
        messageText: "Check your inbox.",
      );
    } on FirebaseAuthException catch (e) {
      final msg = _handleAuthError(e);
      customGetSnackbar(title: msg['title']!, messageText: msg['message']!);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        customGetSnackbar(
          title: "Somthing went wrong",
          messageText: "Please pick an account",
        );
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      displayUserName = googleUser.displayName ?? '';
      displayUserImage = googleUser.photoUrl ?? '';

      await auth.signInWithCredential(credential);
      Get.offAllNamed(Routes.mainScreen);
      customGetSnackbar(
        title: "Welcome!",
        messageText: "Hello, $displayUserName!",
      );
    } catch (e) {
      customGetSnackbar(
        title: "Google Sign-In Failed",
        messageText: e.toString(),
      );
    }
  }

  Future<void> signInWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final data = await FacebookAuth.instance.getUserData();
      facebookModel = FacebookModel.fromJson(data);

      displayUserName = facebookModel?.name ?? '';
      displayUserImage = facebookModel?.picture?.url ?? '';

      final credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );

      // ✅ Ask user before continuing
      final confirm = await Get.defaultDialog<bool>(
        title: "Continue as $displayUserName?",
        middleText: "Do you want to sign in with this Facebook account?",
        textConfirm: "Yes",
        textCancel: "No",
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.white,
        backgroundColor: Get.isDarkMode ? scaffoldDarkColor : whiteColor,
        buttonColor: Get.isDarkMode ? secondColor : mainColor,
        contentPadding: const EdgeInsets.all(25),
        onConfirm: () => Get.back(result: true),
      );

      if (confirm == true) {
        // ✅ Proceed with Firebase login
        await auth.signInWithCredential(credential);
        await auth.currentUser!.updateDisplayName(displayUserName);
        await auth.currentUser!.updatePhotoURL(displayUserImage);

        Get.offAllNamed(Routes.mainScreen);
        customGetSnackbar(
          title: "Welcome!",
          messageText: "Hello, $displayUserName!",
        );
      } else {
        customGetSnackbar(
          title: "Cancelled",
          messageText: "Login was cancelled.",
        );
      }
    } else {
      customGetSnackbar(
        title: "Facebook Sign-In Failed",
        messageText: "Try again.",
      );
    }
  }

  Map<String, String> _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return {'title': 'Weak Password', 'message': 'Password is too weak.'};
      case 'email-already-in-use':
        return {'title': 'Email Exists', 'message': 'Use a different email.'};
      case 'user-not-found':
        return {'title': 'User Not Found', 'message': 'Check your email.'};
      case 'wrong-password':
        return {'title': 'Wrong Password', 'message': 'Check your password.'};
      default:
        return {
          'title': e.code,
          'message': e.message ?? 'Authentication error',
        };
    }
  }
}
