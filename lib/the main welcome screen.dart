import 'package:auth1/welcome.dart';
import 'package:auth1/welcomear.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class thePerfumeWelcomeScreen extends StatefulWidget {
  @override
  _thePerfumeWelcomeScreenState createState() => _thePerfumeWelcomeScreenState();
}

class _thePerfumeWelcomeScreenState extends State<thePerfumeWelcomeScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<Perfume> perfumes = [
    Perfume(
      image: 'assets/perfume1.jpg',
      description: 'Discover a world of exquisite scents.',
    ),
    Perfume(
      image: 'assets/dbbb.gif',
      description: 'Get fast and reliable delivery to your doorstep.',
    ),
    Perfume(
      image: 'assets/favorite.jpg',
      description: 'Save your favorite perfumes for easy access.',
    ),
    Perfume(
      image: 'assets/green.jpg',
      description: 'Shop the latest trends in perfume fashion.',
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
                      builder: (context) => WelcomeScreen(),
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
                'Skip',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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
            style: GoogleFonts.sourceCodePro(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            textAlign: TextAlign.center,
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

