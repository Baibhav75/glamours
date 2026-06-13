import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:glamorous/ViewSection/wallet_screen.dart';
import '../Controller/profile_controller.dart';
import '../ViewSection/MyNetWorkView/AutoPoolMemberScreen.dart';
import '../ViewSection/ReferralLinkScreen.dart';
import '../ViewSection/ShoppingView/UserPoolActivationListScreen.dart';
import '../ViewSection/WelcomeLetterScreen.dart';
import '../ViewSection/all_popular_clothes_screen.dart';
import '../ViewSection/walletsView/LevelDeductionWalletScreen.dart';
import '../ViewSection/walletsView/LevelTeamListScreen.dart';
import '../ViewSection/walletsView/PoolDeductionWalletScreen.dart';
import '../ViewSection/walletsView/PoolIncome.dart';
import '../ViewSection/walletsView/RewardHistory.dart';
import '../ViewSection/walletsView/ShoppingLeveIncomeScreen.dart';
import '../ViewSection/walletsView/TransactionHistoryScreen.dart';
import '../ViewSection/walletsView/WithDrawRequest.dart';
import '../ViewSection/walletsView/leaveIncomeScreen.dart';
import '../location/add_address_page.dart';
import '../profile/AppInfoPage.dart';
import '../profile/ContactUsPage.dart';
import '../profile/UserTreeScreen.dart';
import '../theme/app_colors.dart';
import 'ChangePassword.dart';
import 'EditProfileScreen.dart';
import 'AboutUsScreen.dart';
import 'OffersPage.dart';
import 'SignInScreen.dart';
import 'cart_page.dart';
import 'order_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    final box = Hive.box('authBox');
    String? selfId = box.get('selfId');
    if (selfId != null) {
      controller.fetchProfile(selfId);
    }
  }

  void _logout(BuildContext context) async {
    try {
      var box = Hive.box('authBox');
      await box.clear(); // Complete cleanup
      
      Get.snackbar(
        'Logged Out',
        'You have been successfully logged out.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );
      
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      print("Logout Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: _buildAppBar(context),
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              _buildQuickAccessIcons(context),
              const SizedBox(height: 16),
              _buildMenuList(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryPurple,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          const Text(
            'Glamorous',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        const Spacer(),
          Text(
            controller.profile.value?.data?.fullName ?? 'User',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipOval(
                child: _buildProfileImage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    final data = controller.profile.value?.data;
    String? imageUrl = data?.profilePic;
    
    // Prefix with domain if it's a relative path
    if (imageUrl != null && imageUrl.startsWith('/')) {
      imageUrl = "https://glamorousfilmcity.com$imageUrl";
    }

    return CachedNetworkImage(
      imageUrl: imageUrl ?? 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&q=80',
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.person, color: Colors.grey),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.person, color: Colors.grey),
      ),
    );
  }
  Widget _buildQuickAccessIcons(BuildContext context) {
    final quickAccessItems = [
      {'name': 'Order', 'icon': Icons.shopping_bag_outlined},
      {'name': 'Cart', 'icon': Icons.shopping_cart_outlined},
      {'name': 'We Team', 'icon': Icons.family_restroom},
      {'name': 'Total Team', 'icon': Icons.group_add_outlined},
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(


            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: quickAccessItems.map((item) {
          return _buildQuickAccessItem(
            context,
            item['name'] as String,
            item['icon'] as IconData,
          );
        }).toList(),
      ),
    );
  }
  Widget _buildQuickAccessItem(
      BuildContext context, String name, IconData icon) {

    return GestureDetector(
      onTap: () {

        if (name == "Order") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderPage(),
            ),
          );
        }
        else if (name == "Cart") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        }
        else if (name == "Offers") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OffersPage(),
            ),
          );
        }

      },

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryPurpleVeryLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryPurple.withOpacity(0.3)),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryPurple,
              size: 24,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    final menuItems = [
      {
        'title': 'Your Address',
        'icon': Icons.location_on_outlined,
        'onTap': () {
          Navigator.push(
              context,MaterialPageRoute(
              builder:(context) => AddAddressPage (),
          ),
          );

        },
      },
      {
        'title': 'All Categories',
        'icon': Icons.grid_view_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AllPopularClothesScreen(),
            ),
          );
        },
      },
      // {
      //   'title': 'Terms And Conditions',
      //   'icon': Icons.description_outlined,
      //   'onTap': () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const AppInfoPage(),
      //       ),
      //     );
      //   },
      // },
      // {
      //   'title': 'Privacy Policy',
      //   'icon': Icons.lock_outline,
      //   'onTap': () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const AppInfoPage(),
      //       ),
      //     );
      //   },
      // },
      // {
      //   'title': 'FAQ',
      //   'icon': Icons.help_outline,
      //   'onTap': () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const AppInfoPage(),
      //       ),
      //     );
      //   },
      // },
      {
        'title': 'About Us',
        'icon': Icons.info_outline,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutUsScreen()),
          );
        },
      },
      {
        'title': 'Contact Us',
        'icon': Icons.phone_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContactUsPage(),
            ),
          );
        },
      },
      {
        'title': 'Wallet',
        'icon': Icons.wallet,
        'onTap': () {},
      },

      {
        'title': 'My Network',
        'icon': Icons.network_check_rounded,
        'onTap': () {},
      },

      {
        'title': 'Shopping',
        'icon': Icons.shopping_bag_outlined,
        'onTap': () {},
      },



      {
        'title': 'Dark Theme',
        'icon': Icons.dark_mode,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WalletScreen(),
            ),
          );
        },
      },
      {
        'title': 'Refral Link',  //
        'icon': Icons.link,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReferralLinkScreen(),
            ),
          );
        },
      },
      {
        'title': 'Welcome Letter',  //
        'icon': Icons.palette_rounded,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeLetterScreen(),
            ),
          );
        },
      },


      {
        'title': 'App Info',
        'icon': Icons.info_outline,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppInfoPage(),
            ),
          );
        },
      },
      {
        'title': 'Change Password',
        'icon': Icons.description_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  ChangePasswordScreen(),
            ),
          );
        },
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,

        'onTap': () {
          _logout(context);
        },
      },

    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: menuItems.map((item) {
          if (item['title'] == 'Wallet') {
            return Column(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Icon(item['icon'] as IconData, color: AppColors.primaryPurple),
                    title: Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.only(left: 16),
                    children: [
                      _walletItem("Main Wallet", Icons.account_balance_wallet),
                      _walletItem("Level Income", Icons.trending_up),
                      _walletItem("Pool Income", Icons.pool),
                      _walletItem("Shopping Level Income", Icons.shopping_cart),
                      const Divider(indent: 56, endIndent: 16),
                      _walletItem("Withdraw Request", Icons.money),
                      _walletItem("Add Fund", Icons.add_circle),
                      const Divider(indent: 56, endIndent: 16),
                      _walletItem("Level Deduction Wallet", Icons.remove_circle),
                      _walletItem("Pool Deduction Wallet", Icons.remove_circle_outline),
                      const Divider(indent: 56, endIndent: 16),
                      _walletItem("Transaction History", Icons.history),
                      _walletItem("Wallet History", Icons.receipt_long),
                      const Divider(indent: 56, endIndent: 16),
                      _walletItem("Reward Income", Icons.card_giftcard),
                      _walletItem("Add Fund History", Icons.add_chart),
                      _walletItem("Direct Fund History", Icons.call_split),
                      _walletItem("W to W Fund", Icons.swap_horiz),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade200,
                  indent: 56,
                ),
              ],
            );
          }
          if (item['title'] == 'My Network') {
            return Column(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Icon(item['icon'] as IconData, color: AppColors.primaryPurple),
                    title: Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.only(left: 16),
                    children: [
                      _networkItem("Level Team List"),
                      _networkItem("Direct Team"),
                      _networkItem("Pool 1 Members"),
                      _networkItem("Pool 2 Members"),
                      _networkItem("Pool 3 Members"),
                      _networkItem("Pool 4 Members"),
                      _networkItem("Pool 5 Members"),
                      _networkItem("Pool 6 Members"),
                      _networkItem("Pool 7 Members"),
                      _networkItem("Pool 8 Members"),
                      _networkItem("Pool 9 Members"),
                      _networkItem("Refral Link"),
                      _networkItem("View Tree"),

                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade200,
                  indent: 56,
                ),
              ],
            );
          }

          if (item['title'] == 'Shopping') {

            return Column(

              children: [

                Theme(

                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),

                  child: ExpansionTile(

                    leading: Icon(

                      item['icon'] as IconData,

                      color: AppColors.primaryPurple,
                    ),

                    title: Text(

                      item['title'] as String,

                      style: const TextStyle(

                        fontSize: 16,

                        fontWeight: FontWeight.w500,

                        color: Colors.black,
                      ),
                    ),

                    childrenPadding:
                    const EdgeInsets.only(left: 16),

                    children: [

                      _shoppingItem(
                        "View Auto Pool",
                        Icons.remove_red_eye,
                      ),

                      _shoppingItem(
                        "Pool Activation List",
                        Icons.list_alt,
                      ),

                      _shoppingItem(
                        "Direct User Activation",
                        Icons.person_add_alt,
                      ),

                      _shoppingItem(
                        "Direct User Activation History",
                        Icons.history,
                      ),

                      _shoppingItem(
                        "Shop Now",
                        Icons.shopping_cart,
                      ),

                      _shoppingItem(
                        "Order History",
                        Icons.receipt_long,
                      ),

                      _shoppingItem(
                        "Buy Investment Voucher",
                        Icons.card_giftcard,
                      ),
                    ],
                  ),
                ),

                Divider(

                  height: 1,

                  thickness: 1,

                  color: Colors.grey.shade200,

                  indent: 56,
                ),
              ],
            );
          }
          return _buildMenuItem(
            item['title'] as String,
            item['icon'] as IconData,
            item['onTap'] as VoidCallback,
            item != menuItems.last,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap, bool showDivider) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.primaryPurple),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
          onTap: onTap,
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade200,
            indent: 56,
          ),
      ],
    );
  }


  Widget _walletItem(String title, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.purple.withOpacity(0.1),
        child: Icon(icon, color: Colors.purple),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {

        /// 🔥 Navigation Logic (Customize here)
        switch (title) {

          case "Main Wallet":
            Get.to(() => WalletScreen());
            break;

          case "Level Income":
            Get.to(() => LevelIncomeScreen());
            break;

          case "Pool Income":
            Get.to(() => PoolIncomeScreen());
            break;

          case "Shopping Level Income":
            Get.to(() => ShoppingLevelIncomeScreen());
            break;

          case "Withdraw Request":
            Get.to(() => WithdrawAmountScreen());

            break;

          case "Add Fund":
            Get.to(() => LevelTeamListScreen());
            break;

          case "Level Deduction Wallet":
            Get.to(() => LevelDeductionWalletScreen());
            break;

          case "Pool Deduction Wallet":
            Get.to(() =>  PoolDeductionWalletScreen());
            break;

          case "Transaction History":
            Get.to(() => TransactionHistoryScreen ());
            break;

          case "Wallet History":


            break;

          case "Reward Income":
            Get.to(() => RewardIncomeScreen());
            break;

          case "Add Fund History":
            break;

          case "Direct Fund History":
            break;

          case "W to W Fund":
            break;
        }
      },
    );
  }

  Widget _networkItem(String title) {
    return ListTile(
      leading: const Icon(Icons.arrow_forward, color: AppColors.primaryGold, size: 20),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
        onTap: () {
          switch (title) {
            case "Level Team List":
              Get.to(() => const LevelTeamListScreen());

              break;

            case "Direct Team":
            // Get.to(() => const DirectTeamScreen());

              break;

            case "Pool 1 Members":
            // Get.to(() => const Pool1MemberScreen());
              Get.to(() => const AutoPoolMemberScreen(poolType: 'Welcome%20Pool',));

              break;

            case "Pool 2 Members":
            // Get.to(() => const Pool2MemberScreen());
              Get.to(() => const AutoPoolMemberScreen(poolType: 'Public%20Pool',));

              break;

            case "Pool 3 Members":
              Get.to(() => const AutoPoolMemberScreen(poolType: 'Silver%20Pool',));
              break;

            case "Pool 4 Members":
              Get.to(() => const AutoPoolMemberScreen(poolType: 'Gold%20Pool',));
              break;

            case "Pool 5 Members":
              Get.to(() => const AutoPoolMemberScreen(poolType: 'Diamond%20Pool',));
              break;

            case "Pool 6 Members":
              Get.to(() => const AutoPoolMemberScreen(poolType: 'Royal%20Pool',));
              break;

            case "Pool 7 Members":
              Get.to(() => const AutoPoolMemberScreen(poolType: 'King%20Pool',));
              break;

            case "Pool 8 Members":
              Get.to(() => const AutoPoolMemberScreen(poolType: 'Power%20Pool',));
              break;

            case "Pool 9 Members":
              Get.to(() => const AutoPoolMemberScreen(poolType: 'Immortal%20Pool',));
              break;

            case "Refral Link":
            // Get.to(() => const ReferralLinkScreen());
              Get.to(() => const ReferralLinkScreen());

              break;

            case "View Tree":
              Get.to(() => const UserTreeScreen());
              break;
          }
        },
    );
  }
  Widget _shoppingItem(
      String title,
      IconData icon,
      ) {

    return ListTile(

      leading: CircleAvatar(

        //backgroundColor: Colors.purple.withOpacity(0.1),
        //         child: Icon(icon, color: Colors.purple),

        backgroundColor:
        Colors.purple.withOpacity(0.1),

        child: Icon(icon, color: Colors.purple),
      ),

      title: Text(

        title,

        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),

      onTap: () {

        switch (title) {

          case "View Auto Pool":

            Get.to(() =>
            const AutoPoolMemberScreen(
              poolType: 'Public%20Pool',
            ));

            break;

          case "Pool Activation List":
            Get.to(() =>  UserPoolActivationListScreen());

            break;

          case "Direct User Activation":

            break;

          case "Direct User Activation History":

            break;

          case "Shop Now":

            Get.to(() => const CartPage());

            break;

          case "Order History":

            Get.to(() => const OrderPage());

            break;

          case "Buy Investment Voucher":

            break;
        }
      },
    );
  }

}
