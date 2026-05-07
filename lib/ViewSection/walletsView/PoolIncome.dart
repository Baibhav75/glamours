import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../Model/PoolIncomeModel.dart';
import '../../utils/auth_service.dart';

class PoolIncomeScreen extends StatefulWidget {
  const PoolIncomeScreen({super.key});

  @override
  State<PoolIncomeScreen> createState() => _PoolIncomeScreenState();
}

class _PoolIncomeScreenState extends State<PoolIncomeScreen> {
  final AuthService _service = AuthService();

  List<PoolIncomeModel> poolList = [];
  bool isLoading = true;
  double totalIncome = 0;

  @override
  void initState() {
    super.initState();
    fetchPoolIncome();
  }

  Future<void> fetchPoolIncome() async {
    try {
      final box = Hive.box('authBox');
      String? selfId = box.get('selfId');

      if (selfId == null || selfId.isEmpty) {
        throw Exception("SelfId not found");
      }

      final data = await _service.getPoolIncome(selfId);

      setState(() {
        poolList = data;
        totalIncome =
            data.fold(0, (sum, item) => sum + item.amount);
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  String formatDate(String date) {
    return date.split("T")[0]; // simple format
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pool Income"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // 🔥 Total Income Card
          Card(
            margin: const EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: ListTile(
              title: const Text("Total Income"),
              trailing: Text(
                "₹ $totalIncome",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text("Sr No")),
                  DataColumn(label: Text("From ID")),
                  DataColumn(label: Text("User Name")),
                  DataColumn(label: Text("Amount")),
                  DataColumn(label: Text("Level")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Date")),
                ],
                rows: List.generate(
                  poolList.length,
                      (index) {
                    final item = poolList[index];

                    return DataRow(cells: [
                      DataCell(Text("${index + 1}")),
                      DataCell(Text(item.fromUserId)),
                      DataCell(Text(item.userName)),
                      DataCell(Text("₹ ${item.amount}")),
                      DataCell(Text(item.level.toString())),
                      DataCell(
                        Text(
                          item.status,
                          style: TextStyle(
                            color: item.status == "Approved"
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ),
                      DataCell(Text(formatDate(item.date))),
                    ]);
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