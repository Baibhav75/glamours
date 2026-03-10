import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'review_page.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightGray,

      appBar: AppBar(
        title: const Text("Single Order"),
        backgroundColor: AppColors.backgroundBlack,
        foregroundColor: AppColors.textWhite,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black12,
              )
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// PRODUCT NAME
              const Text(
                "Classic Oxford Shirt",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 8),

              /// QUANTITY
              const Text(
                "Quantity : 1",
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 8),

              /// PRICE
              const Text(
                "₹20.0",
                style: TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// TRACKING NUMBER
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Order Tracking Number : 890025427",
                  style: TextStyle(fontSize: 14),
                ),
              ),

              const SizedBox(height: 16),

              /// STATUS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [

                  Text(
                    "Order Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Text(
                    "Pending",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )

                ],
              ),

              const Spacer(),

              /// WRITE REVIEW BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    foregroundColor: AppColors.textBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReviewPage(),
                      ),
                    );

                  },
                  child: const Text(
                    "Write Review",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// BACK BUTTON
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back to Orders"),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}