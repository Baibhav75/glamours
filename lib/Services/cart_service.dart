import 'package:flutter/material.dart';

class CartItem {
  final Map<dynamic, dynamic> product;
  int qty;
  final String selectedSize;
  final Color selectedColor;

  CartItem({
    required this.product,
    this.qty = 1,
    required this.selectedSize,
    required this.selectedColor,
  });
}

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  List<CartItem> items = [];

  void addToCart(Map<dynamic, dynamic> product, String size, Color color) {
    var existingItemIndex = items.indexWhere((item) => 
      item.product['name'] == product['name'] && 
      item.selectedSize == size &&
      item.selectedColor.value == color.value
    );

    if (existingItemIndex >= 0) {
      items[existingItemIndex].qty += 1;
    } else {
      items.add(CartItem(product: product, selectedSize: size, selectedColor: color));
    }
    notifyListeners();
  }

  void remove(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void increaseQty(int index) {
    items[index].qty++;
    notifyListeners();
  }

  void decreaseQty(int index) {
    if (items[index].qty > 1) {
      items[index].qty--;
      notifyListeners();
    }
  }

  double get total {
    double sum = 0;
    for (var item in items) {
      double price = double.tryParse(item.product['discountPrice']?.toString() ?? '0') ?? 0;
      if (price == 0) {
        price = double.tryParse(item.product['price']?.toString() ?? '0') ?? 0;
      }
      sum += price * item.qty;
    }
    return sum;
  }

  int get badgeCount {
    return items.fold(0, (sum, item) => sum + item.qty);
  }
}

final cartService = CartService();
