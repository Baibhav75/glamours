import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive/hive.dart';
import '../Model/product_details_model.dart';
import '../View/cart_page.dart';
import '../View/OrderSummaryScreen.dart';
import '../Services/cart_service.dart';
import '../theme/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/auth_service.dart';
import '../widgetsection/ProductDetailsPageVideo.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String _selectedTab = 'Description';
  int _selectedThumbnailIndex = 0;
  late List<String> _thumbnails;
  final AuthService _service = AuthService();

  ProductDetailsResponse? productDetails;

  bool isLoading = true;

  String selfId = "";

  @override
  void initState() {
    super.initState();
    loadProductDetails();
    // Defaulting to placeholder if product image is not real URL or empty
    String mainImage =
        widget.product['image']?.toString() ??
        'https://via.placeholder.com/300';

    _thumbnails = [mainImage];

    // Add extra mock images if needed, or real ones if they exist
    _thumbnails.addAll([mainImage, mainImage]);

    // Check for video URL
    String? videoUrl = widget.product['videoUrl'];
    if (videoUrl != null && videoUrl.isNotEmpty) {
      // Add video thumbnail placeholder (or use a play icon indicator)
      _thumbnails.add(
        videoUrl,
      ); // We'll detect this is a video by checking index or URL
    }
  }

  Future<void> loadProductDetails() async {
    try {
      final box = Hive.box('authBox');

      selfId = box.get('selfId') ?? "";

      String? prodId = widget.product['productId']?.toString();
      if (prodId == null || prodId.isEmpty) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final response = await _service.getProductDetails(selfId, prodId);

      setState(() {
        productDetails = response;

        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isUrlVideo(String url) {
    return url.toLowerCase().contains('.mp4') ||
        url.toLowerCase().contains('.mov') ||
        url == widget.product['videoUrl'];
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.accentGold),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageHeader(),
              const SizedBox(height: 16),
              _buildProductHeaderInfo(),
              _buildTabs(),
              _buildTabContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader() {
    return Container(
      color: const Color(
        0xFFFDE8F1,
      ).withOpacity(0.5), // Light pinkish background for image area
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              // Main Product Image or Video
              Center(
                child: SizedBox(
                  height: 250,
                  child: _isUrlVideo(_thumbnails[_selectedThumbnailIndex])
                      ? ProductDetailsPageVideo(
                          videoUrl: widget.product['videoUrl'],
                        )
                      : CachedNetworkImage(
                          imageUrl: _thumbnails[_selectedThumbnailIndex],
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              // Thumbnails
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_thumbnails.length, (index) {
                  bool isVideo = _isUrlVideo(_thumbnails[index]);
                  return GestureDetector(
                    onTap: () {
                      final pd = productDetails?.productDetails;

                      SharePlus.instance.share(
                        ShareParams(
                          text:
                              '''
${pd?.productName ?? ''}

Price: ₹${pd?.sellingPrice ?? ''}

Category: ${productDetails?.categoryName ?? ''}

https://glamorousfilmcity.com
''',
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedThumbnailIndex == index
                              ? AppColors.accentGold
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: isVideo
                            ? Container(
                                color: Colors.black,
                                child: const Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: _thumbnails[index],
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error, size: 20),
                              ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
            ],
          ),
          // Top Bar Overlay
          Positioned(
            top: 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: AppColors.accentGold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.share,
                      size: 18,
                      color: AppColors.accentGold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductHeaderInfo() {
    final pd = productDetails?.productDetails;
    // Determine the prices to display from the map or dynamic
    String originalPrice =
        pd?.mrp ?? widget.product['originalPrice']?.toString() ?? '9.99';
    String discountPrice =
        pd?.sellingPrice ??
        widget.product['discountPrice']?.toString() ??
        '6.99';
    String productName =
        pd?.productName ?? widget.product['name'] ?? 'Indian Suits & Blazers';
    String categoryName = productDetails?.categoryName ?? "TALENT PROMO";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryName.toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "6 Reviews",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "₹$originalPrice",
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "₹$discountPrice",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              "Availability : Limited Slots Available",
              style: TextStyle(
                color: AppColors.successGreen,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    List<String> tabs = ['Description'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs.map((tab) {
          bool isSelected = _selectedTab == tab;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = tab;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accentGold : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    return _buildDescriptionTab();
  }

  Widget _buildDescriptionTab() {

    String description =
        productDetails?.productDetails.description ?? "";

    // Remove HTML tags
    description = description
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .trim();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        description,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return AnimatedBuilder(
      animation: cartService,
      builder: (context, child) {
        int cartCount = cartService.badgeCount;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, -2),
                blurRadius: 10,
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                /// CART ICON
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(product: widget.product),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundBlack,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),

                        /// CART BADGE
                        if (cartCount > 0)
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.accentGold,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$cartCount',
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
                ),

                const SizedBox(width: 16),

                /// ADD TO CART BUTTON
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.accentGold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      cartService.addToCart(
                        widget.product,
                        "",
                        Colors.transparent,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Package added to shortlist"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text(
                      "Shortlist",
                      style: TextStyle(
                        color: AppColors.accentGold,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// BUY NOW BUTTON
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentGold,
                      foregroundColor: AppColors.textBlack,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderSummaryScreen(
                            product: widget.product,
                            selectedSize: "",
                            selectedColor: Colors.transparent,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
