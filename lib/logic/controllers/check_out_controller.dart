import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noor_store/logic/controllers/cart_controller.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/screens/pick_location_screen.dart';
import 'package:noor_store/view/widgets/animated_dialog.dart';

class CheckOutController extends GetxController {
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cvvCode = TextEditingController();
  bool isCvvFocused = false;
  String? address;

  final TextEditingController locationController = TextEditingController();
  double? latitude;
  double? longitude;

  bool isLoading = false;

  void onCreditCardModelChange(CreditCardModel model) {
    cardNumber.text = model.cardNumber;
    expiryDate.text = model.expiryDate;
    cardHolderName.text = model.cardHolderName;
    cvvCode.text = model.cvvCode;
    isCvvFocused = model.isCvvFocused;
    update();
  }

  Future<LatLng?> _getUserCurrentLatLng() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  }

  Future<String?> _getAddressFromLatLng(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) return null;

      final place = placemarks.first;

      final area = place.subLocality;
      final city = place.locality;
      final country = place.country;

      return [
        if (area != null && area.isNotEmpty) area,
        if (city != null && city.isNotEmpty) city,
        if (country != null && country.isNotEmpty) country,
      ].join(', ');
    } catch (e) {
      log("error $e");
      return null;
    }
  }

  Future<void> pickLocation() async {
    final initialLatLng = await _getUserCurrentLatLng();

    final result = await Get.to(
      () => PickLocationScreen(
        initialLocation: initialLatLng ?? const LatLng(32.000472, 36.022944),
      ),
    );

    if (result != null && result is String) {
      final parts = result.split(',');

      if (parts.length == 2) {
        latitude = double.tryParse(parts[0].trim());
        longitude = double.tryParse(parts[1].trim());

        if (latitude != null && longitude != null) {
          log("lat: $latitude");
          log("long: $longitude");
          address = await _getAddressFromLatLng(latitude!, longitude!);
          log("address: $address");
          locationController.text =
              address ??
              '${latitude!.toStringAsFixed(5)}, ${longitude!.toStringAsFixed(5)}';

          update();
        }
      }
    }
  }

  void submitPayment() {
    if (cardNumber.text.isEmpty ||
        expiryDate.text.isEmpty ||
        cardHolderName.text.isEmpty ||
        cvvCode.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all card details',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (latitude == null || longitude == null) {
      Get.snackbar(
        'Error',
        'Please select your location',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    Get.dialog(
      AnimatedDialog(
        onCancelText: "",

        title: "Order Confirmed",
        hideCancelButton: true,
        onConfirmText: "Continue Shopping",
        onConfirm: () {
          Get.find<CartController>().clearAllProducts();
          Get.back();
        },
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),

            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: mainColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: mainColor,
                size: 70,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Thank you for your order!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Your delivery is on the way \nWe will notify you once it arrives.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  void _clearAllFields() {
    cardNumber.clear();
    expiryDate.clear();
    cardHolderName.clear();
    cvvCode.clear();
    locationController.clear();

    latitude = null;
    longitude = null;

    Get.find<CartController>().clearAllProducts();
    Get.back();
  }

  @override
  void onClose() {
    locationController.dispose();
    super.onClose();
  }
}
