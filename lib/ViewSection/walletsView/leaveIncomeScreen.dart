import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Model/LevelIncomeModel.dart';
import '../../utils/auth_service.dart';

class LevelIncomeScreen extends StatefulWidget {
  const LevelIncomeScreen({super.key});

  @override
  State<LevelIncomeScreen> createState() =>
      _LevelIncomeScreenState();
}

class _LevelIncomeScreenState
    extends State<LevelIncomeScreen> {

  final AuthService _service = AuthService();

  List<LevelIncomeModel> levelList = [];

  bool isLoading = true;

  double totalIncome = 0;

  @override
  void initState() {
    super.initState();
    fetchLevelIncome();
  }

  Future<void> fetchLevelIncome() async {

    try {

      final box = Hive.box('authBox');

      String? selfId = box.get('selfId');

      if (selfId == null || selfId.isEmpty) {
        throw Exception("Self ID not found");
      }

      final data =
      await _service.getLevelIncome(selfId);

      setState(() {

        levelList = data;

        totalIncome = data.fold(
          0,
              (sum, item) => sum + item.amount,
        );

        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      debugPrint(e.toString());
    }
  }

  String formatDate(String date) {
    return date.split("T")[0];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Level Income"),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )

          : Column(
        children: [

          /// 🔥 Total Income Card
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              leading: const Icon(
                Icons.account_balance_wallet,
                color: Colors.green,
              ),

              title: const Text(
                "Total Income",
              ),

              trailing: Text(
                "₹ $totalIncome",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
                    label: Text("From ID"),
                  ),

                  DataColumn(
                    label: Text("Level"),
                  ),

                  DataColumn(
                    label: Text("Amount"),
                  ),

                  DataColumn(
                    label: Text("Remarks"),
                  ),

                  DataColumn(
                    label: Text("Status"),
                  ),

                  DataColumn(
                    label: Text("Date"),
                  ),
                ],

                rows: List.generate(

                  levelList.length,

                      (index) {

                    final item = levelList[index];

                    return DataRow(

                      cells: [

                        DataCell(
                          Text("${index + 1}"),
                        ),

                        DataCell(
                          Text(item.fromUserId),
                        ),

                        DataCell(
                          Text(
                            item.level.toString(),
                          ),
                        ),

                        DataCell(
                          Text("₹ ${item.amount}"),
                        ),

                        DataCell(
                          Text(item.remarks),
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
                            ),
                          ),
                        ),

                        DataCell(
                          Text(
                            formatDate(item.date),
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