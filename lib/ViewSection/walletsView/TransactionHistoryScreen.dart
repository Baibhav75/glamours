import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Model/TransactionHistoryModel.dart';
import '../../utils/auth_service.dart';

class TransactionHistoryScreen
    extends StatefulWidget {

  const TransactionHistoryScreen({
    super.key,
  });

  @override
  State<TransactionHistoryScreen>
  createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends State<TransactionHistoryScreen> {

  final AuthService _service =
  AuthService();

  List<TransactionHistoryModel>
  transactionList = [];

  bool isLoading = true;

  double totalCredit = 0;
  double totalDebit = 0;
  double balance = 0;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {

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
          .getTransactionHistory(
        selfId,
      );

      setState(() {

        transactionList = data;

        /// CREDIT
        totalCredit = data

            .where(
              (e) => e.flag == "C",
        )

            .fold(
          0,
              (sum, item) {

            return sum +
                double.tryParse(
                  item.pointEarned
                      .replaceAll("+", "")
                      .replaceAll("-", ""),
                )!;
          },
        );

        /// DEBIT
        totalDebit = data

            .where(
              (e) => e.flag == "D",
        )

            .fold(
          0,
              (sum, item) {

            return sum +
                double.tryParse(
                  item.pointEarned
                      .replaceAll("+", "")
                      .replaceAll("-", ""),
                )!;
          },
        );

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
          horizontal: 5,
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

          "Transaction History",

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

                scrollDirection:
                Axis.horizontal,

                child: DataTable(

                  columnSpacing: 25,

                  headingRowColor:

                  MaterialStateProperty.all(
                    Colors.pink.shade50,
                  ),

                  columns: const [

                    DataColumn(
                      label: Text(
                        "SrNo",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Date Time",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Customer ID",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Customer Name",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Mobile",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Remarks",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Points",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Type",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ],

                  rows: List.generate(

                    transactionList.length,

                        (index) {

                      final item =
                      transactionList[index];

                      return DataRow(

                        cells: [

                          DataCell(
                            Text(
                              item.srNo
                                  .toString(),
                            ),
                          ),

                          DataCell(
                            Text(
                              item.dateTime,
                            ),
                          ),

                          DataCell(
                            Text(
                              item.customerId,
                            ),
                          ),

                          DataCell(
                            Text(
                              item.customerName,
                            ),
                          ),

                          DataCell(
                            Text(
                              item.customerMobile,
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

                              item.pointEarned,

                              style: TextStyle(

                                color:
                                item.flag ==
                                    "C"

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
                                item.flag ==
                                    "C"

                                    ? Colors.green
                                    : Colors.red,

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