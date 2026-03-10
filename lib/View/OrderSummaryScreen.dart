import 'package:flutter/material.dart';
import '  payment_page.dart';
import '../location/select_address_sheet.dart';
import '../theme/app_colors.dart';

class OrderSummaryScreen extends StatefulWidget {
  final Map<dynamic, dynamic> product;
  final String selectedSize;
  final Color selectedColor;
  final int quantity;

  const OrderSummaryScreen({
    super.key,
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {

  String userName = "User Name";
  String userPhone = "+91 9876543210";

  String userAddress =
      "123 Main Street, Phase 1, City Name, State, 123456";

  @override
  Widget build(BuildContext context) {

    String name = widget.product["name"] ?? "Product Name";
    String priceStr = widget.product["discountPrice"]?.toString() ??
        widget.product["price"]?.toString() ??
        "0";

    String image =
        widget.product["image"] ?? "https://via.placeholder.com/150";

    double price = double.tryParse(priceStr) ?? 0.0;

    double deliveryCharge = 40.0;

    double totalAmount = (price * widget.quantity) + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        backgroundColor: AppColors.backgroundWhite,
        foregroundColor: AppColors.textBlack,
        elevation: 0,
      ),

      backgroundColor: AppColors.backgroundLightGray,

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// DELIVERY ADDRESS
            Container(
              color: AppColors.backgroundWhite,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        "Deliver to:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      OutlinedButton(

                        onPressed: () async {

                          final result =
                          await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor:
                            Colors.transparent,
                            builder: (context) {
                              return const SelectAddressSheet();
                            },
                          );

                          if (result != null) {

                            setState(() {

                              userAddress = result["address"];

                            });

                          }

                        },

                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(60, 30),
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 12),
                          side: const BorderSide(
                            color: AppColors.accentGold,
                          ),
                        ),

                        child: const Text(
                          "Change",
                          style: TextStyle(
                            color: AppColors.accentGold,
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "$userAddress\nPhone: $userPhone",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            /// PRODUCT INFO
            Container(
              color: AppColors.backgroundWhite,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: 80,
                    height: 80,

                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade300),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.network(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [

                            Text(
                              "Size: ${widget.selectedSize.split(' ')[0]}",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 16),

                            const Text(
                              "Color:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 6),

                            Container(
                              width: 14,
                              height: 14,

                              decoration: BoxDecoration(
                                color: widget.selectedColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.grey
                                        .shade400),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [

                            Text(
                              "₹$priceStr",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Text(
                              "Qty: ${widget.quantity}",
                              style:
                              const TextStyle(fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            /// PRICE DETAILS
            Container(
              color: AppColors.backgroundWhite,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 80),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Price Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const Divider(height: 24),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Text(
                        "Price (${widget.quantity} item)",
                      ),

                      Text(
                        "₹${(price * widget.quantity).toStringAsFixed(2)}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      const Text("Delivery Charges"),

                      Text(
                        "₹${deliveryCharge.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.green),
                      ),
                    ],
                  ),

                  const Divider(height: 24),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        "Total Amount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(
                        "₹${totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// BOTTOM BAR
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12),

        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            )
          ],
        ),

        child: SafeArea(
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    "₹${totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const Text(
                    "View price details",
                    style: TextStyle(
                      color: AppColors.accentGold,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              ElevatedButton(onPressed: () {

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Processing Payment..."),
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                );

              },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGold,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                ),

                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
