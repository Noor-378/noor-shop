import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_flip/page_flip.dart';

class TermsController extends GetxController {
  final flipController = GlobalKey<PageFlipWidgetState>();
  var currentPage = 0.obs;
  final int itemCount = 5;

  var showIndicator = true.obs;

  void onUserInteraction() {
    _showIndicatorWithTimeout(const Duration(seconds: 1));
  }

  void changeCurrentPageNumber(index) {
    currentPage.value = index;
    _showIndicatorWithTimeout(const Duration(seconds: 1));
  }

  void _showIndicatorWithTimeout(Duration duration) {
    showIndicator.value = true;

    Future.delayed(Duration(seconds: 3), () => showIndicator.value = false);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
