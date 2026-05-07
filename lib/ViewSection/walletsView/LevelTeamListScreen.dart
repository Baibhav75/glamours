import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../Model/LevelTeamListModel.dart';
import '../../utils/auth_service.dart';

class LevelTeamListScreen extends StatefulWidget {

  const LevelTeamListScreen({super.key});

  @override
  State<LevelTeamListScreen> createState() =>
      _LevelTeamListScreenState();
}

class _LevelTeamListScreenState
    extends State<LevelTeamListScreen> {

  final AuthService _service = AuthService();

  List<LevelTeamListModel> teamList = [];

  bool isLoading = true;

  int totalMembers = 0;

  @override
  void initState() {
    super.initState();
    fetchLevelTeam();
  }

  Future<void> fetchLevelTeam() async {

    try {

      final box = Hive.box('authBox');

      String? selfId = box.get('selfId');

      if (selfId == null || selfId.isEmpty) {
        throw Exception("Self ID not found");
      }

      final data =
      await _service.getLevelTeamList(selfId);

      setState(() {

        teamList = data;

        totalMembers = data.length;

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
        title: const Text("Level Team List"),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : Column(

        children: [

          /// 🔥 Total Members Card
          Card(

            elevation: 5,

            margin: const EdgeInsets.all(10),

            child: ListTile(

              leading: const Icon(
                Icons.groups,
                color: Colors.blue,
              ),

              title: const Text(
                "Total Members",
              ),

              trailing: Text(
                totalMembers.toString(),

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
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
                    label: Text("Date"),
                  ),

                  DataColumn(
                    label: Text("Customer ID"),
                  ),

                  DataColumn(
                    label: Text("Name"),
                  ),

                  DataColumn(
                    label: Text("Sponsor ID"),
                  ),

                  DataColumn(
                    label: Text("Sponsor Name"),
                  ),

                  DataColumn(
                    label: Text("Status"),
                  ),

                  DataColumn(
                    label: Text("Level"),
                  ),
                ],

                rows: List.generate(

                  teamList.length,

                      (index) {

                    final item = teamList[index];

                    return DataRow(

                      cells: [

                        /// Sr No
                        DataCell(
                          Text("${index + 1}"),
                        ),

                        /// Date
                        DataCell(
                          Text(
                            formatDate(item.date),
                          ),
                        ),

                        /// Customer ID
                        DataCell(
                          Text(item.userId),
                        ),

                        /// Name
                        DataCell(
                          Text(item.name),
                        ),

                        /// Sponsor ID
                        DataCell(
                          Text(item.sponsorId),
                        ),

                        /// Sponsor Name
                        DataCell(
                          Text(item.sponsorName),
                        ),

                        /// Status
                        DataCell(

                          Text(

                            item.active
                                ? "Active"
                                : "Inactive",

                            style: TextStyle(

                              color:
                              item.active
                                  ? Colors.green
                                  : Colors.red,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),

                        /// Level
                        DataCell(
                          Text(
                            item.level.toString(),
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