import 'package:animate_do/animate_do.dart'; 
import 'package:animated_text_kit/animated_text_kit.dart'; 
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import 'package:glowy_borders/glowy_borders.dart'; 
import 'package:lottie/lottie.dart'; 
import 'package:noor_store/logic/controllers/auth_controller.dart'; 
import 'package:noor_store/utils/colors.dart'; 
import 'package:noor_store/utils/my_string.dart'; 
import 'package:noor_store/view/widgets/custom_snackbar.dart'; 
import 'package:noor_store/view/widgets/custom_text.dart'; 
import 'package:noor_store/view/widgets/custom_text_form_field.dart'; 
 
class ForgetPasswordScreen extends StatelessWidget { 
  ForgetPasswordScreen({super.key}); 
  final formKey = GlobalKey<FormState>(); 
 
  @override 
  Widget build(BuildContext context) { 
    return GetBuilder<AuthController>( 
      builder: (controller) { 
        return Scaffold( 
          backgroundColor: Get.isDarkMode ? Colors.grey.shade900 : Colors.white, 
          appBar: AppBar( 
            backgroundColor: Colors.transparent, 
            centerTitle: true, 
            leading: GestureDetector( 
              onTap: () => Get.back(), 
              child: FadeInDown( 
                child: Row( 
                  children: [ 
                    Icon( 
                      Icons.arrow_back_ios_rounded, 
                      color: Get.isDarkMode ? Colors.white70 : Colors.black, 
                    ), 
                    CustomText( 
                      text: "Login", 
                      fontSize: 13, 
                      fontWeight: FontWeight.bold, 
                      color: Get.isDarkMode ? Colors.white70 : Colors.black, 
                    ), 
                  ], 
                ), 
              ), 
            ), 
            title: FadeInDown( 
              child: CustomText( 
                text: "Forget Password", 
                fontWeight: FontWeight.bold, 
                color: Get.isDarkMode ? Colors.white : Colors.grey.shade800, 
                fontSize: 20, 
              ), 
            ), 
            elevation: 0, 
          ), 
          body: SafeArea( 
            child: Padding( 
              padding: const EdgeInsets.symmetric(horizontal: 20), 
              child: SingleChildScrollView( 
                physics: const BouncingScrollPhysics(), 
                child: Column( 
                  children: [ 
                    const SizedBox(height: 20), 
                    AnimatedTextKit( 
                      repeatForever: false, 
                      totalRepeatCount: 1, 
                      animatedTexts: [ 
                        TyperAnimatedText( 
                          textStyle: TextStyle( 
                            color: textBodyColor, 
                            fontSize: 16, 
                            fontWeight: FontWeight.w600, 
                          ), 
                          "Don't worry if you forget your password, just type your email...", 
                        ), 
                      ], 
                    ), 
                    FadeInUp( 
                      child: Stack( 
                        alignment: Alignment.center, 
                        children: [ 
                          LottieBuilder.asset( 
                            "assets/animations/Noor_Shop2.json", 
                            width: Get.width, 
                            height: 300, 
                          ), 
                          Lottie.asset( 
                            "assets/animations/thinking.json", 
                            height: 300, 
                            width: Get.width, 
                          ), 
                        ], 
                      ), 
                    ), 
                    FadeInUp( 
                      child: Form( 
                        key: formKey, 
                        child: CustomTextFormField( 
                          controller: controller.forgetPasswordEmailController, 
                          validator: (value) { 
                            if (!RegExp(validationEmail).hasMatch(value ?? "")) { 
                              return "Enter valid email please"; 
                            } else { 
                              return null; 
                            } 
                          }, 
                          hintText: "Enter your email", 
                          labelText: "Email", 
                          prefixIcon: const Icon(Icons.email_outlined), 
                          onFieldSubmitted: (value) { 
                            if (formKey.currentState!.validate()) { 
                              controller.resetPassword(); 
                            } 
                          }, 
                          textInputAction: TextInputAction.done, 
                        ), 
                      ), 
                    ), 
                    const SizedBox(height: 20), 
                    controller.forgetPasswordMainButton 
                        ? BounceIn( 
                            child: AnimatedGradientBorder( 
                              glowSize: 8, 
                              stretchAlongAxis: true, 
                              gradientColors: [mainColor, secondColor], 
                              borderRadius: BorderRadius.circular(25), 
                              child: ElevatedButton( 
                                style: ElevatedButton.styleFrom( 
                                  backgroundColor: Get.isDarkMode ? Colors.grey.shade500 : Colors.white, 
                                  side: BorderSide(color: mainColor), 
                                  shape: ContinuousRectangleBorder( 
                                    borderRadius: BorderRadius.circular(25), 
                                  ), 
                                  fixedSize: Size(Get.width, 48), 
                                ), 
                                onPressed: () { 
                                  if (formKey.currentState!.validate()) { 
                                    controller.resetPassword(); 
                                  } 
                                }, 
                                child: CustomText( 
                                  text: "Send", 
                                  fontSize: 16, 
                                  color: Get.isDarkMode ? secondColor : mainColor, 
                                ), 
                              ), 
                            ), 
                          ) 
                        : Padding( 
                            padding: const EdgeInsets.only(top: 20, right: 20, left: 20), 
                            child: FadeIn( 
                              child: ElevatedButton( 
                                style: ElevatedButton.styleFrom( 
                                  backgroundColor: Get.isDarkMode ? Colors.grey : Colors.grey.shade300, 
                                  elevation: 0, 
                                  shape: ContinuousRectangleBorder( 
                                    borderRadius: BorderRadius.circular(25), 
                                  ), 
                                  fixedSize: Size(Get.width, 48), 
                                ), 
                                onPressed: () { 
                                  customGetSnackbar( 
                                    title: "Empty Field", 
                                    messageText: "Please fill the field", 
                                  ); 
                                }, 
                                child: CustomText( 
                                  text: "Send", 
                                  fontSize: 16, 
                                  color: Get.isDarkMode ? secondColor : mainColor.withAlpha(200), 
                                ), 
                              ), 
                            ), 
                          ), 
                  ], 
                ), 
              ), 
            ), 
          ), 
        ); 
      }, 
    ); 
  } 
}
