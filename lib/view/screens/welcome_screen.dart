import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:noor_store/logic/controllers/welcome_controller.dart';
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/animated_custom_text.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/custom_text_button.dart';
import 'package:noor_store/view/widgets/welcome_screen_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      builder:
          (controller) => Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 550,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          PageView.builder(
                            onPageChanged: (value) {
                              controller.showTextFalse();
                              if (value == welcomeContent.length - 1) {
                                controller.makeSkipGoAway();
                              } else {
                                controller.makeSkipComeBack();
                              }
                            },
                            physics: const BouncingScrollPhysics(),
                            itemBuilder:
                                (context, index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    WelcomeScreenAnimations(index: index),
                                    const SizedBox(height: 20),

                                    BounceIn(
                                      child: CustomText(
                                        text: welcomeContent[index].title,
                                        color: LightAppColors.mainColor,
                                        fontSize: 25,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    AnimatedTextKit(
                                      repeatForever: false,
                                      totalRepeatCount: 1,
                                      pause: const Duration(microseconds: 100),
                                      onFinished: () {
                                        controller.showTextTrue();
                                      },
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          textStyle: TextStyle(
                                            color: LightAppColors.textBodyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          welcomeContent[index].body,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),
                                    if (index == 0 && controller.showText)
                                      FadeIn(
                                        child: const AnimatedCustomText(
                                          text: "Noor Shop",

                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    if (index == 2 && controller.showText)
                                      ZoomIn(
                                        child: const AnimatedCustomText(
                                          text: "Free.",

                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                  ],
                                ),
                            itemCount: welcomeContent.length,
                            controller: controller.pageController,
                          ),
                          if (controller.isLast)
                            Container()
                          else
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: BounceIn(
                                child: CustomTextButton(
                                  text: "Skip",
                                  onPressed: () {
                                    controller.pageController.jumpToPage(
                                      welcomeContent.length - 1,
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            effect: ExpandingDotsEffect(
                              dotHeight: 10,
                              activeDotColor: LightAppColors.mainColor, //
                            ),
                            controller: controller.pageController,
                            count: welcomeContent.length,
                          ),
                          controller.isLast
                              ? FadeIn(
                                animate: true,
                                child: AnimatedGradientBorder(
                                  glowSize: 5,
                                  gradientColors: [LightAppColors.mainColor, LightAppColors.secondColor],
                                  borderRadius: BorderRadius.circular(20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/loginScreen");
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 125,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: AnimatedCustomText(
                                        text: "Get Started",
                                        onTap: () {
                                          Get.offNamed(Routes.loginScreen);
                                        },
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              : BounceIn(
                                animate: true,

                                child: CustomTextButton(
                                  text: "Next",
                                  onPressed: () {
                                    controller.pageController.nextPage(
                                      duration: const Duration(milliseconds: 750),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                    );
                                  },
                                ),
                              ),
                        ],
                      ),
                    ),
                    controller.isLast ? Container() : const SizedBox(height: 7),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
