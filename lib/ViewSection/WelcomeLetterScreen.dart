import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../Model/WelcomeLetterModel.dart';
import '../../utils/auth_service.dart';

class WelcomeLetterScreen extends StatefulWidget {

  const WelcomeLetterScreen({super.key});

  @override
  State<WelcomeLetterScreen> createState() =>
      _WelcomeLetterScreenState();
}

class _WelcomeLetterScreenState
    extends State<WelcomeLetterScreen> {

  final AuthService _service = AuthService();

  bool isLoading = true;

  WelcomeLetterModel? data;

  @override
  void initState() {
    super.initState();
    fetchWelcomeLetter();
  }

  Future<void> fetchWelcomeLetter() async {

    try {

      final box = Hive.box('authBox');

      String? selfId = box.get('selfId');

      if (selfId == null || selfId.isEmpty) {
        throw Exception("Self ID not found");
      }

      final result =
      await _service.getWelcomeLetter(selfId);

      setState(() {

        data = result;

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

      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(

        backgroundColor: Colors.white,

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "Welcome",

          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : SingleChildScrollView(

        padding: const EdgeInsets.all(14),

        child: Container(

          width: double.infinity,

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(

              color: Colors.white,

            borderRadius:
            BorderRadius.circular(12),

            border: Border.all(
              color: Colors.black12,
            ),
          ),

          child: Column(

            children: [

              /// 🔥 Profile Image
              CircleAvatar(

                radius: 50,

                backgroundColor: Colors.white,

                backgroundImage: NetworkImage(

                  "https://glamorousfilmcity.com${data!.profilePic}",
                ),
              ),

              const SizedBox(height: 14),

              /// 🔥 Name
              Text(

                data!.fullName,

                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 Info Section
              Row(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  /// LEFT SIDE
                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        _infoText(
                          "Email Id",
                          data!.email,
                        ),

                        _infoText(
                          "Contact Number",
                          data!.mobile,
                        ),

                        _infoText(
                          "Address",
                          data!.address,
                        ),

                        _infoText(
                          "Joining Date",
                          formatDate(
                            data!.joiningDate,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// RIGHT SIDE
                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        _infoText(
                          "User Id",
                          data!.selfId,
                        ),

                        _infoText(
                          "Sponsor Id",
                          data!.sponsorId ?? "N/A",
                        ),

                        _infoText(
                          "City",
                          data!.city,
                        ),

                        _infoText(
                          "Country",
                          data!.country,
                        ),

                      ],
                    ),


                  ),
                ],

              ),


          const SizedBox(height: 30),

          /// 🔥 Welcome Description
          Container(

            width: double.infinity,

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(


              borderRadius: BorderRadius.circular(20),

              border: Border.all(
                color: Colors.grey.shade200,
              ),

              boxShadow: [

                BoxShadow(

                  color: const Color(0xFFF8F8F8),

                  blurRadius: 12,

                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: const Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  "Dear Member,",

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 14),

                Text(

                  "Congratulations,\n\n"

                      "On your decision to soar sky high with us.\n\n"

                      "You are now a part of the opportunity of the millennium. "
                      "Glamorous Film City is an exciting business that helps turn "
                      "your dreams into reality. As you build your business, you "
                      "will establish lifelong friendships and develop a support "
                      "system like no other.\n\n"

                      "Glamorous Film City is here to H.E.L.P. "
                      "(High Energy Level Participation) to help you succeed. "
                      "We pledge our best effort to support your business.\n\n"

                      "The bottom line of Glamorous Film City: "
                      "When you network with us, we all stand together to win "
                      "and impact thousands of lives positively.\n\n"

                      "We are confident that you will gain great satisfaction "
                      "from Glamorous Film City. We wish you every success!\n\n"

                      "Keep it up! See you at the top!\n\n"

                      "Winning regards,\n\n"

                      "Glamorous Film City",

                  style: TextStyle(
                    fontSize: 15,
                    height: 1.7,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
            ],
          ),
        ),
      ),
      );
  }

  /// 🔥 Common Info Widget
  Widget _infoText(
      String title,
      String value,
      ) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 16),

      child: RichText(

        text: TextSpan(

          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),

          children: [

            TextSpan(

              text: "$title : ",

              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            TextSpan(
              text: value,
            ),
          ],
        ),
      ),
    );
  }
}