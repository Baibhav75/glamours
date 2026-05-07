import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../Model/ShoppingLevelIncomeModel.dart';
import '../../utils/auth_service.dart';

class ShoppingLevelIncomeScreen
    extends StatefulWidget {

  const ShoppingLevelIncomeScreen({
    super.key,
  });

  @override
  State<ShoppingLevelIncomeScreen>
  createState() =>
      _ShoppingLevelIncomeScreenState();
}

class _ShoppingLevelIncomeScreenState
    extends State<ShoppingLevelIncomeScreen> {

  final AuthService _service =
  AuthService();

  List<ShoppingLevelIncomeModel>
  incomeList = [];

  bool isLoading = true;

  double totalIncome = 0;

  @override
  void initState() {
    super.initState();
    fetchIncome();
  }

  Future<void> fetchIncome() async {

    try {

      final box = Hive.box('authBox');

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
          .getShoppingLevelIncome(
        selfId,
      );

      setState(() {

        incomeList = data;

        totalIncome = data.fold(
          0,
              (sum, item) =>
          sum + item.amount,
        );

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

          "Shopping Level Income",

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

          /// 🔥 TOTAL CARD
          Container(

            margin:
            const EdgeInsets.all(12),

            padding:
            const EdgeInsets.all(16),

            decoration: BoxDecoration(

              gradient:
              const LinearGradient(

                colors: [

                  Color(0xFFF72585),
                  Color(0xFFB5179E),
                ],
              ),

              borderRadius:
              BorderRadius.circular(
                18,
              ),
            ),

            child: Row(

              children: [

                const CircleAvatar(

                  radius: 28,

                  backgroundColor:
                  Colors.white,

                  child: Icon(

                    Icons.wallet,

                    color:
                    Color(0xFFF72585),

                    size: 30,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      const Text(

                        "Total Income",

                        style: TextStyle(

                          color:
                          Colors.white70,

                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Text(

                        "₹ $totalIncome",

                        style:
                        const TextStyle(

                          color:
                          Colors.white,

                          fontSize: 24,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 TABLE
          Expanded(

            child:
            SingleChildScrollView(

              scrollDirection:
              Axis.horizontal,

              child: Column(

                children: [

                  /// 🔥 HEADER
                  Container(

                    color:
                    Colors.pink.shade50,

                    padding:
                    const EdgeInsets
                        .symmetric(
                      vertical: 14,
                    ),

                    child: Row(

                      children: [

                        SizedBox(
                          width: 60,
                          child:
                          tableCell(
                            "#",
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        SizedBox(
                          width: 180,
                          child:
                          tableCell(
                            "Date",
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        SizedBox(
                          width: 150,
                          child:
                          tableCell(
                            "From ID",
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        SizedBox(
                          width: 180,
                          child:
                          tableCell(
                            "Name",
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        SizedBox(
                          width: 200,
                          child:
                          tableCell(
                            "Remarks",
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        SizedBox(
                          width: 120,
                          child:
                          tableCell(
                            "Amount",
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        SizedBox(
                          width: 120,
                          child:
                          tableCell(
                            "Status",
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔥 ROWS
                  ...List.generate(

                    incomeList.length,

                        (index) {

                      final item =
                      incomeList[index];

                      return Container(

                        padding:
                        const EdgeInsets
                            .symmetric(
                          vertical: 14,
                        ),

                        decoration:
                        BoxDecoration(

                          color:
                          Colors.white,

                          border: Border(

                            bottom:
                            BorderSide(
                              color: Colors
                                  .grey
                                  .shade200,
                            ),
                          ),
                        ),

                        child: Row(

                          children: [

                            SizedBox(
                              width: 60,
                              child:
                              tableCell(
                                "${index + 1}",
                              ),
                            ),

                            SizedBox(
                              width: 180,
                              child:
                              tableCell(
                                formatDate(
                                  item.date,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 150,
                              child:
                              tableCell(
                                item
                                    .fromUserId,
                              ),
                            ),

                            SizedBox(
                              width: 180,
                              child:
                              tableCell(
                                item
                                    .fromUserName,
                              ),
                            ),

                            SizedBox(
                              width: 200,
                              child:
                              tableCell(
                                item.remarks,
                              ),
                            ),

                            SizedBox(
                              width: 120,
                              child:
                              tableCell(
                                "₹ ${item.amount}",
                                color: Colors
                                    .green,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),

                            SizedBox(
                              width: 120,
                              child:
                              tableCell(

                                item.status,

                                color:
                                item.status ==
                                    "Approved"

                                    ? Colors
                                    .green

                                    : Colors
                                    .orange,

                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}