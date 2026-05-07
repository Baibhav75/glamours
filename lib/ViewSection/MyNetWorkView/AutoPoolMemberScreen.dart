import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../Model/AutoPoolMemberModel.dart';
import '../../utils/auth_service.dart';

class AutoPoolMemberScreen extends StatefulWidget {

  final String poolType;

  const AutoPoolMemberScreen({
    super.key,
    required this.poolType,
  });

  @override
  State<AutoPoolMemberScreen> createState() =>
      _AutoPoolMemberScreenState();
}

class _AutoPoolMemberScreenState
    extends State<AutoPoolMemberScreen> {

  final AuthService _service = AuthService();

  List<AutoPoolMemberModel> levelList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAutoPool();
  }

  Future<void> fetchAutoPool() async {

    try {

      final box = Hive.box('authBox');

      String? selfId = box.get('selfId');

      if (selfId == null || selfId.isEmpty) {
        throw Exception("Self ID not found");
      }

      final data = await _service.getAutoPoolList(
        selfId,
        widget.poolType,
      );

      setState(() {

        levelList = data;

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

      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),

      child: Text(

        text,

        overflow: TextOverflow.ellipsis,

        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight:
          fontWeight ?? FontWeight.w500,
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

        backgroundColor: const Color(0xFFF72585),

        elevation: 2,

        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        title: Text(

          widget.poolType,

          style: const TextStyle(

            color: Colors.black,

            fontWeight: FontWeight.bold,

            fontSize: 20,
          ),
        ),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFF72585),
        ),
      )

          : ListView.builder(

        padding: const EdgeInsets.all(12),

        itemCount: levelList.length,

        itemBuilder: (context, levelIndex) {

          final levelData =
          levelList[levelIndex];

          return Container(

            margin: const EdgeInsets.only(
              bottom: 20,
            ),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(20),

              boxShadow: [

                BoxShadow(

                  color:
                  Colors.black.withOpacity(0.08),

                  blurRadius: 10,

                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Column(

              children: [

                /// 🔥 LEVEL HEADER
                Container(

                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(14),

                  decoration:
                  const BoxDecoration(

                    gradient: LinearGradient(

                      colors: [

                        Color(0xFFF72585),
                        Color(0xFFB5179E),
                      ],
                    ),

                    borderRadius:
                    BorderRadius.only(

                      topLeft:
                      Radius.circular(20),

                      topRight:
                      Radius.circular(20),
                    ),
                  ),

                  child: Text(

                    "Level ${levelData.level} Members",

                    style: const TextStyle(

                      color: Colors.white,

                      fontSize: 18,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /// 🔥 TABLE
                SingleChildScrollView(

                  scrollDirection:
                  Axis.horizontal,

                  child: Column(

                    children: [

                      /// 🔥 TABLE HEADER
                      Container(

                        color:
                        Colors.pink.shade50,

                        padding:
                        const EdgeInsets.symmetric(
                          vertical: 14,
                        ),

                        child: Row(

                          children: [

                            SizedBox(
                              width: 60,
                              child: tableCell(
                                "#",
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              width: 180,
                              child: tableCell(
                                "DateTime",
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              width: 150,
                              child: tableCell(
                                "Pool Name",
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              width: 140,
                              child: tableCell(
                                "User ID",
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              width: 180,
                              child: tableCell(
                                "Name",
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              width: 120,
                              child: tableCell(
                                "Status",
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 🔥 TABLE ROWS
                      ...List.generate(

                        levelData.users.length,

                            (index) {

                          final user =
                          levelData.users[index];

                          return Container(

                            padding:
                            const EdgeInsets.symmetric(
                              vertical: 14,
                            ),

                            decoration: BoxDecoration(

                              border: Border(

                                bottom: BorderSide(
                                  color:
                                  Colors.grey.shade200,
                                ),
                              ),
                            ),

                            child: Row(

                              children: [

                                SizedBox(
                                  width: 60,
                                  child: tableCell(
                                    "${index + 1}",
                                  ),
                                ),

                                SizedBox(
                                  width: 180,
                                  child: tableCell(
                                    formatDate(
                                      user.joiningDate,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 150,
                                  child: tableCell(
                                    user.poolName,
                                  ),
                                ),

                                SizedBox(
                                  width: 140,
                                  child: tableCell(
                                    user.selfId,
                                  ),
                                ),

                                SizedBox(
                                  width: 180,
                                  child: tableCell(
                                    user.fullName,
                                  ),
                                ),

                                SizedBox(
                                  width: 120,
                                  child: tableCell(

                                    user.isActive
                                        ? "Active"
                                        : "Inactive",

                                    color:
                                    user.isActive
                                        ? Colors.green
                                        : Colors.red,

                                    fontWeight:
                                    FontWeight.bold,
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
              ],
            ),
          );
        },
      ),
    );
  }
}