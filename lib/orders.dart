import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'calling.dart';
import 'controller.dart';
import 'main.dart';

class OrdersPage extends GetView<CartController> {
  final bool callMade;

  const OrdersPage({Key? key, required this.callMade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final orderStatusProvider = Provider.of<OrderStatusProvider>(context);
    late BuildContext _pageContext;
    _pageContext = context;

    final orders = controller.ordersList;
    void updatePaymentStatus(String orderNumber, bool paymentStatus) {
      print('updatePaymentStatus called with orderNumber: $orderNumber, paymentStatus: $paymentStatus');
      final orderStatusProvider = Provider.of<OrderStatusProvider>(_pageContext, listen: false);
      orderStatusProvider.updatePaymentStatus(orderNumber, paymentStatus);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          final orders = controller.ordersList;

          if (orders.isEmpty) {
            return Center(
              child: Text(
                'No orders yet',
                style: GoogleFonts.roboto(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderNumber = order['orderNumber'];
              final orderDate = order['orderDate'];
              final orderTime = order['orderTime'];
              final items = order['items'];

              return Dismissible(
                key: Key(orderNumber),
                direction: DismissDirection.horizontal,
                onDismissed: (_) {
                  controller.removeOrder(index);
                },
                background: Container(
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 16.0),
                ),
                child: Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Number: $orderNumber',
                              style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                controller.removeOrder(index);
                              },
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Order Date: $orderDate',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Order Time: $orderTime',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Items:',
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, itemIndex) {
                            final item = items[itemIndex];
                            final itemName = item['name'];
                            final itemPrice = item['price'];
                            final itemImagePath = item['imagePath'];

                            return Dismissible(
                              key: Key(itemName),
                              direction: DismissDirection.horizontal,
                              onDismissed: (_) {
                                controller.removeItemFromOrder(index, itemIndex);
                              },
                              background: Container(
                                color: Colors.red,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 16.0),
                              ),
                              child: Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: itemImagePath,
                                  ),
                                  title: Text(itemName),
                                  subtitle: Text('Price: $itemPrice'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      controller.removeItemFromOrder(index, itemIndex);
                                    },
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: orderStatusProvider.getPaymentStatus(orderNumber)
                                ? Colors.green
                                : Colors.yellow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            orderStatusProvider.getPaymentStatus(orderNumber)
                                ? 'Success'
                                : 'Pending',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
