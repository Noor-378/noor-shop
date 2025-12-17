import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class CheckOutController extends GetxController {
  // Card data
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  bool isLoading = false;

  void onCreditCardModelChange(CreditCardModel model) {
    cardNumber = model.cardNumber;
    expiryDate = model.expiryDate;
    cardHolderName = model.cardHolderName;
    cvvCode = model.cvvCode;
    isCvvFocused = model.isCvvFocused;
    update();
  }

  void submitPayment() {
    if (cardNumber.isEmpty ||
        expiryDate.isEmpty ||
        cardHolderName.isEmpty ||
        cvvCode.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all card details',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    update();
  }
}
