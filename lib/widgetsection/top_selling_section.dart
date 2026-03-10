import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';

class TopSellingSection extends StatelessWidget {
  const TopSellingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        "name": "Rainbow Sequin",
        "image":
        "https://images.unsplash.com/photo-1593032465175-481ac7f401a0",
        "price": "₹6.99",
        "old": "₹9.99"
      },
      {
        "name": "Fashion Shirt",
        "image":
        "https://images.unsplash.com/photo-1520975928316-56cbaeb0f8db",
        "price": "₹7.99",
        "old": "₹12.99"
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _header("Top Selling"),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];

                return Container(
                  width: 220,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: p["image"]!,
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p["name"]!,
                                style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(p["old"]!,
                                    style: const TextStyle(
                                        decoration:
                                        TextDecoration.lineThrough)),
                                const SizedBox(width: 5),
                                Text(p["price"]!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.add_circle, color: AppColors.primaryGold)
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _header(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const Text("See all", style: TextStyle(color: Colors.grey))
      ],
    );
  }
}