import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../Model/WithdrawAmountModel.dart';
import '../../utils/auth_service.dart';

class WithdrawAmountScreen extends StatefulWidget {
  const WithdrawAmountScreen({super.key});

  @override
  State<WithdrawAmountScreen> createState() =>
      _WithdrawAmountScreenState();
}

class _WithdrawAmountScreenState
    extends State<WithdrawAmountScreen> {

  final AuthService _service = AuthService();

  List<WithdrawAmountModel> withdrawList = [];

  bool isLoading = true;

  double availableBalance = 0;

  @override
  void initState() {
    super.initState();
    fetchWithdrawData();
  }

  Future<void> fetchWithdrawData() async {

    try {

      final box = Hive.box('authBox');

      String? selfId = box.get('selfId');

      if (selfId == null || selfId.isEmpty) {
        throw Exception("Self ID not found");
      }

      final data =
      await _service.getWithdrawAmount(selfId);

      setState(() {

        withdrawList = data;

        availableBalance = data.fold(
          0,
              (sum, item) => sum + item.amount,
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

    if (date.isEmpty) return "--";

    try {

      DateTime dateTime = DateTime.parse(date);

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

      appBar: AppBar(
        title: const Text("Withdraw Amount"),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : Column(

        children: [

          /// 🔥 Available Balance Card
          Card(

            elevation: 5,

            margin: const EdgeInsets.all(10),

            child: ListTile(

              leading: const Icon(
                Icons.account_balance_wallet,
                color: Colors.green,
              ),

              title: const Text(
                "Available Balance",
              ),

              trailing: Text(
                "₹ $availableBalance",

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ),

          Expanded(

            child: SingleChildScrollView(

              scrollDirection: Axis.horizontal,

              child: DataTable(

                columnSpacing: 20,

                columns: const [

                  DataColumn(
                    label: Text("Sr No"),
                  ),

                  DataColumn(
                    label: Text("Payment Date"),
                  ),

                  DataColumn(
                    label: Text("Customer Id"),
                  ),

                  DataColumn(
                    label: Text("Customer Name"),
                  ),

                  DataColumn(
                    label: Text("Amount"),
                  ),

                  DataColumn(
                    label: Text("Withdraw Date"),
                  ),

                  DataColumn(
                    label: Text("Status"),
                  ),
                ],

                rows: List.generate(

                  withdrawList.length,

                      (index) {

                    final item = withdrawList[index];

                    return DataRow(

                      cells: [

                        /// Sr No
                        DataCell(
                          Text("${index + 1}"),
                        ),

                        /// Payment Date
                        DataCell(
                          Text(
                            item.paymentDate == null
                                ? "--"
                                : formatDate(
                              item.paymentDate!,
                            ),
                          ),
                        ),

                        /// Customer Id
                        DataCell(
                          Text(item.userId),
                        ),

                        /// Customer Name
                        DataCell(
                          Text(item.userName),
                        ),

                        /// Amount
                        DataCell(
                          Text("₹ ${item.amount}"),
                        ),

                        /// Withdraw Date
                        DataCell(
                          Text(
                            formatDate(item.date),
                          ),
                        ),

                        /// Status
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}