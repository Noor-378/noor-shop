import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/terms_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:page_flip/page_flip.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TermsController());

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          PageFlipWidget(
            key: controller.flipController,
            backgroundColor: Colors.white,
            lastPage: const YoutubeWebView(),
            onPageFlipped: (index) {
              controller.changeCurrentPageNumber(index);
            },
            children: List.generate(
              controller.itemCount,
              (index) => DemoPage(controller: controller),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: controller.showIndicator.value ? 1 : 0,
                child: IgnorePointer(
                  ignoring: !controller.showIndicator.value,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (controller.currentPage.value > 0) {
                              controller.flipController.currentState
                                  ?.previousPage();
                            }
                          },
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (child, animation) => ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                          child: Text(
                            '${controller.currentPage.value + 1} / ${controller.itemCount + 1}',
                            key: ValueKey<int>(controller.currentPage.value),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (controller.currentPage.value <
                                controller.itemCount) {
                              controller.flipController.currentState
                                  ?.nextPage();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  // final int page;
  final TermsController controller;

  const DemoPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        controller.onUserInteraction();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    text:
                        "Lorem ipsum dolor dolor sit amet consectetur varius etiam. Et praesent pulvinar placerat eleifend vestibulum sem purus amet amet. Viverra volutpat tortor dictum mi mattis dis. Ut varius pellentesque quis tristique ultricies netun tesque quis netun trist ique netun ult ricies netus.",
                    color: blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  color: Colors.black38,
                  height: 300,
                  width: 150,
                  child: const Placeholder(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CustomText(
                color: blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                text:
                    "Lorem ipsum dolor sit amet consectetur. Etiam pellentesque pulvinar in elit molestie. Ultricies risus donec commodo turpis adipiscing suspendisse auctor gravida. Porttitor condimentum consectetur amet neque. Ullamcorper praesent in vitae est quisque eget augue elit. Eget malesuada purus vitae gravida lacus volutpat ac nullam semper. Urna eget diam viverra risus faucibus venenatis. Amet at morbi vulputate suscipit quam aenean elit dictum. Tincidunt non maecenas varius etiam. Et praesent pulvinar placerat eleifend vestibulum sem purus amet amet. Viverra volutpat tortor dictum mi mattis dis. Ut varius pellentesque quis tristique ultricies netus.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YoutubeWebView extends StatefulWidget {
  const YoutubeWebView({super.key});

  @override
  State<YoutubeWebView> createState() => _YoutubeWebViewState();
}

class _YoutubeWebViewState extends State<YoutubeWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
              'https://www.youtube.com/embed/bV4KR7nUlo8?autoplay=1&controls=1',
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
