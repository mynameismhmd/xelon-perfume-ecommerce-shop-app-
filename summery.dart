import 'package:auth1/checkout.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:auth1/theme.dart';



import 'controller.dart';

class Summery extends StatelessWidget {

  Summery({Key? key,
    required this.perfumeNames,
    required this.priceList,
    required this.perfumeImagePaths,
    required this.totalPrice,
  })

      : super(key: key);

  final cartController = Get.put(CartController(), permanent: true);

  @override
  final List<String> perfumeNames;
  final double totalPrice;
  final List<double> priceList;
  final List<Image> perfumeImagePaths;
  @override
  Widget build(BuildContext context) {


    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          // List Items
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Items List',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),

              ],
            ),
          ),
          //Address Detailt
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: background4Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perfumes',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Column(
                      children: [

                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),

      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(perfumeNames.length, (index) {
      final imagePath = perfumeImagePaths[index];
      final perfumeName = perfumeNames[index];
      final price = priceList[index];

      return Padding(
      padding: EdgeInsets.only(bottom: defaultMargin),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      SizedBox(
      width: 60,
      height: 60,
      child: imagePath, // Display the imagePath as an Image widget
      ),

      SizedBox(height: 10,width: 10),
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),

      Text(
      perfumeName,
      style: primaryTextStyle.copyWith(fontWeight: medium ,fontSize: 16),


      ),
      Text(
      '${price}\$',
      style: secondaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
      ),
      ],
      ),

                      ],
                    ),
      );})) ],
                ),
              ],
            ),
          ),
          // Payment Summary
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: background4Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Summary',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Quantity',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                    GetBuilder<CartController>(
                      builder: (controller) {
                        final totalQuantity = controller.calculateTotalQuantity();
                        return Text(
                          '$totalQuantity Items',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'perfumes total  Price',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      '${totalPrice}\$',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      'Free',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),

                  ],
                ),

                const SizedBox(
                  height: 12,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xff2E3141),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                        '${totalPrice}\$',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Button Checkout
          SizedBox(
            height: defaultMargin,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xff2E3141),
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: defaultMargin),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CheckoutPage(totalAmount: totalPrice, perfumeNames: perfumeNames,


                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Checkout Now',
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: background3Color,

      body: content(),
    );
  }
}