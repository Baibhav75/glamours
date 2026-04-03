import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Controller/popular_category_controller.dart';
import '../theme/app_colors.dart';
import '../utils/api_constants.dart';
import 'ProductDetailsPage.dart';

class PopularCategoryScreen extends StatelessWidget {
  final String catId;
  final String categoryName;

  const PopularCategoryScreen({
    super.key,
    required this.catId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    // Initializing controller with specific Category ID
    final PopularCategoryController controller = Get.put(
      PopularCategoryController(catId: catId),
      tag: catId, // using tag to support multiple instances if needed
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,

      /// 🔝 AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundWhite,
        foregroundColor: AppColors.textBlack,
        title: Text(
          categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      /// 📦 Body
      body: Obx(() {
        /// 🔄 Loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ❌ Error
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        /// ❌ Empty
        if (controller.productList.isEmpty) {
          return const Center(child: Text("No Products Found"));
        }

        /// ✅ Grid (Flipkart-Style Cards)
        return RefreshIndicator(
          onRefresh: controller.refreshProducts,
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.60, // Taller aspect ratio for e-commerce card
            ),
            itemBuilder: (context, index) {
              final product = controller.productList[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailsPage(product: {
                    "name": product.productName,
                    "image": ApiConstants.getImageUrl(product.image1),
                    "originalPrice": product.mrp,
                    "discountPrice": product.sellingPrice,
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🖼️ Image Section
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                imageUrl: ApiConstants.getImageUrl(product.image1),
                                placeholder: (context, url) => Container(
                                  color: Colors.grey.shade100,
                                  child: const Center(
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                                errorWidget: (_, __, ___) => Container(
                                  color: Colors.grey.shade100,
                                  child: const Icon(Icons.image, color: Colors.grey),
                                ),
                              ),
                            ),
                            
                            /// ❤️ Wishlist Icon
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 📄 Details Section (Flipkart style)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Brand/Category Subtitle (Optional, using Category for now)
                            Text(
                              categoryName.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),

                            /// Product Title
                            Text(
                              product.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: AppColors.textBlack,
                              ),
                            ),
                            const SizedBox(height: 6),

                            /// Price Section
                            Row(
                              children: [
                                Text(
                                  "₹${product.sellingPrice}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "₹${product.mrp}",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 4),

                            /// Discount Text (Green like Flipkart)
                            Text(
                              _calculateDiscount(product.mrp, product.sellingPrice),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.green, // Classic Flipkart discount color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  /// Helper to calculate discount percentage
  String _calculateDiscount(String? mrpStr, String? sellStr) {
    try {
      if (mrpStr == null || sellStr == null) return '';
      final mrp = double.parse(mrpStr);
      final sell = double.parse(sellStr);
      if (mrp <= sell) return '';
      
      final diff = mrp - sell;
      final percent = (diff / mrp) * 100;
      return "${percent.toStringAsFixed(0)}% off";
    } catch (e) {
      return '';
    }
  }
}
