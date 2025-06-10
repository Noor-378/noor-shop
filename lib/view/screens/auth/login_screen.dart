import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:lottie/lottie.dart';
import 'package:noor_store/logic/controllers/login_controller.dart';
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
    return GetBuilder<LoginController>(
      init: LoginController(),
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
                              ),
                            ),
                            // SizedBox(height: 50),
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
                                autovalidateMode: AutovalidateMode.onUnfocus,

                                key: formKey,
                                child: Column(
                                  children: [
                                    AnimatedTextKit(
                                      repeatForever: false,
                                      totalRepeatCount: 1,
                                      pause: const Duration(microseconds: 100),
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          textStyle: TextStyle(
                                            color:
                                                Get.isDarkMode
                                                    ? Colors.white70
                                                    : LightAppColors
                                                        .textBodyColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          "Log in to continue your journey and find the products you're looking for.",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    FadeInLeft(
                                      child: CustomTextFormField(
                                        hintText: "Enter your email",
                                        controller: controller.emailController,
                                        labelText: "Email",
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                        ),
                                        validator: (value) {
                                          if (!RegExp(
                                            validationEmail,
                                          ).hasMatch(value!)) {
                                            return "Enter valid email please";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeInLeft(
                                      from: 200,
                                      child: CustomTextFormField(
                                        hintText: "Enter your password",
                                        controller:
                                            controller.passwordController,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (value) async {
                                          await FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .reload();

                                          if (formKey.currentState!
                                              .validate()) {
                                            if (FirebaseAuth
                                                .instance
                                                .currentUser!
                                                .emailVerified) {
                                              controller.loginUsingFirebase();
                                            } else {
                                              customGetSnackbar(
                                                title: "Verification",
                                                messageText:
                                                    "Please check your inbox to Verify your email.",
                                              );
                                            }
                                          }
                                        },
                                        fillColor: Colors.blueGrey,
                                        labelText: "Password",
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                        ),
                                        validator: (value) {
                                          if (value.toString().length <= 6) {
                                            return "Password should be longer than 6 characters";
                                          } else {
                                            return null;
                                          }
                                        },
                                        suffixIcon:
                                            controller.obscureEye
                                                ? FadeIn(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .toggleObscureText();
                                                    },
                                                    icon: Icon(
                                                      controller.obscureText
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                    ),
                                                  ),
                                                )
                                                : const SizedBox(height: 1),
                                        obscureText: controller.obscureText,
                                      ),
                                    ),
                                    FadeIn(
                                      child: Row(
                                        children: [
                                          CustomCheckbox(
                                            onChanged: (value) {
                                              controller.toggleKeepMeLogin();
                                            },
                                            value: controller.keepMeLogin,
                                          ),
                                          CustomText(
                                            text: "Keep me login",
                                            color:
                                                Get.isDarkMode
                                                    ? Colors.white70
                                                    : LightAppColors
                                                        .textBodyColor,
                                            fontSize: 16,
                                          ),
                                          const Spacer(),
                                          CustomTextButton(
                                            color:
                                                Get.isDarkMode
                                                    ? Colors.white70
                                                    : LightAppColors
                                                        .textBodyColor,
                                            decoration:
                                                TextDecoration.underline,
                                            text: "Forget your password?",
                                            onPressed: () {
                                              Get.toNamed(
                                                Routes.forgetPasswordScreen,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    controller.mainButton
                                        ? BounceIn(
                                          child: AnimatedGradientBorder(
                                            glowSize: 8,
                                            stretchAlongAxis: true,
                                            gradientColors: [
                                              LightAppColors.mainColor,
                                              LightAppColors.secondColor,
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
                                                  color:
                                                      LightAppColors.mainColor,
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
                                              onPressed: () async {
                                                await FirebaseAuth
                                                    .instance
                                                    .currentUser!
                                                    .reload();

                                                if (formKey.currentState!
                                                    .validate()) {
                                                  if (FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .emailVerified) {
                                                    controller
                                                        .loginUsingFirebase();
                                                  } else {
                                                    customGetSnackbar(
                                                      title: "Verification",
                                                      messageText:
                                                          "Please check your inbox to Verify your email.",
                                                    );
                                                  }
                                                }
                                              },
                                              child: CustomText(
                                                text: "Login",
                                                fontSize: 16,
                                                color:
                                                    Get.isDarkMode
                                                        ? LightAppColors
                                                            .secondColor
                                                        : LightAppColors
                                                            .mainColor,
                                              ),
                                            ),
                                          ),
                                        )
                                        : Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20,
                                            right: 20,
                                            left: 20,
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
                                              text: "Login",
                                              fontSize: 16,
                                              color:
                                                  Get.isDarkMode
                                                      ? LightAppColors
                                                          .secondColor
                                                      : LightAppColors.mainColor
                                                          .withAlpha(200),
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
                                          color: LightAppColors.textBodyColor,
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
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSocialAuthButton(
                image: "assets/images/google_logo.png",
                onPressed: () {
                  controller.signInWithGoogle();
                },
              ),
              CustomSocialAuthButton(
                image: "assets/images/facebook_logo.png",
                onPressed: () {
                  controller.signInWithFacebook();
                },
              ),
              CustomSocialAuthButton(
                height: 30,
                image: "assets/images/twitter_logo.png",
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSocialAuthButton(
                height: 70,
                width: 70,
                image: "assets/images/googleplaygames_logo.png",
                onPressed: () {},
              ),
              CustomSocialAuthButton(
                height: 35,
                width: 35,
                image: "assets/images/github_logo.png",
                onPressed: () {},
              ),
              CustomSocialAuthButton(
                image: "assets/images/microsoft_logo.png",
                onPressed: () {},
              ),
            ],
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
              color:
                  Get.isDarkMode
                      ? LightAppColors.secondColor
                      : LightAppColors.mainColor,
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
                  const CustomText(
                    text: "Dont have an account? ",
                    fontSize: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.singupScreen);
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
