import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundLightGray,

      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: AppColors.backgroundBlack,
        foregroundColor: AppColors.textWhite,
        elevation: 0,
      ),

      body: Column(
        children: [

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  /// ADDRESS CARD
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [

                        Icon(Icons.location_on, color: AppColors.primaryGold),

                        SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                "Delivery Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                "221B Baker Street, London",
                                style: TextStyle(color: Colors.grey),
                              ),

                            ],
                          ),
                        ),

                        Icon(Icons.arrow_forward_ios,size:16)

                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// COUPON CARD
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [

                        Icon(Icons.discount, color: AppColors.primaryGold),

                        const SizedBox(width: 10),

                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Promo Code",
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGold,
                            foregroundColor: AppColors.textBlack,
                          ),
                          onPressed: (){},
                          child: const Text("Apply"),
                        )

                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ORDER SUMMARY
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [

                        const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal"),
                            Text("\$312"),
                          ],
                        ),

                        const SizedBox(height:10),

                        const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Discount"),
                            Text("-\$0"),
                          ],
                        ),

                        const SizedBox(height:10),

                        const Divider(),

                        const SizedBox(height:10),

                        const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              "\$312",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          /// BOTTOM CHECKOUT BUTTON
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12
                )
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGold,
                  foregroundColor: AppColors.textBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "payment");
                },
                child: const Text(
                  "Proceed To Payment",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}