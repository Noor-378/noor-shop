import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/auth_controller.dart';
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              // Toggle to the opposite mode
            },
            icon: Icon(
              Get.isDarkMode
                  ? Icons
                      .wb_sunny_outlined // Show sun when in dark mode
                  : Icons.dark_mode_outlined, // Show moon when in light mode
            ),
          ),
          GetBuilder<AuthController>(
            builder:
                (controller) => ElevatedButton.icon(
                  onPressed: () {
                    Get.dialog(
                      AnimatedDialog(
                        title: "Confirm Logout",
                        content: const Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                        ),
                        onCancelText: "Cancel",
                        onConfirmText: "Logout",
                        onConfirm: () async {
                          controller.signOutFromApp();
                        },
                        onConfirmTextStyle: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                        onCancelTextTextStyle: TextStyle(
                          color: scaffoldDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      barrierDismissible: true,
                    );
                  },

                  label: const Text("Logout"),
                ),
          ),
        ],
      ),
    );
  }
}

class AnimatedDialog extends StatefulWidget {
  final VoidCallback onConfirm;
  final String title;
  final Widget content;
  final String onCancelText;
  final String onConfirmText;
  final TextStyle? onConfirmTextStyle;
  final TextStyle? onCancelTextTextStyle;
  final bool hideCancelButton;

  const AnimatedDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.content,
    required this.onCancelText,
    required this.onConfirmText,
    this.onConfirmTextStyle,
    this.onCancelTextTextStyle,
    this.hideCancelButton = false,
  });

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool canClick = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeInUp(
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: widget.content,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                      widget.hideCancelButton
                          ? Container()
                          : TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              widget.onCancelText,
                              style:
                                  widget.onCancelTextTextStyle ??
                                  const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (canClick) {
                        canClick = false;
                        widget.onConfirm();
                        Navigator.of(context).pop();
                        Future.delayed(const Duration(seconds: 1), () {
                          canClick = true;
                        });
                      }
                    },
                    child: Text(
                      widget.onConfirmText,
                      style:
                          widget.onConfirmTextStyle ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
