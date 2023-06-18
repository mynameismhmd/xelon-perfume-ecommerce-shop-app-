import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  List<bool> orderPaymentStatusList = [];
  String url = 'https://assets6.lottiefiles.com/packages/lf20_lku7txrj.json';

  void addToCart(String perfumeName, Widget imagePath, String price) {
    final item = {
      'name': perfumeName,
      'imagePath': _getImagePath(imagePath),
      'price': price,
      'quantity': 1, // Add initial quantity of 1
    };
    cartItems.add(item);
    print('Item added to cart: $item');

    // Create the order and add it
    final order = {
      'orderNumber': '${DateTime.now().millisecondsSinceEpoch}',
      'items': List.from(cartItems.map((item) {
        return {
          'name': item['name'],
          'imagePath': item['imagePath'],
          'price': item['price'],
          'quantity': item['quantity'], // Include the quantity in the order
        };
      })),
    };
    addOrder(order);
  }

  Object _getImagePath(Widget imageWidget) {

    if (imageWidget is Image) {
      return Image.asset(
        'assets/pg.png',
      );
    } else if (imageWidget is Container) {
      return Image.asset(
        'assets/shelmar.png',
        width: 80,
        height: 90,
      );
    }
    else if (imageWidget is Column) {
      return Image.asset(
        'assets/pp.png',
        width: 80,
        height: 90,
      );
    }
    else if (imageWidget is Stack) {
      return Image.asset(
        'assets/jcctp.png',
        width: 80,
        height: 90,
      );
    }
    return ' i love you';
  }

  void removeItem(String perfumeName, Widget imagePath, String price) {
    final item = {
      'name': perfumeName,
      'imagePath': imagePath,
      'price': price,
    };

    // Find the item in the cart
    final index = cartItems.indexWhere((item) => item['name'] == perfumeName);
    if (index != -1) {
      final quantity = cartItems[index]['quantity'] ?? 0;

      // Remove the item if the quantity is 0
      if (quantity == 1) {
        cartItems.removeAt(index);
        print('Item removed from cart: $item');
      } else {
        // Reduce the quantity if it's greater than 0
        cartItems[index]['quantity'] = quantity - 1;
        print('Quantity reduced for item: $item');
      }

      update();
    }
  }



  List<Map<String, dynamic>> get ordersList => orders.toList();

  void addOrder(Map<String, dynamic> order) {
    final newOrder = {
      'orderNumber': '${DateTime.now().millisecondsSinceEpoch}',
      'orderDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'orderTime': DateFormat('HH:mm').format(DateTime.now()),
      'items': cartItems.map((item) {
        return {
          'name': item['name'],
          'imagePath': item['imagePath'],
          'price': item['price'],
          'quantity': item['quantity'], // Include the quantity in the order
        };
      }).toList(),
    };

    orders.add(newOrder);
    orderPaymentStatusList.add(false);
    print('Order added: $newOrder');
  }

  void removeOrder(int index) {
    if (index >= 0 && index < orders.length) {
      orders.removeAt(index);
      orderPaymentStatusList.removeAt(index); // Remove the payment status of the corresponding order
      update();
    }
  }

  void removeItemFromOrder(int orderIndex, int itemIndex) {
    if (orderIndex >= 0 && orderIndex < orders.length) {
      final order = orders[orderIndex];
      final items = order['items'];

      if (itemIndex >= 0 && itemIndex < items.length) {
        items.removeAt(itemIndex);
        update();
      }

      // Check if the order has no more items, and remove the payment status if needed
      if (items.isEmpty) {
        orderPaymentStatusList.removeAt(orderIndex);
      }
    }
  }

  void removeCartItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
    }
  }

  void clearCart() {
    cartItems.clear();
  }
  void addQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index]['quantity'] = (cartItems[index]['quantity'] ?? 0) + 1;
      update();
    }
  }
  int calculateTotalQuantity() {
    int totalQuantity = 0;
    for (var item in cartItems) {
      int quantity = item['quantity'] ?? 0;
      totalQuantity += quantity;
    }
    return totalQuantity;
  }

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      double price = double.tryParse(item['price']) ?? 0.0;
      int quantity = item['quantity'] ?? 0;
      totalPrice += price * quantity;
    }
    return totalPrice;
  }

  void reduceQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      int quantity = cartItems[index]['quantity'] ?? 0;
      if (quantity > 1) {
        cartItems[index]['quantity'] = quantity - 1;
      } else {
        cartItems[index]['quantity'] = 0;
      }
      update();
    }
  }

}
