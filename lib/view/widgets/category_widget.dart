import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/category_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/category_item.dart';
import 'package:redacted/redacted.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key});

  final controller = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCatgeoryLoading.value) {
        return Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(child: CircularProgressIndicator(color: mainColor)),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.categoryNameList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              controller.getCategoryIndex(index);
              Get.to(
                () => CategoryItems(
                  catehoryTitle: controller.categoryNameList[index],
                ),
              );
            },
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      controller.categoryImages[controller
                              .categoryNameList[index]] ??
                          "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.amber,
                          ),
                        ).redacted(context: context, redact: true);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(.65),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Text(
                        controller.categoryNameList[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
