import 'package:animate_do/animate_do.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/check_out_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({super.key});
  final CheckOutController checkOutController = Get.put(CheckOutController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () => Get.back(),
                      ),
                      CustomText(
                        text: 'Checkout',
                        fontSize: 20,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 44),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUpBig(
                      from: 10,

                      child: CustomText(
                        text: 'Payment Method',
                        fontSize: 20,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    FadeInUpBig(
                      from: 10,
                      child: Text(
                        'Enter your card details',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                FadeInUpBig(
                  from: 10,
                  child: GetBuilder<CheckOutController>(
                    builder:
                        (controller) => CustomCreditCard(
                          checkOutController: checkOutController,
                        ),
                  ),
                ),
                const SizedBox(height: 30),

                FadeInUpBig(
                  from: 10,
                  child: CustomText(
                    text: 'Card Details',
                    fontSize: 20,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                FadeInUpBig(
                  from: 10,
                  child: CreditCardForm(
                    formKey: _formKey,
                    cardNumber: checkOutController.cardNumber,
                    expiryDate: checkOutController.expiryDate,
                    cardHolderName: checkOutController.cardHolderName,
                    cvvCode: checkOutController.cvvCode,
                    onCreditCardModelChange:
                        checkOutController.onCreditCardModelChange,
                    inputConfiguration: InputConfiguration(
                      cardNumberDecoration: _cardInputDecoration(
                        label: 'Card Number',
                        hint: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: _cardInputDecoration(
                        label: 'Expiry Date',
                        hint: 'MM/YY',
                      ),
                      cvvCodeDecoration: _cardInputDecoration(
                        label: 'CVV',
                        hint: 'XXX',
                      ),
                      cardHolderDecoration: _cardInputDecoration(
                        label: 'Card Holder Name',
                        hint: 'Noor Alawawdeh',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                FadeInUpBig(
                  from: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Your payment is secure and encrypted',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUpBig(
                  from: 25,
                  child: Center(
                    child: AnimatedButton(
                      width: 330,
                      onPressed: checkOutController.submitPayment,
                      color: mainColor,
                      shadowDegree: ShadowDegree.light,
                      borderRadius: 15,
                      duration: 85,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment, color: whiteColor, size: 22),
                          const SizedBox(width: 10),
                          CustomText(
                            text: 'Pay Now',
                            fontSize: 16,
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
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
  }

  InputDecoration _cardInputDecoration({
    required String label,
    required String hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: blackColor),
      filled: true,
      fillColor: whiteColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.grey.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: mainColor.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: mainColor.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: blackColor, size: 20),
      ),
    );
  }
}

class CustomCreditCard extends StatelessWidget {
  const CustomCreditCard({super.key, required this.checkOutController});

  final CheckOutController checkOutController;

  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      cardNumber: checkOutController.cardNumber,
      expiryDate: checkOutController.expiryDate,
      cardHolderName: checkOutController.cardHolderName,
      cvvCode: checkOutController.cvvCode,
      showBackView: checkOutController.isCvvFocused,
      onCreditCardWidgetChange: (CreditCardBrand brand) {},
      bankName: 'Jordan islamic bank',
      glassmorphismConfig: Glassmorphism.defaultConfig(),
      enableFloatingCard: true,
      labelCardHolder: 'Card Holder',
      isHolderNameVisible: true,
      height: 200,
      animationDuration: const Duration(milliseconds: 1000),
      padding: 0,
    );
  }
}
