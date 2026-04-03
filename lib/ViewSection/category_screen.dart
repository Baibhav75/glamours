import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/Controller/category_controller.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final controller = Get.put(CategoryController());

  final String baseImageUrl = "https://glamorousfilmcity.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {

            final item = controller.categories[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber, width: 1),
              ),
              child: Row(
                children: [

                  /// IMAGE
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: baseImageUrl + item.image,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                      const SizedBox(
                        width: 110,
                        height: 110,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.image, color: Colors.white),
                    ),
                  ),

                  /// TEXT
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        );
      }),
    );
  }
}