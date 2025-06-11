import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noor_store/model/facebook_model.dart';
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  bool keepMeLogin = true;
  bool mainButton = false;
  bool obscureEye = false;
  String displayUserName = "";
  String displayUserImage = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  FacebookModel? facebookModel;

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ignore: avoid_print
        print(
          '=============================User is currently signed out!=============================',
        );
      } else {
        // ignore: avoid_print
        print(
          '=============================User is signed in!=============================',
        );
      }
    });
    showObscureEyeFunction();
    showMainButtonFunction();
    super.onInit();
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    update();
  }

  void toggleKeepMeLogin() {
    keepMeLogin = !keepMeLogin;
    update();
  }

  void showMainButtonFunction() {
    void checkFields() {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        mainButton = true;
      } else {
        mainButton = false;
      }
      update();
    }

    emailController.addListener(checkFields);
    passwordController.addListener(checkFields);
  }

  void showObscureEyeFunction() {
    void checkFields() {
      if (passwordController.text.isNotEmpty) {
        obscureEye = true;
      } else {
        obscureEye = false;
      }
      update();
    }

    passwordController.addListener(checkFields);
  }

  void loginUsingFirebase() async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            displayUserName = auth.currentUser!.displayName.toString();
          });
      Get.offAllNamed(Routes.mainScreen);
      customGetSnackbar(
        title: "Welcome Back!",
        messageText: "Glad to see you again, $displayUserName!",
      );
    } on FirebaseAuthException catch (e) {
      String title = "";
      String message = "";
      if (e.code == 'user-not-found') {
        title = "User Not Found";
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        title = "Incorrect Password";
        message =
            "The password you entered is incorrect. Tap 'Forgot Password' to reset.";
      } else {
        title = e.code;
        message = e.message.toString();
      }

      customGetSnackbar(title: title, messageText: message);
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        customGetSnackbar(
          title: "Faild to Login",
          messageText: "Please pick an account",
        );
        return;
      }
      displayUserName = googleUser.displayName!;
      displayUserImage = googleUser.photoUrl!;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      customGetSnackbar(
        title: "Welcome Back!",
        messageText: "Glad to see you again, $displayUserName!",
      );
      Get.offAllNamed(Routes.mainScreen);
    } catch (e) {
      customGetSnackbar(
        title: "Somthing went wrong",
        messageText: e.toString(),
      );
    }
  }

  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      final data = await FacebookAuth.instance.getUserData();
      facebookModel = FacebookModel.fromJson(data);
      auth.currentUser!.updateDisplayName(facebookModel!.name);
      auth.currentUser!.updatePhotoURL(facebookModel!.picture!.url);
      displayUserName = facebookModel!.name!;
      displayUserImage = facebookModel!.picture!.url!;

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      auth.signInWithCredential(facebookAuthCredential);
      customGetSnackbar(
        title: "Welcome Back!",
        messageText: "Glad to see you again, $displayUserName!",
      );
      Get.offAllNamed(Routes.mainScreen);
    } 
    else {
      customGetSnackbar(
        title: "Somthing went wrong",
        messageText: "Please try again",
      );
    }
  }
}
