import 'package:flutter/material.dart';
import 'calling.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class PaymentSuccessPage extends StatelessWidget {
  final double totalPrice;
  final List<String> perfumeNames; // List of perfume names
  final String orderNumber; // Added order number parameter
  final Function(String) onPaymentStatusUpdated;

  PaymentSuccessPage({
    required this.totalPrice,
    required this.perfumeNames,
    required this.orderNumber,
    required this.onPaymentStatusUpdated,
  });



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Retrieve the theme provider
    final isDarkMode = themeProvider.isDarkMode;

    Color getTextColor() {
      return isDarkMode ? Colors.white : Colors.black;
    }

    Color getBackgroundColor() {
      return isDarkMode ? Colors.black : Color(0xFFFEFEFE);
    }


    return Scaffold(
      appBar: null,
      backgroundColor: getBackgroundColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/lieb.gif'),
            SizedBox(height: 20),
            Text(
              'Payment Successful',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: getTextColor()),
            ),
            SizedBox(height: 20),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: getTextColor()),
            ),
            SizedBox(height: 20),
            Text(
              'Perfumes: ${perfumeNames.join(", ")}', // Displaying perfume names
              style: TextStyle(fontSize: 18, color: getTextColor()),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: Offset(0, 4), // vertical offset
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  onPaymentStatusUpdated('success'); // Assuming the payment was successful
                  final orderStatusProvider = Provider.of<OrderStatusProvider>(context, listen: false);
                  orderStatusProvider.updatePaymentStatus(orderNumber, true); // Update the payment status
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallingPage(onCallMade: (bool) {}),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.white,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
