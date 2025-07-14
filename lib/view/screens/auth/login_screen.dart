import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:lottie/lottie.dart';
import 'package:noor_store/logic/controllers/auth_controller.dart'; // Use unified controller
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/utils/my_string.dart';
import 'package:noor_store/view/widgets/animated_custom_text.dart';
import 'package:noor_store/view/widgets/custom_checkbox.dart';
import 'package:noor_store/view/widgets/custom_divider.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/view/widgets/custom_social_auth_button.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/custom_text_button.dart';
import 'package:noor_store/view/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder:
          (controller) => Scaffold(
            resizeToAvoidBottomInset: false,
            body:
                controller.isLoading
                    ? Center(
                      child: Lottie.asset("assets/animations/Loeding.json"),
                    )
                    : Stack(
                      children: [
                        Image.asset(
                          Get.isDarkMode
                              ? "assets/images/welcome_screen_background_dark.png"
                              : "assets/images/welcome_screen_background.png",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        SafeArea(
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 200),
                                child: Column(
                                  children: [
                                    FadeInDown(
                                      child: const AnimatedCustomText(
                                        text: "Noor Shop",

                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    FadeIn(
                                      child: Lottie.asset(
                                        "assets/animations/Noor_Shop_login.json",
                                        height: 200,
                                        width: Get.width,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Form(
                                        key: formKey,
                                        autovalidateMode:
                                            AutovalidateMode.onUnfocus,
                                        child: Column(
                                          children: [
                                            AnimatedTextKit(
                                              repeatForever: false,
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                                TyperAnimatedText(
                                                  "Log in to continue your journey and find the products you're looking for.",
                                                  textStyle: TextStyle(
                                                    color:
                                                        Get.isDarkMode
                                                            ? Colors.white70
                                                            : textBodyColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            CustomTextFormField(
                                              controller:
                                                  controller
                                                      .loginEmailController,
                                              labelText: "Email",
                                              hintText: "Enter your email",
                                              prefixIcon: const Icon(
                                                Icons.email_outlined,
                                              ),
                                              validator: (value) {
                                                if (!RegExp(
                                                  validationEmail,
                                                ).hasMatch(value ?? "")) {
                                                  return "Enter valid email please";
                                                }
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 20),
                                            CustomTextFormField(
                                              controller:
                                                  controller
                                                      .loginPasswordController,
                                              labelText: "Password",
                                              hintText: "Enter your password",
                                              prefixIcon: const Icon(
                                                Icons.lock_outline,
                                              ),
                                              obscureText:
                                                  controller.obscureText,
                                              suffixIcon:
                                                  controller.obscureEye
                                                      ? FadeIn(
                                                        child: IconButton(
                                                          icon: Icon(
                                                            controller
                                                                    .obscureText
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                          ),
                                                          onPressed:
                                                              controller
                                                                  .toggleObscureText,
                                                        ),
                                                      )
                                                      : FadeOut(
                                                        child: IconButton(
                                                          icon: Icon(
                                                            controller
                                                                    .obscureText
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                          ),
                                                          onPressed:
                                                              controller
                                                                  .toggleObscureText,
                                                        ),
                                                      ),
                                              validator: (value) {
                                                if ((value ?? "").length <= 6) {
                                                  return "Password should be longer than 6 characters";
                                                }
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.done,
                                              onFieldSubmitted: (value) async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  final user =
                                                      FirebaseAuth
                                                          .instance
                                                          .currentUser;
                                                  await user?.reload();

                                                  if (user != null &&
                                                      user.emailVerified) {
                                                    controller
                                                        .loginUsingFirebase();
                                                  } else {
                                                    customGetSnackbar(
                                                      title: "Verification",
                                                      messageText:
                                                          "Please check your inbox to verify your email.",
                                                    );
                                                  }
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              children: [
                                                CustomCheckbox(
                                                  value: controller.keepMeLogin,
                                                  onChanged:
                                                      (val) =>
                                                          controller
                                                              .toggleKeepMeLogin(),
                                                ),
                                                CustomText(
                                                  text: "Keep me login",
                                                  color:
                                                      Get.isDarkMode
                                                          ? Colors.white70
                                                          : textBodyColor,
                                                  fontSize: 16,
                                                ),
                                                const Spacer(),
                                                CustomTextButton(
                                                  text: "Forget your password?",
                                                  color:
                                                      Get.isDarkMode
                                                          ? Colors.white70
                                                          : textBodyColor,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  onPressed: () {
                                                    Get.toNamed(
                                                      Routes
                                                          .forgetPasswordScreen,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            controller.loginMainButton
                                                ? BounceIn(
                                                  child: AnimatedGradientBorder(
                                                    glowSize: 8,
                                                    stretchAlongAxis: true,
                                                    gradientColors: [
                                                      mainColor,
                                                      secondColor,
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          25,
                                                        ),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Get.isDarkMode
                                                                ? Colors
                                                                    .grey
                                                                    .shade500
                                                                : Colors.white,
                                                        side: BorderSide(
                                                          color: mainColor,
                                                        ),
                                                        shape: ContinuousRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                25,
                                                              ),
                                                        ),
                                                        fixedSize: Size(
                                                          Get.width,
                                                          48,
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        await FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.reload();
                                                        if (formKey.currentState
                                                                ?.validate() ??
                                                            false) {
                                                          if (FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  ?.emailVerified ??
                                                              false) {
                                                            controller
                                                                .loginUsingFirebase();
                                                          } else {
                                                            customGetSnackbar(
                                                              title:
                                                                  "Verification",
                                                              messageText:
                                                                  "Please check your inbox to verify your email.",
                                                            );
                                                          }
                                                        }
                                                      },
                                                      child: CustomText(
                                                        text: "Login",
                                                        fontSize: 16,
                                                        color:
                                                            Get.isDarkMode
                                                                ? secondColor
                                                                : mainColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                : Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20,
                                                      ),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Get.isDarkMode
                                                              ? Colors.grey
                                                              : Colors
                                                                  .grey
                                                                  .shade300,
                                                      elevation: 0,
                                                      shape: ContinuousRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              25,
                                                            ),
                                                      ),
                                                      fixedSize: Size(
                                                        Get.width,
                                                        48,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      customGetSnackbar(
                                                        title: "Empty fields",
                                                        messageText:
                                                            "Please fill all the fields",
                                                      );
                                                    },
                                                    child: CustomText(
                                                      text: "Login",
                                                      fontSize: 16,
                                                      color:
                                                          Get.isDarkMode
                                                              ? secondColor
                                                              : mainColor
                                                                  .withAlpha(
                                                                    200,
                                                                  ),
                                                    ),
                                                  ),
                                                ),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                const CustomDivider(
                                                  width: 112.5,
                                                ),
                                                const SizedBox(width: 5),
                                                CustomText(
                                                  text: "Or login with",
                                                  color: textBodyColor,
                                                  fontSize: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                const CustomDivider(
                                                  width: 112.5,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            SocialAuth(controller: controller),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const BottomLoginContainer(),
                            ],
                          ),
                        ),
                      ],
                    ),
          ),
    );
  }
}

class SocialAuth extends StatelessWidget {
  const SocialAuth({super.key, required this.controller});
  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSocialAuthButton(
            image: "assets/images/google_logo.png",
            onPressed: () {
              controller.signInWithGoogle();
            },
          ),
          const SizedBox(width: 20),
          CustomSocialAuthButton(
            image: "assets/images/facebook_logo.png",
            onPressed: () {
              controller.signInWithFacebook();
            },
          ),
        ],
      ),
    );
  }
}

class BottomLoginContainer extends StatelessWidget {
  const BottomLoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            width: Get.width,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? secondColor : mainColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(Routes.singupScreen);
                    },
                    child: const Text(
                      "Create an account",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
