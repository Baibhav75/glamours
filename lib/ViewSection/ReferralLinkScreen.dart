import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../Model/ReferralLinkModel.dart';
import '../../utils/auth_service.dart';

class ReferralLinkScreen extends StatefulWidget {

  const ReferralLinkScreen({super.key});

  @override
  State<ReferralLinkScreen> createState() =>
      _ReferralLinkScreenState();
}

class _ReferralLinkScreenState
    extends State<ReferralLinkScreen> {

  final AuthService _service = AuthService();

  bool isLoading = true;

  String referralLink = "";

  @override
  void initState() {
    super.initState();
    fetchReferralLink();
  }

  Future<void> fetchReferralLink() async {

    try {

      final box = Hive.box('authBox');

      String? selfId = box.get('selfId');

      if (selfId == null || selfId.isEmpty) {
        throw Exception("Self ID not found");
      }

      ReferralLinkModel data =
      await _service.getReferralLink(selfId);

      setState(() {

        referralLink = data.referralLink;

        isLoading = false;
      });

    } catch (e) {

      debugPrint(e.toString());

      setState(() {
        isLoading = false;
      });
    }
  }

  /// 🔥 Common Share Function
  void shareLink() {

    Share.share(
      "Join Glamorous Now 🚀\n\n$referralLink",
    );
  }

  /// 🔥 Copy Link
  void copyLink() {

    Clipboard.setData(
      ClipboardData(text: referralLink),
    );

    Fluttertoast.showToast(
      msg: "Referral Link Copied",
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Referral Link"),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            /// 🔥 Top Banner
            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                borderRadius:
                BorderRadius.circular(20),

                gradient: const LinearGradient(

                  colors: [

                    Color(0xFF7209B7),
                    Color(0xFFF72585),

                  ],
                ),
              ),

              child: Column(

                children: const [

                  Icon(
                    Icons.share,
                    size: 60,
                    color: Colors.white,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Invite & Earn",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Share your referral link and grow your network",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// 🔥 Referral Link Card
            Container(

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(16),

                boxShadow: [

                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Your Referral Link",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 12),

                  SelectableText(
                    referralLink,
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(

                    children: [

                      Expanded(

                        child: ElevatedButton.icon(

                          onPressed: copyLink,

                          icon: const Icon(
                            Icons.copy,
                          ),

                          label: const Text(
                            "Copy",
                          ),

                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.purple,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(

                        child: ElevatedButton.icon(

                          onPressed: shareLink,

                          icon: const Icon(
                            Icons.share,
                          ),

                          label: const Text(
                            "Share",
                          ),

                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// 🔥 Social Share Buttons
            Row(

              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,

              children: [

                _socialButton(
                  icon: Icons.facebook,
                  label: "Facebook",
                  color: Colors.blue,
                  onTap: shareLink,
                ),

                _socialButton(
                  icon: Icons.chat,
                  label: "WhatsApp",
                  color: Colors.green,
                  onTap: shareLink,
                ),

                _socialButton(
                  icon: Icons.camera_alt,
                  label: "Instagram",
                  color: Colors.pink,
                  onTap: shareLink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 Social Button Widget
  Widget _socialButton({

    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,

  }) {

    return GestureDetector(

      onTap: onTap,

      child: Column(

        children: [

          Container(

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(

              color: color.withOpacity(0.1),

              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}