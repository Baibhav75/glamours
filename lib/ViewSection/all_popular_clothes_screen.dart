import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Controller/category_controller.dart';
import '../theme/app_colors.dart';
import '../utils/api_constants.dart';
import 'popular_category_screen.dart';

class AllPopularClothesScreen extends StatelessWidget {
  AllPopularClothesScreen({super.key});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,

      /// 🔝 AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundWhite,
        foregroundColor: AppColors.textBlack,
        title: const Text(
          "All Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      /// 📦 Body
      body: Obx(() {
        /// 🔄 Loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ❌ Empty
        if (controller.categories.isEmpty) {
          return const Center(child: Text("No Categories Found"));
        }

        /// ✅ Grid for Categories
        return RefreshIndicator(
          onRefresh: controller.fetchCategories,
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns for categories
              crossAxisSpacing: 16,
              mainAxisSpacing: 24,
              childAspectRatio: 0.75, // Aspect ratio to fit circle + text
            ),
            itemBuilder: (context, index) {
              final category = controller.categories[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => PopularCategoryScreen(
                    catId: category.catId,
                    categoryName: category.name,
                  ));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 🖼️ Circular Image Box for Category
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: ApiConstants.getImageUrl(category.image),
                            placeholder: (_, __) => const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
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
                    ),

                    const SizedBox(height: 10),

                    /// 📄 Category Name
                    Text(
                      category.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}