import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noor_store/model/facebook_model.dart';
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';

class SingupController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // GlobalKey formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool keepMeLogin = true;
  bool mainButton = false;
  bool obscureEye = false;
  String displayUserName = "";
  String displayUserImage = "";
  FacebookModel? facebookModel;
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
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
          passwordController.text.isNotEmpty &&
          userNameController.text.isNotEmpty) {
        mainButton = true;
      } else {
        mainButton = false;
      }
      update();
    }

    userNameController.addListener(checkFields);
    emailController.addListener(checkFields);
    passwordController.addListener(checkFields);
  }
  
  void showObscureEyeFunction() {
    void checkFields() {
      if (
          passwordController.text.isNotEmpty) {
        obscureEye = true;
      } else {
        obscureEye = false;
      }
      update();
    }

    passwordController.addListener(checkFields);
  }


  void signupUsingFirebase() async {
    // ignore: unused_local_variable
    String name = userNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
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

  Future signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        customGetSnackbar(
          title: "Faild to singup",
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
        title: "Welcome!",
        messageText: "Glad to see you, $displayUserName!",
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
        title: "Welcome!",
        messageText: "Glad to see, $displayUserName!",
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
