import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/cart_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/screens/cart_screen.dart';
import 'package:noor_store/view/widgets/color_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSliders extends StatefulWidget {
  final String imageUrl;
  final String productId;
  const ImageSliders({
    required this.imageUrl,
    super.key,
    required this.productId,
  });

  @override
  _ImageSlidersState createState() => _ImageSlidersState();
}

class _ImageSlidersState extends State<ImageSliders>
    with TickerProviderStateMixin {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final cartController = Get.find<CartController>();

  Timer? _autoPlayTimer;

  late AnimationController _colorPickerController;
  late AnimationController _imageController;

  final int _totalPages = 3;

  int currentPage = 0;
  int currentColor = 0;

  final List<Color> colorSelected = [
    kCOlor1,
    kCOlor2,
    kCOlor3,
    kCOlor4,
    kCOlor5,
    kCOlor2,
    kCOlor3,
    kCOlor4,
  ];

  @override
  void initState() {
    super.initState();

    _colorPickerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _colorPickerController.forward();
    _imageController.forward();

    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final nextPage = (currentPage + 1) % _totalPages;

      setState(() => currentPage = nextPage);

      _carouselController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _colorPickerController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double sliderHeight = constraints.maxWidth * 0.9;

        return SizedBox(
          height: sliderHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: _totalPages,
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: sliderHeight,
                  viewportFraction: 1,
                  autoPlay: false,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  enlargeFactor: .5,
                  onPageChanged: (index, reason) {
                    setState(() => currentPage = index);
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: 'product_${widget.productId}',
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  );
                },
              ),

              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: FadeInUpBig(
                  from: 10,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 18,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentPage,
                        count: _totalPages,
                        effect: ExpandingDotsEffect(
                          dotHeight: 6,
                          dotWidth: 6,
                          expansionFactor: 3,
                          spacing: 6,
                          activeDotColor: mainColor,
                          dotColor: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 20,
                bottom: 20,
                child: FadeInRightBig(
                  from: 10,
                  child: Container(
                    height: 180,
                    width: 50,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.color_lens_rounded,
                            size: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemCount: colorSelected.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentColor = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: AnimatedScale(
                                    scale: currentColor == index ? 1.15 : 1.0,
                                    duration: const Duration(milliseconds: 200),
                                    child: ColorPicker(
                                      color: colorSelected[index],
                                      outerBorder: currentColor == index,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: FadeInDownBig(
                  from: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () => Get.back(),
                      ),
                      _buildNavButton(
                        icon: Icons.shopping_cart_outlined,
                        onTap: () => Get.to(() => CartScreen()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
              color: mainColor.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
