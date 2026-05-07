import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CheckoutPage extends StatelessWidget {

  final double subtotal;
  final double totalAmount;
  final String userName;
  final String userPhone;
  final String userAddress;

  const CheckoutPage({
    super.key,
    required this.subtotal,
    required this.totalAmount,
    required this.userName,
    required this.userPhone,
    required this.userAddress,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.backgroundLightGray,

      appBar: AppBar(
        title: const Text("CheckOut"),
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

                    margin:
                    const EdgeInsets.symmetric(horizontal: 16),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Row(
                      children: [

                        const Icon(
                          Icons.location_on,
                          color: AppColors.primaryGold,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                userAddress,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                userPhone,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),

                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )

                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// COUPON CARD
                  Container(

                    margin:
                    const EdgeInsets.symmetric(horizontal: 16),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Row(
                      children: [

                        const Icon(
                          Icons.discount,
                          color: AppColors.primaryGold,
                        ),

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
                            backgroundColor:
                            AppColors.primaryGold,

                            foregroundColor:
                            AppColors.textBlack,
                          ),

                          onPressed: () {},

                          child: const Text("Apply"),
                        )

                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ORDER SUMMARY
                  Container(

                    margin:
                    const EdgeInsets.symmetric(horizontal: 16),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                          children: [

                            const Text(
                              "Subtotal",
                              style: TextStyle(fontSize: 15),
                            ),

                            Text(
                              "₹${subtotal.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                          children: [

                            Text(
                              "Discount",
                              style: TextStyle(fontSize: 15),
                            ),

                            Text(
                              "-₹0",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                          children: [

                            const Text(
                              "Delivery Charges",
                              style: TextStyle(fontSize: 15),
                            ),

                            Text(
                              subtotal >= 500
                                  ? "FREE"
                                  : "₹40",
                              style: TextStyle(
                                color: subtotal >= 500
                                    ? Colors.green
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        const Divider(),

                        const SizedBox(height: 14),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                          children: [

                            const Text(
                              "Total Amount",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            Text(
                              "₹${totalAmount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.primaryGold,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// PAYMENT INFO
                  Container(

                    margin:
                    const EdgeInsets.symmetric(horizontal: 16),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Row(
                      children: [

                        Icon(
                          Icons.security,
                          color: Colors.green,
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            "100% Secure Payments",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                ],
              ),
            ),
          ),

          /// BOTTOM BUTTON
          Container(

            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                )
              ],
            ),

            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        "Payable Amount",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        "₹${totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        AppColors.primaryGold,

                        foregroundColor:
                        AppColors.textBlack,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),

                      onPressed: () {

                        Navigator.pushNamed(
                          context,
                          "payment",
                        );

                      },

                      child: const Text(
                        "Proceed To Payment",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}