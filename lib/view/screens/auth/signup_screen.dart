import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:lottie/lottie.dart';
import 'package:noor_store/logic/controllers/auth_controller.dart'; // unified controller
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/utils/my_string.dart';
import 'package:noor_store/view/widgets/animated_custom_text.dart';
import 'package:noor_store/view/widgets/custom_divider.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/view/widgets/custom_social_auth_button.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/custom_text_form_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder:
          (controller) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
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
                                "assets/animations/Noor_Shop8.json",
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
                                autovalidateMode: AutovalidateMode.onUnfocus,
                                child: Column(
                                  children: [
                                    AnimatedTextKit(
                                      repeatForever: false,
                                      totalRepeatCount: 1,
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          "Don’t waste time calculating if the sale is good, create an account and save time and money!",
                                          textStyle: TextStyle(
                                            color: textBodyColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    FadeInLeftBig(
                                      from: 100,
                                      child: CustomTextFormField(
                                        controller:
                                            controller.singupUserNameController,
                                        labelText: "User Name",
                                        hintText: "Enter your Name",
                                        prefixIcon: const Icon(
                                          Icons.person_outline,
                                        ),
                                        validator: (value) {
                                          if ((value ?? "").length <= 2 ||
                                              !RegExp(
                                                validationName,
                                              ).hasMatch(value!)) {
                                            return "Enter valid name please";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeInRightBig(
                                      from: 100,
                                      child: CustomTextFormField(
                                        controller:
                                            controller.singupEmailController,
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
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeInLeftBig(
                                      from: 100,
                                      child: CustomTextFormField(
                                        controller:
                                            controller.singupPasswordController,
                                        labelText: "Password",
                                        hintText: "Enter your password",
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                        ),
                                        obscureText: controller.obscureText,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            controller.obscureText
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed:
                                              controller.toggleObscureText,
                                        ),
                                        validator: (value) {
                                          if ((value ?? "").length <= 6) {
                                            return "Password should be longer than 6 characters";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (value) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.signupUsingFirebase();
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    controller.singupMainButton
                                        ? BounceIn(
                                          child: AnimatedGradientBorder(
                                            glowSize: 8,
                                            stretchAlongAxis: true,
                                            gradientColors: [
                                              mainColor,
                                              secondColor,
                                            ],
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Get.isDarkMode
                                                        ? Colors.grey.shade500
                                                        : Colors.white,
                                                side: BorderSide(
                                                  color: mainColor,
                                                ),
                                                shape:
                                                    ContinuousRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            25,
                                                          ),
                                                    ),
                                                fixedSize: Size(Get.width, 48),
                                              ),
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  controller
                                                      .signupUsingFirebase();
                                                }
                                              },
                                              child: CustomText(
                                                text: "Signup",
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
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 20,
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Get.isDarkMode
                                                      ? Colors.grey
                                                      : Colors.grey.shade300,
                                              elevation: 0,
                                              shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              fixedSize: Size(Get.width, 48),
                                            ),
                                            onPressed: () {
                                              customGetSnackbar(
                                                title: "Empty fields",
                                                messageText:
                                                    "Please fill all the fields",
                                              );
                                            },
                                            child: CustomText(
                                              text: "Signup",
                                              fontSize: 16,
                                              color:
                                                  Get.isDarkMode
                                                      ? secondColor.withAlpha(
                                                        200,
                                                      )
                                                      : mainColor.withAlpha(
                                                        200,
                                                      ),
                                            ),
                                          ),
                                        ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const CustomDivider(width: 112.5),
                                        const SizedBox(width: 5),
                                        CustomText(
                                          text: "Or login with",
                                          color: textBodyColor,
                                          fontSize: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        const CustomDivider(width: 112.5),
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
                      const BottomSignupContainer(),
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
    return BounceIn(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSocialAuthButton(
            image: "assets/images/google_logo.png",
            onPressed: () async {
              await controller.signInWithGoogle();
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

class BottomSignupContainer extends StatelessWidget {
  const BottomSignupContainer({super.key});

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
                    "Have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(Routes.loginScreen);
                    },
                    child: const Text(
                      "Login now",
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
