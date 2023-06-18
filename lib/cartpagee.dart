import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'summery.dart';
import 'checkout.dart';
import 'controller.dart';
import 'main.dart';

class CartPagee extends GetView<CartController> {
  CartPagee({Key? key}) : super(key: key);

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in controller.cartItems) {
      double price = double.tryParse(item['price']) ?? 0.0;
      int quantity = item['quantity'] ?? 0;
      totalPrice += price * quantity;
    }
    return totalPrice;
  }

  double _calculateDeliveryFee() {
    // Add your logic to calculate the delivery fee
    return 10.0;
  }

  double _calculateCouponDiscount() {
    // Add your logic to calculate the coupon discount
    return 5.0;
  }

  Widget _getImagePath(Object imageObject) {
    if (imageObject is Widget) {
      return imageObject;
    }
    return Container(); // Return an empty container if imagePath is not a valid widget
  }

  List<String> _getPerfumeNames() {
    List<String> perfumeNames = [];
    for (var item in controller.cartItems) {
      String perfumeName = item['name'];
      perfumeNames.add(perfumeName);
    }
    return perfumeNames;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            if (controller.cartItems.isEmpty) {
              return Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Lottie.asset(
                          'assets/lottie.json',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(
                        'This cart is empty',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Positioned(
                top: 100,
                left: 140,
                child: Container(
                  child: Lottie.asset(
                    'assets/lottie.json',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              );
            }
          }),
          Positioned(
            top: 200,
            bottom: 60,
            left: 0,
            right: 0,
            child: GetBuilder<CartController>(
              builder: (controller) {
                return ListView.separated(
                  itemCount: controller.cartItems.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final perfumeItem = controller.cartItems[index];
                    final perfumeName = perfumeItem['name'];
                    final price = perfumeItem['price'];
                    final imageObject = perfumeItem['imagePath'];
                    final imagePath = _getImagePath(imageObject);
                    final quantity = perfumeItem['quantity'];
                    return ListTile(
                      title: Text(
                        perfumeName,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'Price: $price',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      leading: SizedBox(
                        width: 120,
                        height: 120,
                        child: imagePath,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            onPressed: () {
                              controller.removeItem(perfumeName, imagePath, price);
                            },
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            onPressed: () {
                              controller.addQuantity(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(8),
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<CartController>(
                    builder: (controller) {
                      final totalPrice = _calculateTotalPrice();
                      final deliveryFee = _calculateDeliveryFee();
                      final couponDiscount = _calculateCouponDiscount();

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                'Order Total: \$${totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      double totalAmount = _calculateTotalPrice();
                      List<String> perfumeNames = _getPerfumeNames();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Summery(
                            perfumeNames: perfumeNames,
                            priceList: controller.cartItems.map<double>((item) {
                              return double.tryParse(item['price']) ?? 0.0;
                            }).toList(),
                            perfumeImagePaths: controller.cartItems.map<Image>((item) {
                              return item['imagePath'] ?? '';
                            }).toList(),
                            totalPrice: totalAmount,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
