import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:lottie/lottie.dart';
import 'package:noor_store/logic/controllers/singup_controller.dart';
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
    return GetBuilder<SingupController>(
      init: SingupController(),
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
                                            color: textBodyColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          "Don’t waste time calculating if the sale is good, create an account and save time and money!",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    FadeInLeft(
                                      child: CustomTextFormField(
                                        validator: (value) {
                                          if (value.toString().length <= 2 ||
                                              !RegExp(
                                                validationName,
                                              ).hasMatch(value!)) {
                                            return "Enter valid name please";
                                          } else {
                                            return null;
                                          }
                                        },
                                        hintText: "Enter your Name",
                                        controller:
                                            controller.userNameController,
                                        textInputAction: TextInputAction.next,
                                        fillColor: Colors.blueGrey,
                                        labelText: "User Name",
                                        prefixIcon: const Icon(
                                          Icons.person_outline,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeInLeft(
                                      from: 200,
                                      child: CustomTextFormField(
                                        hintText: "Enter your email",
                                        controller: controller.emailController,
                                        fillColor: Colors.blueGrey,
                                        labelText: "Email",
                                        validator: (value) {
                                          if (!RegExp(
                                            validationEmail,
                                          ).hasMatch(value!)) {
                                            return "Enter valid email please";
                                          } else {
                                            return null;
                                          }
                                        },
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeInLeft(
                                      from: 250,

                                      child: CustomTextFormField(
                                        hintText: "Enter your password",
                                        controller:
                                            controller.passwordController,
                                        textInputAction: TextInputAction.done,
                                        fillColor: Colors.blueGrey,
                                        labelText: "Password",
                                        validator: (value) {
                                          if (value.toString().length <= 6) {
                                            return "Password should be longer than 6 characters";
                                          } else {
                                            return null;
                                          }
                                        },
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                        ),
                                        onFieldSubmitted: (value) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.signupUsingFirebase();
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
                                    controller.mainButton
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
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  controller
                                                      .signupUsingFirebase();
                                                }
                                              },
                                              child: CustomText(
                                                text: "Singup",
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
                                              text: "Singup",
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
                      const BottomSingupContainer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
    ); //
  }
}

class BottomSingupContainer extends StatelessWidget {
  const BottomSingupContainer({super.key});

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
                  const CustomText(text: "Have an account? ", fontSize: 16),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.loginScreen);
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

class SocialAuth extends StatelessWidget {
  const SocialAuth({super.key, required this.controller});
  final SingupController controller;

  @override
  Widget build(BuildContext context) {
    return BounceIn(
      child: Column(
        children: [
          Row(
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
              // CustomSocialAuthButton(
              //   height: 30,
              //   image: "assets/images/twitter_logo.png",
              //   onPressed: () {},
              // ),
            ],
          ),
          // const SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     CustomSocialAuthButton(
          //       height: 70,
          //       width: 70,
          //       image: "assets/images/googleplaygames_logo.png",
          //       onPressed: () {},
          //     ),
          //     CustomSocialAuthButton(
          //       height: 35,
          //       width: 35,
          //       image: "assets/images/github_logo.png",
          //       onPressed: () {},
          //     ),
          //     CustomSocialAuthButton(
          //       image: "assets/images/microsoft_logo.png",
          //       onPressed: () {},
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
