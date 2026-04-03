import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Controller/category_controller.dart';
import '../theme/app_colors.dart';
import '../utils/api_constants.dart';
import 'all_popular_clothes_screen.dart';
import 'popular_category_screen.dart';

class PopularClothsSection extends StatelessWidget {
  PopularClothsSection({super.key});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  AllPopularClothesScreen(),
                    ),
                  );
                  // TODO: Navigate to All Categories if required
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: AppColors.primaryGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),

        const SizedBox(height: 10),

        /// 🔄 Dynamic Categories List (Horizontal & Small)
        Obx(() {
          /// Loading
          if (controller.isLoading.value) {
            return const SizedBox(
              height: 110,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          /// Empty
          if (controller.categories.isEmpty) {
            return const SizedBox(
              height: 110,
              child: Center(child: Text("No Categories Found")),
            );
          }

          return SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                return _buildCategoryItem(category);
              },
            ),
          );
        }),
      ],
    );
  }

  /// 👗 Category Item Box (Small, Hide Price, Improved UI)
  Widget _buildCategoryItem(category) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PopularCategoryScreen(
          catId: category.catId,
          categoryName: category.name,
        ));
      },
      child: SizedBox(
        width: 75,
        child: Column(
          children: [
            /// Circular Image Box
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: ApiConstants.getImageUrl(category.image),
                  placeholder: (_, __) => const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.image,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// Category Name
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}