import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controller/wallet_controller.dart';
import '../theme/app_colors.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final WalletController controller = Get.put(WalletController());

  /// ✅ ROBUST DATE FORMAT FUNCTION
  String formatDate(String date) {
    if (date.isEmpty) return "N/A";
    try {
      // Handle cases like "2026-03-28T11:54:46.267" or "2026-03-28 11:54:46"
      final parsedDate = DateTime.parse(date.replaceAll(' ', 'T'));
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
    } catch (e) {
      print("formatDate Error: $e for date: $date");
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlack,
      appBar: AppBar(
        title: const Text(
          "My Wallet",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.backgroundBlack,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryGold),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryGold),
          );
        }

        final data = controller.wallet.value?.data;

        if (data == null || !controller.wallet.value!.status) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_balance_wallet_outlined, size: 80, color: AppColors.textGray),
                const SizedBox(height: 16),
                Text(
                  controller.wallet.value?.message ?? "No Wallet Data",
                  style: const TextStyle(color: AppColors.textGray, fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshWallet(),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold),
                  child: const Text("Retry", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshWallet(),
          color: AppColors.primaryGold,
          backgroundColor: AppColors.backgroundDarkGray,
          child: CustomScrollView(
            slivers: [
              /// 🔥 WALLET SUMMARY CARD
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGold.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Balance",
                          style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "₹${data.walletBalance.toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoMini("Total Credit", "₹${data.credit.toStringAsFixed(2)}", Icons.arrow_downward, AppColors.successGreen),
                            _buildInfoMini("Total Debit", "₹${data.debit.toStringAsFixed(2)}", Icons.arrow_upward, AppColors.errorRed),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Recent Transactions",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              /// 🔥 TRANSACTIONS LIST
              data.transactions.isEmpty
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text("No transactions found", style: TextStyle(color: AppColors.textGray)),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final tx = data.transactions[index];
                            final isCredit = tx.flag.toUpperCase() == "C";

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundDarkGray,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.borderDark, width: 1),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                leading: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: (isCredit ? AppColors.successGreen : AppColors.errorRed).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isCredit ? Icons.add_rounded : Icons.remove_rounded,
                                    color: isCredit ? AppColors.successGreen : AppColors.errorRed,
                                  ),
                                ),
                                title: Text(
                                  tx.incomeType,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatDate(tx.date),
                                        style: const TextStyle(color: AppColors.textGray, fontSize: 12),
                                      ),
                                      if (tx.fromUserId.isNotEmpty)
                                        Text(
                                          "ID: ${tx.fromUserId}",
                                          style: TextStyle(color: AppColors.primaryGold.withOpacity(0.7), fontSize: 11),
                                        ),
                                    ],
                                  ),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${isCredit ? '+' : '-'} ₹${tx.amount.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        color: isCredit ? AppColors.successGreen : AppColors.errorRed,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      tx.status,
                                      style: TextStyle(
                                        color: tx.status.toLowerCase() == "approved" ? AppColors.successGreen : Colors.orange,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: data.transactions.length,
                        ),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoMini(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.black54, fontSize: 11)),
            Text(value, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}