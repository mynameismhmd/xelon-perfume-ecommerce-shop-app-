import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems;
  Map<String, String> itemImages;
  Map<String, String> itemPrices;
  Map<String, dynamic> kkItems;

  CartModel({
    required this.cartItems,
    required this.itemImages,
    required this.itemPrices,
    required this.kkItems,
  });

  void updateCartItems(List<Map<String, dynamic>> newCartItems) {
    cartItems = newCartItems;
    notifyListeners();
  }

  // Implement other methods to update itemImages, itemPrices, or kkItems if necessary

  // You can add additional methods to modify the cart items, such as addItem, removeItem, etc.
  // Make sure to call notifyListeners() after modifying the cart items.

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      double price = double.tryParse(item['price']) ?? 0.0;
      totalPrice += price;
    }
    return totalPrice;
  }
}
