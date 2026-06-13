import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../Model/UserPoolActivationListModel.dart';
import '../../utils/auth_service.dart';

class UserPoolActivationListScreen
    extends StatefulWidget {

  const UserPoolActivationListScreen({
    super.key,
  });

  @override
  State<UserPoolActivationListScreen>
  createState() =>
      _UserPoolActivationListScreenState();
}

class _UserPoolActivationListScreenState
    extends State<UserPoolActivationListScreen> {

  final AuthService _service =
  AuthService();

  List<UserPoolActivationListModel>
  activationList = [];

  bool isLoading = true;

  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    fetchActivationList();
  }

  Future<void> fetchActivationList() async {

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
          .getUserPoolActivationList(
        selfId,
      );

      setState(() {

        activationList = data;

        totalAmount = data.fold(
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF5F5F5),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFFF72585),

        centerTitle: true,

        iconTheme:
        const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(

          "Pool Activation List",

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

          /// 🔥 TOP CARD
          Container(

            margin:
            const EdgeInsets.all(12),

            padding:
            const EdgeInsets.all(18),

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

                    Icons.account_balance_wallet,

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

                        "Total Activation Amount",

                        style: TextStyle(

                          color:
                          Colors.white70,

                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(
                        height: 6,
                      ),

                      Text(

                        "₹ $totalAmount",

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

              child:
              SingleChildScrollView(

                scrollDirection:
                Axis.horizontal,

                child: DataTable(

                  columnSpacing: 24,

                  headingRowColor:

                  MaterialStateProperty.all(
                    Colors.pink.shade50,
                  ),

                  columns: const [

                    DataColumn(
                      label: Text(
                        "SrNo",
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Date",
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Pool Name",
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Amount",
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Payment Type",
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Remark",
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Status",
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        "Screenshot",
                      ),
                    ),
                  ],

                  rows: List.generate(

                    activationList.length,

                        (index) {

                      final item =
                      activationList[index];

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
                              formatDate(
                                item.createDate,
                              ),
                            ),
                          ),

                          DataCell(
                            Text(
                              item.poolName,
                            ),
                          ),

                          DataCell(

                            Text(

                              "₹ ${item.amount}",

                              style:
                              const TextStyle(

                                color:
                                Colors.green,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),

                          DataCell(
                            Text(
                              item.paymentType,
                            ),
                          ),

                          DataCell(

                            SizedBox(

                              width: 160,

                              child: Text(
                                item.remark,
                              ),
                            ),
                          ),

                          DataCell(

                            Text(

                              item.status,

                              style: TextStyle(

                                color:
                                item.status ==
                                    "Approved"

                                    ? Colors.green

                                    : Colors.orange,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),

                          DataCell(

                            item.uploadScreenshot !=
                                null

                                ? GestureDetector(

                              onTap: () {

                                showDialog(

                                  context:
                                  context,

                                  builder:
                                      (_) {

                                    return Dialog(

                                      child:
                                      InteractiveViewer(

                                        child:
                                        Image.network(

                                          "https://glamorousfilmcity.com${item.uploadScreenshot}",
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },

                              child: ClipRRect(

                                borderRadius:
                                BorderRadius.circular(
                                  8,
                                ),

                                child:
                                Image.network(

                                  "https://glamorousfilmcity.com${item.uploadScreenshot}",

                                  height: 50,

                                  width: 50,

                                  fit: BoxFit.cover,
                                ),
                              ),
                            )

                                : const Text(
                              "-",
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