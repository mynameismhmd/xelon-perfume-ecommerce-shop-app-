import 'package:auth1/auth.dart';
import 'package:auth1/dialog.dart';
import 'package:auth1/profile.dart';
import 'package:auth1/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  _Example2State createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static  final List<Widget> _widgetOptions = <Widget>[ const SignUpPage(),
  const AnimatedDialog(title: '', message: '', imagePath: '',),const LoginPagte(),const SignUpPage(),     const gProfilePage(),
    const Text(
      'Home',

      style: optionStyle,

    ),

    const Text(
      style:optionStyle,
      'cart'
    ),
    const Text(
      'Likes',
      style: optionStyle,
    ),
    const Text(
      'Search',
      style: optionStyle,
    ),

    const Text(
      'Profile',
      style: optionStyle,
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.white.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: GNav(
              rippleColor: Colors.grey[100]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.white,
              tabs: const [
                GButton(

                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.addToShoppingCart,
                  text: 'cart',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}