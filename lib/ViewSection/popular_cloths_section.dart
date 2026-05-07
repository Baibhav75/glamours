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

        /// HEADER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllPopularClothesScreen(),
                    ),
                  );
                },

                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Color(0xFFF72585),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        /// CATEGORY GRID
        Obx(() {

          /// LOADING
          if (controller.isLoading.value) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFF72585),
                ),
              ),
            );
          }

          /// EMPTY
          if (controller.categories.isEmpty) {
            return const SizedBox(
              height: 120,
              child: Center(
                child: Text(
                  "No Categories Found",
                ),
              ),
            );
          }

          /// GRID VIEW
          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12),

            child: GridView.builder(

              shrinkWrap: true,

              physics:
              const NeverScrollableScrollPhysics(),

              itemCount:
              controller.categories.length,

              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: 14,

                mainAxisSpacing: 14,

                childAspectRatio: 0.72,
              ),

              itemBuilder: (context, index) {

                final category =
                controller.categories[index];

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

        Get.to(
              () => PopularCategoryScreen(
            catId: category.catId,
            categoryName: category.name,
          ),
        );
      },

      child: Container(

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(24),

          boxShadow: [

            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          children: [

            /// TRIANGLE IMAGE DESIGN
            ClipPath(
              clipper: TriangleClipper(),

              child: SizedBox(
                height: 130,
                width: double.infinity,

                child: CachedNetworkImage(

                  imageUrl:
                  ApiConstants.getImageUrl(
                    category.image,
                  ),

                  fit: BoxFit.cover,

                  placeholder: (_, __) =>
                  const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFF72585),
                    ),
                  ),

                  errorWidget: (_, __, ___) =>
                  const Icon(
                    Icons.image,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            /// CATEGORY NAME
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 10,
              ),

              child: Text(

                category.name,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const Spacer(),

            /// BUTTON
            Container(
              margin:
              const EdgeInsets.only(bottom: 14),

              padding:
              const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),

              decoration: BoxDecoration(

                color: const Color(0xFFF72585),

                borderRadius:
                BorderRadius.circular(30),
              ),

              child: const Text(

                "Explore",

                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TriangleClipper
    extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {

    Path path = Path();

    path.lineTo(
      0,
      size.height - 40,
    );

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(
      CustomClipper<Path> oldClipper) {
    return false;
  }

}