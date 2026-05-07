import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../theme/app_colors.dart';

class PaymentPage extends StatefulWidget {

  final double totalAmount;
  final double walletBalance;

  const PaymentPage({
    super.key,
    required this.totalAmount,
    required this.walletBalance,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  late Razorpay _razorpay;

  late double usedWallet;
  late double payableAmount;

  bool useWallet = true;

  @override
  void initState() {
    super.initState();

    calculateAmounts();

    _razorpay = Razorpay();

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      handlePaymentSuccess,
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      handlePaymentError,
    );

    _razorpay.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
      handleExternalWallet,
    );
  }

  /// CALCULATE WALLET + PAYABLE
  void calculateAmounts() {

    if (useWallet) {

      usedWallet =
      widget.walletBalance >= widget.totalAmount
          ? widget.totalAmount
          : widget.walletBalance;

    } else {

      usedWallet = 0;
    }

    payableAmount =
        widget.totalAmount - usedWallet;

    setState(() {});
  }

  /// OPEN RAZORPAY
  void openCheckout() {

    var options = {

      'key': 'rzp_test_SIQPaxFkbUV8mC',

      'amount':
      (payableAmount * 100).toInt(),

      'name': 'My Shop',

      'description': 'Order Payment',

      'prefill': {
        'contact': '9876543210',
        'email': 'test@example.com',
      },

      'theme': {
        'color': '#FBC02D',
      }
    };

    try {

      _razorpay.open(options);

    } catch (e) {

      debugPrint(e.toString());
    }
  }

  /// PAYMENT SUCCESS
  void handlePaymentSuccess(
      PaymentSuccessResponse response) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(
          "Payment Success: ${response.paymentId}",
        ),
      ),
    );

    /// TODO:
    /// API CALL
    /// SAVE ORDER
    /// DEDUCT WALLET
    /// SAVE TRANSACTION
  }

  /// PAYMENT FAILED
  void handlePaymentError(
      PaymentFailureResponse response) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(
          "Payment Failed: ${response.message}",
        ),
      ),
    );
  }

  /// EXTERNAL WALLET
  void handleExternalWallet(
      ExternalWalletResponse response) {

    debugPrint(
      "External Wallet: ${response.walletName}",
    );
  }

  @override
  void dispose() {

    _razorpay.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
        backgroundColor:
        AppColors.backgroundBlack,
        foregroundColor:
        AppColors.textWhite,
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// PAYMENT CARD
            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(

                gradient:
                AppColors.goldGradient,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.15),

                    blurRadius: 12,

                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 42,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "₹${widget.totalAmount.toStringAsFixed(2)}",

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          const Text(
                            "Wallet Used",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "₹${usedWallet.toStringAsFixed(2)}",

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,

                        children: [

                          const Text(
                            "Payable Amount",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "₹${payableAmount.toStringAsFixed(2)}",

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// USE WALLET SWITCH
            Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(16),
              ),

              child: SwitchListTile(

                value: useWallet,

                activeColor:
                AppColors.primaryGold,

                title: const Text(
                  "Use Wallet Balance",
                  style: TextStyle(
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                subtitle: Text(
                  "Available Wallet: ₹${widget.walletBalance.toStringAsFixed(2)}",
                ),

                onChanged: (value) {

                  useWallet = value;

                  calculateAmounts();
                },
              ),
            ),

            const SizedBox(height: 20),

            /// RAZORPAY OPTION
            Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(16),

                boxShadow: const [

                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ],
              ),

              child: ListTile(

                leading: const Icon(
                  Icons.payment,
                  color: AppColors.accentGold,
                  size: 30,
                ),

                title: const Text(
                  "Pay with Razorpay",
                  style: TextStyle(
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                subtitle: Text(
                  payableAmount <= 0
                      ? "Wallet Payment"
                      : "UPI • Cards • NetBanking",
                ),

                trailing:
                const Icon(Icons.arrow_forward_ios),

                onTap: () {

                  if (payableAmount <= 0) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          "Payment Completed From Wallet",
                        ),
                      ),
                    );

                    return;
                  }

                  openCheckout();
                },
              ),
            ),

            const Spacer(),

            /// PAY BUTTON
            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  if (payableAmount <= 0) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          "Order Placed Successfully",
                        ),
                      ),
                    );

                    return;
                  }

                  openCheckout();
                },

                style: ElevatedButton.styleFrom(

                  backgroundColor:
                  AppColors.accentGold,

                  foregroundColor:
                  AppColors.textBlack,

                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),

                child: Text(

                  payableAmount <= 0
                      ? "Place Order"
                      : "Pay ₹${payableAmount.toStringAsFixed(2)}",

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}