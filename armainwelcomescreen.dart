import 'package:auth1/welcomear.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class arPerfumeWelcomeScreen extends StatefulWidget {
  @override
  _arPerfumeWelcomeScreenState createState() => _arPerfumeWelcomeScreenState();
}

class _arPerfumeWelcomeScreenState extends State<arPerfumeWelcomeScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<Perfume> perfumes = [
    Perfume(
      image: 'assets/perfume1.jpg',
      description: 'اكتشف عالمًا من الروائح الرائعة',
    ),
    Perfume(
      image: 'assets/dbbb.gif',
      description: 'احصل على توصيل سريع وموثوق إلى عتبة داركم',
    ),
    Perfume(
      image: 'assets/favorite.jpg',
      description: 'احفظ العطور المفضلة لديك ليسهل الوصول إليها',
    ),
    Perfume(
      image: 'assets/green.jpg',
      description: 'تسوق أحدث صيحات الموضة في العطور',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to dark
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: perfumes.length,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return PerfumeItem(perfume: perfumes[index], currentPage: _currentPage);
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < perfumes.length; i++)
                  SlideDot(isActive: i == _currentPage),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                if (_currentPage == perfumes.length - 1) {
                  // Navigate to main page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => arWelcomeScreen(),
                    ),
                  );
                } else {
                  // Scroll to the next page
                  _pageController.animateToPage(
                    _currentPage + 1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: Text(
                'تخطي',
                style:  TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'nz',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}

class Perfume {
  final String image;
  final String description;

  Perfume({required this.image, required this.description});
}

class PerfumeItem extends StatelessWidget {
  final Perfume perfume;
  final int currentPage;

  PerfumeItem({required this.perfume, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            perfume.image,
            height: 300,
            width: 600,
          ),
          SizedBox(height: 20),
          Text(
            perfume.description,

              style: TextStyle(
                color: Colors.white,
                fontSize: 18,

                fontFamily: 'nz',
                fontWeight: FontWeight.w400,
              ),
            ),


        ],
      ),
    );
  }
}

class SlideDot extends StatelessWidget {
  final bool isActive;

  SlideDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white : Colors.grey,
      ),
    );
  }
}

