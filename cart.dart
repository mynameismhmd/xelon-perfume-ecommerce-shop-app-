import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'cartmodel.dart';

class CartePage extends StatefulWidget {
  final String animationUrl =
      'https://assets6.lottiefiles.com/packages/lf20_lku7txrj.json';

  final CartModel cartModel;

  const CartePage({super.key, required this.cartModel});

  @override
  _CartePageState createState() => _CartePageState();
}

class _CartePageState extends State<CartePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.network(
                widget.animationUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            if (widget.cartModel.cartItems.isNotEmpty)
              Column(
                children: widget.cartModel.cartItems.map((perfumeName) {
                  final imagePath = widget.cartModel.itemImages[perfumeName];
                  return Column(
                    children: [
                      Row(
                        children: [

                          const SizedBox(width: 10),
                          if (imagePath != null)
                            Image.asset(
                              imagePath,
                              width: 100,
                              height: 100,
                            ),
                          Text(
                            'Perfume Name: $perfumeName',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ),

            if (widget.cartModel.cartItems.isEmpty)
              const Text(
                'This cart is empty',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
