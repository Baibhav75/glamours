import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../Model/PoolDeductionWalletModel.dart';
import '../../utils/auth_service.dart';

class PoolDeductionWalletScreen
    extends StatefulWidget {

  const PoolDeductionWalletScreen({
    super.key,
  });

  @override
  State<PoolDeductionWalletScreen>
  createState() =>
      _PoolDeductionWalletScreenState();
}

class _PoolDeductionWalletScreenState
    extends State<PoolDeductionWalletScreen> {

  final AuthService _service =
  AuthService();

  List<PoolDeductionWalletModel>
  walletList = [];

  bool isLoading = true;

  double totalCredit = 0;
  double totalDebit = 0;
  double balance = 0;

  @override
  void initState() {
    super.initState();
    fetchWallet();
  }

  Future<void> fetchWallet() async {

    try {

      final box =
      Hive.box('authBox');

      String? selfId =
      box.get('selfId');

      if (selfId == null ||
          selfId.isEmpty) {

        throw Exception(
          "Self ID not found",
        );
      }

      final data =
      await _service
          .getPoolDeductionWallet(
        selfId,
      );

      setState(() {

        walletList = data;

        /// CREDIT
        totalCredit = data

            .where(
              (e) => e.flag == "C",
        )

            .fold(
          0,
              (sum, item) =>
          sum + item.amount,
        );

        /// DEBIT
        totalDebit = data

            .where(
              (e) => e.flag == "D",
        )

            .fold(
          0,
              (sum, item) =>
          sum + item.amount,
        );

        /// BALANCE
        balance =
            totalCredit - totalDebit;

        isLoading = false;
      });

    } catch (e) {

      debugPrint(e.toString());

      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDate(String date) {

    try {

      DateTime dateTime =
      DateTime.parse(date);

      return DateFormat(
        'dd-MM-yyyy hh:mm a',
      ).format(dateTime);

    } catch (e) {

      return "--";
    }
  }

  Widget tableCell(
      String text, {
        Color? color,
        FontWeight? fontWeight,
      }) {

    return Padding(

      padding:
      const EdgeInsets.symmetric(
        horizontal: 8,
      ),

      child: Text(

        text,

        overflow:
        TextOverflow.ellipsis,

        style: TextStyle(
          color:
          color ?? Colors.black87,
          fontWeight:
          fontWeight ??
              FontWeight.w500,
        ),
      ),
    );
  }

  Widget topCard(
      String title,
      String amount,
      Color color,
      IconData icon,
      ) {

    return Expanded(

      child: Container(

        margin:
        const EdgeInsets.symmetric(
          horizontal: 6,
        ),

        padding:
        const EdgeInsets.all(14),

        decoration: BoxDecoration(

          color: color,

          borderRadius:
          BorderRadius.circular(16),
        ),

        child: Column(

          children: [

            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),

            const SizedBox(height: 10),

            Text(

              title,

              style: const TextStyle(

                color: Colors.white70,

                fontSize: 14,
              ),
            ),

            const SizedBox(height: 6),

            Text(

              amount,

              style: const TextStyle(

                color: Colors.white,

                fontSize: 20,

                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF5F5F5),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFFF72585),

        elevation: 2,

        centerTitle: true,

        iconTheme:
        const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(

          "Pool Deduction Wallet",

          style: TextStyle(

            color: Colors.black,

            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(
          color: Color(0xFFF72585),
        ),
      )

          : Column(

        children: [

          /// 🔥 TOP CARDS
          Padding(

            padding:
            const EdgeInsets.all(12),

            child: Row(

              children: [

                topCard(
                  "Credit",
                  "₹ $totalCredit",
                  Colors.green,
                  Icons.arrow_downward,
                ),

                topCard(
                  "Debit",
                  "₹ $totalDebit",
                  Colors.red,
                  Icons.arrow_upward,
                ),

                topCard(
                  "Balance",
                  "₹ $balance",
                  const Color(0xFFF72585),
                  Icons.account_balance_wallet,
                ),
              ],
            ),
          ),

          /// 🔥 TABLE
          Expanded(

            child: SingleChildScrollView(

              child: SingleChildScrollView(

                scrollDirection: Axis.horizontal,

                child: DataTable(

                  columnSpacing: 25,

                  headingRowColor:

                  MaterialStateProperty.all(
                    Colors.pink.shade50,
                  ),

                  columns: const [

                    DataColumn(
                      label: Text(
                        "#",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "From ID",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Remarks",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Amount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Type",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],

                  rows: List.generate(

                    walletList.length,

                        (index) {

                      final item =
                      walletList[index];

                      return DataRow(

                        cells: [

                          DataCell(
                            Text("${index + 1}"),
                          ),

                          DataCell(
                            Text(
                              formatDate(
                                item.createDate,
                              ),
                            ),
                          ),

                          DataCell(
                            Text(
                              item.fromUserId ?? "-",
                            ),
                          ),

                          DataCell(
                            SizedBox(

                              width: 220,

                              child: Text(
                                item.remarks,
                              ),
                            ),
                          ),

                          DataCell(

                            Text(

                              "₹ ${item.amount}",

                              style: TextStyle(

                                color:
                                item.flag == "C"

                                    ? Colors.green
                                    : Colors.red,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),

                          DataCell(

                            Text(

                              item.flag == "C"
                                  ? "Credit"
                                  : "Debit",

                              style: TextStyle(

                                color:
                                item.flag == "C"

                                    ? Colors.green
                                    : Colors.red,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),

                          DataCell(

                            Text(

                              item.status,

                              style: TextStyle(

                                color:
                                item.status == "Approved"

                                    ? Colors.green
                                    : Colors.orange,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}