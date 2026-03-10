import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import 'ProductDetailsPage.dart';
import '../Services/cart_service.dart';

class ShoeSection extends StatefulWidget {
  const ShoeSection({super.key});

  @override
  State<ShoeSection> createState() => _ShoeSectionState();
}

class _ShoeSectionState extends State<ShoeSection> {
  String _selectedSort = 'Popularity';
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Nike Air Max',
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&q=80',
      'originalPrice': 129.99,
      'discountPrice': 89.99,
      'rating': 4.5,
      'reviews': 234,
      'brand': 'Nike',
    },
    {
      'name': 'Adidas Ultraboost',
      'image': 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=400&q=80',
      'originalPrice': 149.99,
      'discountPrice': 119.99,
      'rating': 4.7,
      'reviews': 189,
      'brand': 'Adidas',
    },
    {
      'name': 'Puma Running Shoes',
      'image': 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400&q=80',
      'originalPrice': 99.99,
      'discountPrice': 69.99,
      'rating': 4.3,
      'reviews': 156,
      'brand': 'Puma',
    },
    {
      'name': 'Reebok Classic',
      'image': 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=400&q=80',
      'originalPrice': 89.99,
      'discountPrice': 59.99,
      'rating': 4.4,
      'reviews': 98,
      'brand': 'Reebok',
    },
    {
      'name': 'Vans Old Skool',
      'image': 'https://images.unsplash.com/photo-1605348532760-6753d2aeb645?w=400&q=80',
      'originalPrice': 79.99,
      'discountPrice': 54.99,
      'rating': 4.6,
      'reviews': 312,
      'brand': 'Vans',
    },
    {
      'name': 'Converse Chuck Taylor',
      'image': 'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=400&q=80',
      'originalPrice': 69.99,
      'discountPrice': 49.99,
      'rating': 4.5,
      'reviews': 445,
      'brand': 'Converse',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildBanner()),
          SliverToBoxAdapter(child: _buildFilterBar()),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildProductCard(_products[index]),
                childCount: _products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.backgroundBlack,
      foregroundColor: AppColors.textWhite,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Shoes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          color: AppColors.backgroundBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search shoes...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 180,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.goldGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGold.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 150,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'UP TO 50% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Premium Footwear',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Best Quality Shoes',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterChip('All', _selectedFilter == 'All', () {
              setState(() => _selectedFilter = 'All');
            }),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterChip('Men', _selectedFilter == 'Men', () {
              setState(() => _selectedFilter = 'Men');
            }),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterChip('Women', _selectedFilter == 'Women', () {
              setState(() => _selectedFilter = 'Women');
            }),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterChip('Kids', _selectedFilter == 'Kids', () {
              setState(() => _selectedFilter = 'Kids');
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentGold : AppColors.backgroundLightGray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.textBlack : AppColors.textDarkGray,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

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
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: product['image'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                  // Discount Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.errorRed,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${((product['originalPrice'] - product['discountPrice']) / product['originalPrice'] * 100).toStringAsFixed(0)}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Text(
                      product['brand'],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Product Name
                    Text(
                      product['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Rating
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              size: 10,
                              color: index < (product['rating'] as double).floor()
                                  ? Colors.amber
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating']} (${product['reviews']})',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Price
                    Row(
                      children: [
                        Text(
                          '₹${product['originalPrice']}',
                          style: TextStyle(
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '₹${product['discountPrice']}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentGold,
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
}
