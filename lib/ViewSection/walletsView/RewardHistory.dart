import 'package:flutter/material.dart';
import '../../utils/auth_service.dart';
import '/Model/RewardIncomeModel.dart';

class RewardIncomeScreen extends StatefulWidget {
  const RewardIncomeScreen({super.key});

  @override
  State<RewardIncomeScreen> createState() =>
      _RewardIncomeScreenState();
}

class _RewardIncomeScreenState extends State<RewardIncomeScreen> {
  final AuthService _service = AuthService();
  List<RewardIncomeModel> rewardList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await _service.getRewardIncome();
      setState(() {
        rewardList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reward Income"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          columns: const [
            DataColumn(label: Text("Sr No")),
            DataColumn(label: Text("Date Of Joining")),

             // changed
            DataColumn(label: Text("Direct Team")),
            DataColumn(label: Text("Total Team")),
            DataColumn(label: Text("Reward Name")), // changed
            DataColumn(label: Text("Image")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Achieved")),
            DataColumn(label: Text("Action")),
          ],
          rows: List.generate(
            rewardList.length,
                (index) {
              final item = rewardList[index];

              return DataRow( // ✅ IMPORTANT FIX
                cells: [
                  DataCell(Text("${index + 1}")),
                  DataCell(
                    Text(
                      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                    ),
                  ),
                   // Reward Name
                  DataCell(Text(item.direct.toString())),
                  DataCell(Text(item.totalTeam.toString())),
                  DataCell(Text(item.club)), // Club
                  DataCell(
                    item.image.isEmpty
                        ? const Text("No Image")
                        : Image.network(item.image, width: 40),
                  ),
                  const DataCell(
                    Text("Pending", style: TextStyle(color: Colors.orange)),
                  ),
                  DataCell(Text(item.reward)),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("View"),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}