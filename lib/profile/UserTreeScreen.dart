import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Model/UserTreeModel.dart';
import '../../utils/auth_service.dart';

class UserTreeScreen
    extends StatefulWidget {

  const UserTreeScreen({
    super.key,
  });

  @override
  State<UserTreeScreen>
  createState() =>
      _UserTreeScreenState();
}



class _UserTreeScreenState
    extends State<UserTreeScreen> {

  final AuthService _service =
  AuthService();

  UserTreeModel? userTree;

  bool isLoading = true;
  TextEditingController searchController =
  TextEditingController();

  List<TreeMember> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    fetchTree();
  }

  Future<void> fetchTree() async {

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
      await _service.getUserTree(
        selfId,
      );

      setState(() {
        userTree = data;
        filteredMembers = data.treeMembers;
        isLoading = false;
      });

    } catch (e) {

      debugPrint(e.toString());

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildMemberNode({

    required String image,
    required String name,
    required bool isActive,

  }) {

    return Column(

      children: [

        Container(

          padding: const EdgeInsets.all(3),

          decoration: BoxDecoration(

            shape: BoxShape.circle,

            border: Border.all(

              color:
              isActive

                  ? Colors.green

                  : Colors.red,

              width: 3,
            ),
          ),

          child: CircleAvatar(

            radius: 42,

            backgroundColor:
            Colors.white,

            backgroundImage:

            image.isNotEmpty

                ? NetworkImage(
              "https://glamorousfilmcity.com$image",
            )

                : const NetworkImage(
              "https://cdn-icons-png.flaticon.com/512/149/149071.png",
            ),
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(

          width: 110,

          child: Text(

            name,

            textAlign: TextAlign.center,

            maxLines: 2,

            overflow:
            TextOverflow.ellipsis,

            style: const TextStyle(

              color: Colors.white,

              fontSize: 16,

              fontWeight:
              FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF72585),

      appBar: AppBar(

        backgroundColor:  const Color(0xFFF72585),

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "User Tree",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(
          color: Colors.pink,
        ),
      )

          : SingleChildScrollView(

        child: Column(

          children: [

            const SizedBox(height: 20),

            /// 🔥 MAIN USER
            buildMemberNode(

              image:
              userTree!
                  .userDetail
                  .profilePic,

              name:
              userTree!
                  .userDetail
                  .fullName,

              isActive:
              userTree!
                  .userDetail
                  .isActive,
            ),

            const SizedBox(height: 40),

            /// 🔥 TREE MEMBERS
            Padding(

              padding:
              const EdgeInsets.symmetric(
                horizontal: 12,
              ),

              child: Wrap(

                spacing: 28,

                runSpacing: 40,

                alignment:
                WrapAlignment.center,

                children:

                userTree!
                    .treeMembers

                    .map(

                      (member) {

                    return buildMemberNode(

                      image:
                      member.profilePic,

                      name:
                      member.fullName,

                      isActive:
                      member.isActive,
                    );
                  },
                ).toList(),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}