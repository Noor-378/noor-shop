import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/drawer_content.dart';
import 'package:noor_store/view/widgets/main_content.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder:
          (controller) => AdvancedDrawer(
            animationCurve: Curves.easeInOutCubic,
            animationDuration: const Duration(milliseconds: 400),
            animateChildDecoration: true,
            rtlOpening: false,
            disabledGestures: false,
            backdropColor: mainColor,
            childDecoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20.0,
                  spreadRadius: 5,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            controller: controller.advancedDrawer,
            backdrop: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    mainColor,
                    mainColor.withOpacity(0.8),
                    Colors.black.withOpacity(0.6),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -100,
                    right: -100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -80,
                    left: -80,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  CustomPaint(
                    size: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height,
                    ),
                    painter: BackdropPatternPainter(),
                  ),
                ],
              ),
            ),
            drawer: DrawerContent(advancedDrawer: controller.advancedDrawer),
            child: MainContent(
              advancedDrawer: controller.advancedDrawer,
              scrollController: controller.scrollController,
              controller: controller,
            ),
          ),
    );
  }
}

class BackdropPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.03)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    for (int i = 0; i < 5; i++) {
      final radius = (i + 1) * 90.0;
      canvas.drawCircle(
        Offset(size.width * 0.2, size.height * 0.3),
        radius,
        paint,
      );
    }

    for (int i = 0; i < 4; i++) {
      final radius = (i + 1) * 60.0;
      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.7),
        radius,
        paint,
      );
    }

    paint.strokeWidth = 1.0;
    for (int i = 0; i < 10; i++) {
      final offset = i * 100.0;
      canvas.drawLine(
        Offset(-50 + offset, 0),
        Offset(size.width - 50 + offset, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
