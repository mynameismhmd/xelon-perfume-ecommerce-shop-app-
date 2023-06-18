import 'package:auth1/payment%20succes%20ar.dart';
import 'package:auth1/payment%20succes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

import 'calling.dart';

class CheckoutPagear extends StatefulWidget {
  final double totalAmount;
  final List<String> perfumeNames; // Add the perfumeNames parameter

  CheckoutPagear({required this.totalAmount, required this.perfumeNames});

  @override
  _CheckoutPagearState createState() => _CheckoutPagearState();
}

class _CheckoutPagearState extends State<CheckoutPagear> {
  String? selectedPaymentMethod;
  List<String> paymentMethods = ['Visa', 'Mastercard', 'Cash on Delivery'];
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Image.asset(
            'assets/background1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'اختر طريقة الدفع',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'nz'
                  ),
                ),
                DropdownButton<String>(
                  value: selectedPaymentMethod,
                  dropdownColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                  items: paymentMethods.map((method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Text(
                        method,
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: processPayment,
                  child: Text('تكملة الشراء'),

                  style:  ElevatedButton.styleFrom(
textStyle: TextStyle(fontFamily: 'nz'),
                    backgroundColor: Colors.transparent, // Replace with your desired color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void processPayment() async {
    if (selectedPaymentMethod == 'Visa') {
      var request = BraintreeDropInRequest(
        tokenizationKey: 'sandbox_fw5zvpcx_mvcf9mtqgcs4txqp',
        collectDeviceData: true,
      );
      BraintreeDropInResult? result = await BraintreeDropIn.start(request);

      if (result != null) {
        if (result.paymentMethodNonce != null) {
          // Process the Visa payment
          String nonce = result.paymentMethodNonce!.nonce;
          String cardholderName = extractCardholderName(result.paymentMethodNonce!.description);

          // Perform further processing with the payment nonce and cardholder name
          // ...


          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSuccessPagear(totalPrice: widget.totalAmount,perfumeNames: widget.perfumeNames,),
            ),
          ); } else {
          // User canceled the payment
        }
      } else {
        // Error occurred during payment
      }
    } else if (selectedPaymentMethod == 'Mastercard') {
      // Handle Mastercard payment logic
      var request = BraintreeDropInRequest(
        tokenizationKey: 'sandbox_fw5zvpcx_mvcf9mtqgcs4txqp',
        collectDeviceData: true,
      );
      BraintreeDropInResult? result = await BraintreeDropIn.start(request);

      if (result != null) {
        if (result.paymentMethodNonce != null) {
          // Process the Visa payment
          String nonce = result.paymentMethodNonce!.nonce;
          String cardholderName = extractCardholderName(result.paymentMethodNonce!.description);

          // Perform further processing with the payment nonce and cardholder name
          // ...


          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSuccessPagear(totalPrice: widget.totalAmount,perfumeNames: widget.perfumeNames,),
            ),
          );} else {
          // User canceled the payment
        }
      } else {
        // Error occurred during payment
      }
    } else if (selectedPaymentMethod == 'Cash on Delivery') {
      // Handle Cash on Delivery logic


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessPagear(
            totalPrice: widget.totalAmount,
            perfumeNames: widget.perfumeNames, // Pass the perfumeNames list
          ),
        ),
      );
    } else {
      // No payment method selected
    }
  }

  String extractCardholderName(String description) {
    // Extract the cardholder name from the description
    // You may need to parse the description string to extract the desired information
    // Here's an example assuming the description format is "Cardholder Name: John Doe"
    RegExp regExp = RegExp(r'Cardholder Name: (.+)');
    Match? match = regExp.firstMatch(description);
    return match != null ? match.group(1) ?? '' : '';
  }
}