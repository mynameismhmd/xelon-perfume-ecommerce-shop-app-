import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller.dart';

class OrdersPagear extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'طلباتي',
          style: TextStyle(
            fontFamily: 'nz',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          final orders = controller.ordersList;

          if (orders.isEmpty) {
            return const Center(
              child: Text(
                'لا طلبات حتى الان',
                style: TextStyle(fontFamily: 'nz',fontSize: 18)
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
                              'رقم الطلب $orderNumber',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'nz'
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                controller.removeOrder(index);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'تاريخ الطلب $orderDate',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'nz'
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'وقت الطلب: $orderTime',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'nz'
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'العناصر',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'nz'
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
                                  subtitle: Text('السعر $itemPrice',style: const TextStyle(fontFamily: 'nz'),),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      controller.removeItemFromOrder(index, itemIndex);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
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
