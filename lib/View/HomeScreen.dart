import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../ViewSection/ProductDetailsPage.dart';
import '../ViewSection/ShoeSection.dart';
import '../ViewSection/SweatersSection.dart';
import '../ViewSection/ElectronicsSection.dart';
import '../ViewSection/FoodSection.dart';
import '../ViewSection/category_screen.dart';
import '../widgetsection/best_seller_section.dart';
import '../widgetsection/new_arrivals_section.dart';
import '../widgetsection/promotional_banner.dart';
import '../widgetsection/top_selling_section.dart';
import '../widgetsection/weekly_best_sell_section.dart';
import '../Services/cart_service.dart';
import '../theme/app_colors.dart';
import 'cart_page.dart';
import 'ProfileScreen.dart';
import 'order_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;
  @override
  void initState() {
    super.initState();

    _screens = [
      _buildHomeContent(), // Home UI
      const OrderPage(),// Order screen
      const ProfileScreen(), // Profile screen
    ];
  }
  final PageController _bannerController = PageController();
  int _currentBannerPage = 0;
  final TextEditingController _searchController = TextEditingController();



  // Categories data
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Baby', 'icon': Icons.child_care, 'color': Colors.yellow},
    {'name': 'Shoe', 'icon': Icons.shopping_bag, 'color': Colors.brown},
    {'name': 'Sweaters', 'icon': Icons.checkroom, 'color': Colors.brown},
    {'name': 'Electronics', 'icon': Icons.devices, 'color': Colors.blue},
    {'name': 'Food', 'icon': Icons.fastfood, 'color': Colors.orange},
  ];

  // Products data
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Rainbow Sequin Dress',
      'image': 'https://images.unsplash.com/photo-1594633313593-bab3825d0caf?w=400&q=80',
      'originalPrice': 9.99,
      'discountPrice': 6.99,
    },
    {
      'name': 'Rainbow Sequin Dress',
      'image': 'https://images.unsplash.com/photo-1594633313593-bab3825d0caf?w=400&q=80',
      'originalPrice': 9.99,
      'discountPrice': 6.99,
    },
    {
      'name': 'Rainbow Sequin Dress',
      'image': 'https://images.unsplash.com/photo-1594633313593-bab3825d0caf?w=400&q=80',
      'originalPrice': 9.99,
      'discountPrice': 6.99,
    },
    {
      'name': 'Rainbow Sequin Dress',
      'image': 'https://images.unsplash.com/photo-1594633313593-bab3825d0caf?w=400&q=80',
      'originalPrice': 9.99,
      'discountPrice': 6.99,
    },
  ];

  @override
  void dispose() {

    _bannerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildMarketCategorySection(),
          const SizedBox(height: 12), // 👈 add space here
          const PromotionalBanner(),
          _buildPopularCloothsSection(),
          const SizedBox(height: 20),
          const BestSellerSection(),
          const SizedBox(height: 20),
          const TopSellingSection(),
          const SizedBox(height: 20),

          const WeeklyBestSellSection(),

          const SizedBox(height: 20),

          const NewArrivalsSection(),


        ],
      ),
    );
  }


  // Market Category Section
  Widget _buildMarketCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Market Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(_categories[index]);
            },
          ),
        ),
      ],
    );
  }

  // Category Card
  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        _navigateToCategory(category['name'] as String);
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.backgroundBlack,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category['icon'] as IconData,
              color: category['color'] as Color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              category['name'] as String,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(String categoryName) {
    Widget? categoryPage;
    
    switch (categoryName) {
      case 'Shoe':
        categoryPage = const ShoeSection();
        break;
      case 'Sweaters':
        categoryPage = const SweatersSection();
        break;
      case 'Electronics':
        categoryPage = const ElectronicsSection();
        break;
      case 'Food':
        categoryPage = const FoodSection();
        break;
      default:
        return; // Do nothing for other categories
    }
    
    if (categoryPage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => categoryPage!),
      );
    }
  }


  // Popular Clooths Section
  Widget _buildPopularCloothsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Clooths',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height:1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(_products[index]);
            },
          ),
        ),
      ],
    );
  }

  // Product Card
  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Product Image
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: _buildNetworkImage(
                  product['image'],
                  Colors.grey.shade200,
                ),
              ),
            ),

            /// Product Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Stars
                    Row(
                      children: List.generate(
                        5,
                            (index) => const Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// Product Name
                    Text(
                      product['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Spacer(),

                    /// Price Row
                    Row(
                      children: [
                        Text(
                          "₹${product['originalPrice']}",
                          style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(width: 6),

                        Text(
                          "₹${product['discountPrice']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Network Image Widget (Reusable)
  Widget _buildNetworkImage(String imageUrl, Color placeholderColor) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: placeholderColor,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              placeholderColor == Colors.grey.shade200
                  ? Colors.grey
                  : Colors.white,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return Container(
          color: placeholderColor,
          child: Icon(
            Icons.image_not_supported,
            color: placeholderColor == Colors.grey.shade200
                ? Colors.grey
                : Colors.white,
            size: 40,
          ),
        );
      },
      httpHeaders: const {
        'User-Agent': 'Mozilla/5.0',
      },
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundBlack,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.accentGold,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Combined Header with Rounded Background and Search Bar
  Widget _buildHeader() {
    return Stack(
      children: [

        Container(
          height: 150,
          decoration: const BoxDecoration(
            color: AppColors.backgroundBlack,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 28),
              const SizedBox(width: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen (),
                ),
              );
            },
               child: const Text(
                'Glamorous',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
              const Spacer(),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
                child: _buildCartBadge(),
              ),
            ],
          ),
        ),

        // 2. Floating Search Bar
        Padding(
          padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textWhite,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                // The Filter Icon seen in your image
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accentGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.tune, color: AppColors.accentGold, size: 20),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Cart Badge Helper
  Widget _buildCartBadge() {
    return AnimatedBuilder(
      animation: cartService,
      builder: (context, child) {
        int cartCount = cartService.badgeCount;
        
        return Stack(
          children: [
            const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
            if (cartCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: AppColors.backgroundBlack, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text('$cartCount', style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
                ),
              ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
