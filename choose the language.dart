import 'package:auth1/secndprofile.dart';
import 'package:auth1/the%20main%20welcome%20screen.dart';
import 'package:auth1/welcomear.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_icons/country_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'a new profile page.dart';
import 'armainwelcomescreen.dart';
import 'package:provider/provider.dart';

import 'main.dart';
class LanguageSelectionPage extends StatefulWidget {
  final Function(String) onLanguageSelected;

  LanguageSelectionPage({required this.onLanguageSelected});

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  TextEditingController searchController = TextEditingController();
  List<String> languages = ['English', 'Arabic'];
  List<String> filteredLanguages = [];
  String selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    filteredLanguages = languages;
  }

  void filterLanguages(String searchText) {
    setState(() {
      filteredLanguages = languages
          .where((language) =>
          language.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }
  void navigateToSelectedLanguagePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', selectedLanguage);

    if (selectedLanguage == 'English') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => thePerfumeWelcomeScreen()), // Replace 'EnglishPage' with your actual English page widget
      );
    } else if (selectedLanguage == 'Arabic') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => arPerfumeWelcomeScreen()), // Replace 'ArabicPage' with your actual Arabic page widget
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 373;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(15 * fem, 47 * fem, 0, 116 * fem),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20 * fem, 24 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5 * fem, 0, 0, 17 * fem),
                        width: 39 * fem,
                        height: 39 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10 * fem),
                          border: Border.all(color: themeProvider.isDarkMode ? Colors.black : Colors.white,),
                        ),
                      ),
                      Image.asset(
                        'assets/signup-login-flow/images/icon-chevronleft.png',
                        width: 9 * fem,
                        height: 15 * fem,
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 3 * fem, 188 * fem, 0),
                    width: 46 * fem,
                    height: 44 * fem,
                    child: Image.asset(
                      'assets/signup-login-flow/images/star-9.png',
                      width: 46 * fem,
                      height: 44 * fem,
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,

                    ),
                  ),
                  Container(
                    width: 46 * fem,
                    height: 44 * fem,
                    child: Image.asset(
                      'assets/signup-login-flow/images/star-8-SNx.png',
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      width: 46 * fem,
                      height: 44 * fem,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 24 * fem, 91 * fem),
              child: Text(
                'Choose the language',
                style: GoogleFonts.poppins(
                  fontSize: 30 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.3 * ffem / fem,
                  letterSpacing: -0.3 * fem,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,

                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.fromLTRB(5 * fem, 6 * fem, 0, 28 * fem),
                padding:
                EdgeInsets.fromLTRB(16 * fem, 18 * fem, 258 * fem, 18 * fem),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD8DADC)),
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10 * fem),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/signup-login-flow/images/icon-magnifyingglass-iNG.png',
                      width: 16 * fem,
                      height: 16 * fem,

                    ),
                    SizedBox(width: 8 * fem),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: filterLanguages,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.25 * ffem / fem,
                            color: Color(0x7F000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(5 * fem, 0, 0, 0),
                child: ListView.builder(
                  itemCount: filteredLanguages.length,
                  itemBuilder: (context, index) {
                    String language = filteredLanguages[index];
                    String imagePath = '';


                    if (language == 'Arabic') {
                      imagePath = 'assets/iqqqq.png';
                    } else if (language == 'English') {
                      imagePath = 'assets/ukflag3.jpg';
                    } else {
                      imagePath = '';
                    }

                    return Container(
                      height: 50 * fem,
                      margin: EdgeInsets.only(bottom: 10 * fem),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (imagePath.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(right: 10 * fem),
                              width: 30 * fem,
                              height: 30 * fem,
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguage = language;
                              });
                            },
                            child: Text(
                              language,
                              style: GoogleFonts.inter(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.25 * ffem / fem,

                              ),
                            ),
                          ),
                          SizedBox(width: 200),
                          if (language == selectedLanguage)
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 15 * fem, 29 * fem, 0),
                              width: 20 * fem,
                              height: 20 * fem,
                              child: Image.asset(
                                'assets/signup-login-flow/images/checkbox-on--4G4.png',
                                width: 20 * fem,
                                height: 20 * fem,

                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
             GestureDetector(
              onTap: navigateToSelectedLanguagePage,
            child: Container(
              margin: EdgeInsets.fromLTRB(5 * fem, 0, 0, 0),
              width: 353 * fem,
              height: 56 * fem,

              decoration: BoxDecoration(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,

                borderRadius: BorderRadius.circular(10 * fem),
              ),

              child: Center(
                child: Text(
                  'Continue',
                  style: GoogleFonts.inter(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w500,
                    color: themeProvider.isDarkMode ? Colors.black : Colors.white,

                  ),
                ),
              ),
            ),
            )  ],
        ),
      ),
    );
  }
}
