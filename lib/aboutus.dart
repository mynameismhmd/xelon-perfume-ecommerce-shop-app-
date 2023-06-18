import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final String appVersion = '1.0.0'; // Replace with your app version
  final String email = 'gshinopy@gmail.com';
  final String phoneNumber = '07509012913';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Xelon Perfume Shop!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Discover the Essence of Elegance',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'At Xelon Perfume Shop, we believe that fragrance is an essential part of personal style and expression. Our mission is to provide our customers with the finest collection of perfumes from around the world, delivering a delightful olfactory experience.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Quality and Authenticity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'We take pride in offering only the highest quality perfumes, sourced directly from renowned perfume houses. Each fragrance in our collection is carefully selected to ensure authenticity and excellence, so you can indulge in luxury with confidence.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Exceptional Customer Service',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Our customers are at the heart of everything we do. Our dedicated team is committed to providing exceptional service and helping you find the perfect scent that complements your personality and style. We strive to create a personalized and memorable shopping experience for each and every customer.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                'Contact Us:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8.0),
              Text(
                'Phone: $phoneNumber',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 32.0),
              Text(
                'App Version: $appVersion',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
