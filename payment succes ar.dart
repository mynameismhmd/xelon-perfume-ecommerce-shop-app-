import 'package:flutter/material.dart';
import 'calling.dart';
import 'callingar.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class PaymentSuccessPagear extends StatelessWidget {
  final double totalPrice;
  final List<String> perfumeNames; // List of perfume names

  PaymentSuccessPagear({required this.totalPrice, required this.perfumeNames});

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
              'تم الدفع',
              style: TextStyle(fontSize: 24, fontFamily: 'nz', fontWeight: FontWeight.bold, color: getTextColor()),
            ),
            SizedBox(height: 20),
            Text(
              'القيمة الكلية: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontFamily: 'nz', color: getTextColor()),
            ),
            SizedBox(height: 20),
            Text(
              'العطور: ${perfumeNames.join(", ")}', // Displaying perfume names
              style: TextStyle(fontSize: 18, fontFamily: 'nz', color: getTextColor()),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => callingar(),
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
