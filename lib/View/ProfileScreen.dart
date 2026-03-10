import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:glamorous/profile/ContactUsPage.dart';
import '../profile/AppInfoPage.dart';
import '../theme/app_colors.dart';
import 'EditProfileScreen.dart';
import 'AboutUsScreen.dart';
import 'HomeScreen.dart';
import 'OffersPage.dart';
import 'cart_page.dart';
import 'order_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
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
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundBlack,
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
          const Text(
            'Shivam Duba',
            style: TextStyle(
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
                child: CachedNetworkImage(
                  imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&q=80',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildQuickAccessIcons(BuildContext context) {
    final quickAccessItems = [
      {'name': 'Order', 'icon': Icons.shopping_bag_outlined},
      {'name': 'Cart', 'icon': Icons.shopping_cart_outlined},
      {'name': 'Offers', 'icon': Icons.card_giftcard_outlined},
      {'name': 'Wishlist', 'icon': Icons.favorite_outline},
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16),
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
              color: AppColors.backgroundDarkGray,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryGold.withOpacity(0.3)),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryGold,
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
        'onTap': () {},
      },
      {
        'title': 'All Categories',
        'icon': Icons.grid_view_outlined,
        'onTap': () {},
      },
      {
        'title': 'Terms And Conditions',
        'icon': Icons.description_outlined,
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
        'title': 'Privacy Policy',
        'icon': Icons.lock_outline,
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
        'title': 'FAQ',
        'icon': Icons.help_outline,
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
          leading: Icon(icon, color: AppColors.primaryGold),
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

}
