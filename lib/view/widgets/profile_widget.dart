import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:noor_store/logic/controllers/settings_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({super.key});

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => ProfileImageView(imageUrl: controller.userImage));
          },
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [mainColor.withOpacity(0.3), mainColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: mainColor.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Hero(
              tag: 'profile-image-hero',
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(controller.userImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                text: controller.capitalize(controller.userName),
                color: Colors.black87,
              ),
              const SizedBox(height: 5),
              CustomText(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                text: controller.userEmail,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileImageView extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const ProfileImageView({
    super.key,
    required this.imageUrl,
    this.heroTag = "profile-image-hero",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: heroTag,
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3.0,
            enableRotation: true,
            loadingBuilder:
                (context, event) => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
            errorBuilder:
                (_, __, ___) => const Icon(
                  Icons.broken_image,
                  color: Colors.white,
                  size: 80,
                ),
          ),
        ),
      ),
    );
  }
}
