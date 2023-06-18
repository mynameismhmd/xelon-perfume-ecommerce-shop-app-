
import 'dart:ui';

import 'package:auth1/settingsar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'arcartpagee.dart';
import 'cartmodel.dart';
import 'cartpagee.dart';
import 'favorits.dart';
import 'favoritsar.dart';
import 'glassar.dart';
import 'glassirium.dart';
import 'hidden drawer ar.dart';
import 'hidden_drawer.dart';
import 'dart:core';

import 'package:auth1/settings.dart';


import 'package:provider/provider.dart';


import 'main.dart';

class MyarHomePage extends StatefulWidget {
  const MyarHomePage({Key? key}) : super(key: key);

  @override
  _MyarHomePageState createState() => _MyarHomePageState();
}
bool _colorful = false;


class _MyarHomePageState extends State<MyarHomePage> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late bool _showNavBar;
  int selectedIndex = 0;



  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
    _showNavBar = true;

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });

    _pageController.animateToPage(
      selectedIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(
        selectedIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutQuad,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _listOfWidget.map((widget) => ChangeNotifierProvider.value(
              value: cartModel,
              child: widget,
            )).toList(),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _showNavBar ? 1.0 : 0.0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: _showNavBar
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    _colorful = !_colorful; // Toggle the value
                  });
                },
                child: SafeArea(
                  key: const ValueKey<bool>(true),
                  child: SwitchListTile(
                    value: _colorful,
                    onChanged: (bool value) {
                      setState(() {
                        _colorful = value; // Update the value
                      });
                    },
                  ),
                ),
              )
                  : const SizedBox(key: ValueKey<bool>(false)),
            ),
          ),
        ],
      ),
      bottomNavigationBar:  AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _showNavBar ? 1.0 : 0.0,
    child: DefaultTextStyle(
    style: TextStyle(
    // Set your desired font properties
    fontFamily: 'nz',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    // Add any other desired properties
    ),
        child: _colorful
            ? SlidingClippedNavBar.colorful(
          backgroundColor: Colors.black,
          onButtonPressed: onButtonPressed,
          iconSize: 30,
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              icon: Icons.home,
              title: 'الرئيسية',

              activeColor: Colors.blue,
              inactiveColor: Colors.blue,
            ),
            BarItem(
              icon: Icons.favorite,
              title: 'المفضلات',
              activeColor: Colors.red,
              inactiveColor: Colors.red,
            ),

            BarItem(
              icon: Icons.shopping_cart,
              title: 'السلة',
              activeColor: const Color(0xff4fdfc9),
              inactiveColor: const Color(0xff4fdfc9),
            ),
            BarItem(
              icon: Icons.settings,
              title:
              'الاعدادات',

              activeColor: Colors.purple,
              inactiveColor: Colors.purple,
            ),
          ],
        )

            : SlidingClippedNavBar(
          backgroundColor: Colors.white,
          onButtonPressed: onButtonPressed,
          iconSize: 30,
          activeColor: const Color(0xFF01579B),
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              icon: Icons.home,
              title: 'الرئيسية',

            ),
            BarItem(
              icon: Icons.favorite,
              title: 'المفضلات',

            ),
            BarItem(
              icon: Icons.shopping_cart,
              title: 'السلة',

            ),
            BarItem(
              icon: Icons.settings,
              title: 'الاعدادات',
            ),
          ],
        ),
      ),
      ));
  }
}
String perfumeName = '';
Map<String, String> itemImages={};
String searchQuery = '';

List<Map<String, dynamic>> cartItems = [
  // Add your cart items here
  {'name': 'Item 1', 'price': 10.0},
  {'name': 'Item 2', 'price': 20.0},
  {'name': 'Item 3', 'price': 30.0},
];
List<String> uniqueCartItems = [];

List<Widget> _listOfWidget = <Widget>[
  AppDrawerar(child: Glassar(removeItemCallback: (String ) {  },),),

  const AppDrawerar(child: FavouritearScreen(),),

  AppDrawerar(child: arCartPagee()),

  const AppDrawerar(child: Scenear()),

  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.shopping_cart,
      size: 56,
      color: Colors.brown,

    ),
  ),

  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.search,
      size: 56,
      color: Colors.brown,
    ),
  ),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.shopping_cart_rounded,
      size: 56,
      color: Colors.brown,
    ),
  ),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.tune_rounded,
      size: 56,
      color: Colors.brown,
    ),
  ),
];