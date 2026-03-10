import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {

    final offers = [
      {
        "title": "Flat 50% OFF",
        "subtitle": "On all fashion items",
        "code": "FASHION50"
      },
      {
        "title": "₹200 OFF",
        "subtitle": "On orders above ₹999",
        "code": "SAVE200"
      },
      {
        "title": "Buy 1 Get 1",
        "subtitle": "On selected products",
        "code": "BOGO"
      },
      {
        "title": "Free Delivery",
        "subtitle": "On orders above ₹499",
        "code": "FREEDEL"
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers & Coupons"),
        centerTitle: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,

        itemBuilder: (context, index) {

          final offer = offers[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0,3),
                )
              ],
            ),

            child: Row(
              children: [

                /// Discount Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_offer,
                    color: AppColors.primaryGold,
                  ),
                ),

                const SizedBox(width: 16),

                /// Offer Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        offer["title"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        offer["subtitle"]!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryGold),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          offer["code"]!,
                          style: const TextStyle(
                            color: AppColors.primaryGold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                /// Apply Button
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${offer["code"]} Applied"),
                      ),
                    );
                  },
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}