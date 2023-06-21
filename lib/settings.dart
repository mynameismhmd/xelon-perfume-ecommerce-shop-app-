import 'package:app_settings/app_settings.dart';
import 'package:auth1/welcome.dart';
import 'package:auth1/welcomear.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:auth1/utils.dart';
import 'a new profile page.dart';
import 'aboutus.dart';
import 'package:provider/provider.dart';
import 'armainwelcomescreen.dart';
import 'choose the language.dart';
import 'main.dart';
class Scene extends StatefulWidget {
  const Scene({super.key});

  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {

  bool switchValue = false;
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    void toggleDarkMode(bool value) {
      setState(() {
        isDarkMode = !isDarkMode;
      });
    }
    ThemeData themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();
    void _showAppearanceSettingsBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(
                        'Appearance Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SwitchListTile(
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleDarkMode(); // Toggle dark mode state
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }
    void _showChangePasswordDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change Password',style: TextStyle(color: Colors.white ,fontFamily: 'mi'),),
            content: Text('Do you want to change your password?',style: TextStyle(color: Colors.black ,fontFamily: 'mi'),),
            actions: [
              TextButton(
                child: Text('No',style: TextStyle(color: Colors.yellow ,fontFamily: 'mi'),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes',style: TextStyle(color: Colors.yellow ,fontFamily: 'mi'),),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(),
                    ),
                  );
                },
              ),
            ],
            backgroundColor: const Color(0xffa79961),
            elevation: 0,
          );
        },
      );
    }



    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return  Material( // Add Material widget as the root of the widget tree
        child:
      Theme(
      data: themeData,
        child: SizedBox(
      width: double.infinity,
      child: Container(
        // settingsuxH (6:23)
        width: double.infinity,
        height: 926*fem,
        decoration: BoxDecoration (
          color: const Color(0xffbbb8a1),
          borderRadius: BorderRadius.circular(40*fem),
        ),
        child: Stack(
          children: [

            Positioned(
              // autogroupwcazLgD (7Dmy5LL8LHn9fk14bgwcaZ)
              left: 73*fem,
              top: 661*fem,
              child: SizedBox(
                width: 318*fem,
                height: 24*fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      // iconoirfaceidd9X (6:204)
                      margin: EdgeInsets.fromLTRB(0*fem, 2*fem, 22*fem, 0*fem),
                      width: 12*fem,
                      height: 12*fem,
                      child: Image.asset(
                        'assets/page-1/images/logout.png',
                        width: 12*fem,
                        height: 12*fem,
                      ),
                    ),

          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  LanguageSelectionPage(onLanguageSelected: (String ) {  },)),
              );
            },
            child:
                    Container(
                      // signinwithfaceidHzm (6:61)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 213*fem, 3*fem),
                      child: Text(
                        'sign out',
                        style: SafeGoogleFont (
                          'Open Sans',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3625*ffem/fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),),
                    Container(
                      // vectorZBb (103:5)
                      margin: EdgeInsets.fromLTRB(0*fem, 2*fem, 0*fem, 0*fem),
                      width: 6*fem,
                      height: 12*fem,
                      child: Image.asset(
                        'assets/page-1/images/vector-NgD.png',
                        width: 6*fem,
                        height: 12*fem,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              // autograph16pwWPf (7DmwKoQyQuq1QUhrFR16Pw)
              left: 0*fem,
              top: 0*fem,
              child: SizedBox(
                width: 571*fem,
                height: 371.41*fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      // autogroup8vgycxV (7DmweTYYyhdvJxSw3J8Vgy)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 114.65*fem, 0*fem),
                      width: 367.35*fem,
                      height: double.infinity,
                      decoration: const BoxDecoration (
                        image: DecorationImage (
                          fit: BoxFit.cover,
                          image: AssetImage (
                            'assets/page-1/images/ellipse-2.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // arrowleftvyB (6:119)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 13.92*fem, 81.33*fem),
                      width: 11.08*fem,
                      height: 11.08*fem,
                      child: Image.asset(
                        'assets/page-1/images/arrow-left.png',
                        width: 11.08*fem,
                        height: 11.08*fem,
                      ),
                    ),
                    Container(
                      // settingsqqF (6:55)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 74.41*fem),
                      child: Text(
                        'Settings\n',
                        style: SafeGoogleFont (
                          'Open Sans',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3625*ffem/fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // autogroup7crh95F (7DmwnxJPvWPYq4sDCo7CrH)
              left: 65*fem,
              top: 251*fem,
              child: SizedBox(
                width: 326*fem,
                height: 24*fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [


                    Container(
                      // vectorrkM (6:158)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10*fem, 5*fem),
                      width: 16*fem,
                      height: 16*fem,
                      child: Image.asset(
                        'assets/page-1/images/vector-Se9.png',
                        width: 16*fem,
                        height: 16*fem,
                      ),
                    ),

            //  GestureDetector(
              //  onTap: () {
               //   Navigator.push(
               //     context,
               //     MaterialPageRoute(builder: (context) => aProfilePage()),
               //   );

                //},

                 Container(
                      // profileagM (6:56)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 242*fem, 0*fem),
                   child: GestureDetector(
                     onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const aProfilePage()),
    );

                         },
                      child: Text(
                        'Profile',

                        style: SafeGoogleFont (
                          'Open Sans',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3625*ffem/fem,
                          color: const Color(0xff000000),
                        ),
                      ),

                ),),
              SizedBox(
                      // vectoruTj (6:172)
                      width: 6*fem,
                      height: 12*fem,
                      child: Image.asset(
                        'assets/page-1/images/vector-BCy.png',
                        width: 6*fem,
                        height: 12*fem,
                      ),
                    ),
               ],
                ),
              ),
            ),
            Positioned(
              // autogroupzakmSyT (7DmxUgfCHPrAqzmLZLZakM)
              left: 61*fem,
              top: 486*fem,
              child: SizedBox(
                width: 333*fem,
                height: 37*fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // autogroupf5h74zq (7DmxeBPNdhyzV4XXoNF5h7)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 62*fem, 0*fem),
                      width: 265*fem,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            // activitiesnotificationsCbF (6:176)
                            left: 30*fem,
                            top: 0*fem,
                            child: Align(
                              child: SizedBox(
                                width: 173*fem,
                                height: 24*fem,
                                child: GestureDetector(
                                  onTap: () {

                                    showDialog(
                                      context: context,

                                      barrierColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                color: Colors.black.withOpacity(0.5), // Adjust the opacity and color of the background
                                              ),
                                            ),
                                            BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(40.0),// Adjust the sigma values for desired blur effect
                                                child: AlertDialog(
                                                  title: const Text("notification", style: TextStyle(color: Colors.black),),
                                                  content: const Text("do you want to open notifications", style: TextStyle(color: Colors.white),),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text("yes", style: TextStyle(color: Colors.purple),),
                                                      onPressed: () {
                                                        AppSettings
                                                            .openNotificationSettings();
                                                      },      ),
                                                    TextButton(
                                                      child: const Text("no", style: TextStyle(color: Colors.blue),),
                                                      onPressed: () {
                                                        AppSettings.openNotificationSettings();
                                                      },
                                                    ),
                                                  ],
                                                  backgroundColor: const Color(0xffa79961),
                                                  elevation: 0,
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );},
                                child: Text(
                                  'Activities notifications',
                                  style: SafeGoogleFont (
                                    'Open Sans',
                                    fontSize: 17*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3625*ffem/fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),),
                          Positioned(
                            // vectorMsT (6:184)
                            left: 4*fem,
                            top: 5*fem,
                            child: Align(
                              child: SizedBox(
                                width: 16*fem,
                                height: 13.47*fem,
                                child: Image.asset(
                                  'assets/page-1/images/vector.png',
                                  width: 16*fem,
                                  height: 13.47*fem,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 6 * fem,
                height: 20 * fem,
                child: Image.asset(
                  'assets/page-1/images/vector-HnM.png',
                  width: 6*fem,
                  height: 12*fem,
                ),
              )

                  ],
                ),
              ),
            ),
            Positioned(
              // autogroupnfyqg2Z (7DmyKKvp1P8qM6osh6nfYq)
              left: 73*fem,
              top: 720*fem,
              child: SizedBox(
                width: 318*fem,
                height: 27*fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      // lockbfK (6:201)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 22*fem, 3*fem),
                      width: 12*fem,
                      height: 13.33*fem,
                      child: Image.asset(
                        'assets/page-1/images/lock.png',
                        width: 12*fem,
                        height: 13.33*fem,
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  _showChangePasswordDialog(context);
                },
                child:
                    Container(
                      // changepasswordKLR (6:194)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 137*fem, 3*fem),
                      child: Text(
                        'Change Password',
                        style: SafeGoogleFont (
                          'Open Sans',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3625*ffem/fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),),

                    Container(
                      // vectordM7 (6:196)
                      margin: EdgeInsets.fromLTRB(0*fem, 15*fem, 0*fem, 0*fem),
                      width: 6*fem,
                      height: 12*fem,
                      child: Image.asset(
                        'assets/page-1/images/vector-HnM.png',
                        width: 6*fem,
                        height: 12*fem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // autogroupaxqwYys (7DmyXpZzaDREM2bpAiaXqw)
              left: 73*fem,
              top: 779*fem,
              child: SizedBox(
                width: 318*fem,
                height: 30*fem,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [



                  ],
                ),
              ),
            ),
            Positioned(
              // autogroupojnqShs (7DmxGwVmGh6vBnUqPcoJnq)
              left: 60*fem,
              top: 300*fem,
              child: SizedBox(
                width: 331*fem,
                height: 37*fem,
                child: Stack(
                  children: [
                    Container(
                      // sendWjf (6:185)
                      margin:EdgeInsets.only(
                        top: 4 * fem,
                        right: 2 * fem,
                        left: 4*ffem,
                        bottom: 4 * fem,
                      ),width: 20.33*fem,
                      height: 20.33*fem,
                      child: Image.asset(
                        'assets/page-1/images/translation-2.png',
                        width: 20.33*fem,
                        height: 20.33*fem,
                      ),
                    ),

                    Container(
                      // emailnotificationsDty (6:177)
                      margin: EdgeInsets.fromLTRB(30*fem, 0*fem, 140*fem, 15*fem),
                      child: GestureDetector(
                        onTap: () {


    showDialog(
    context: context,

    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
    return Stack(
    children: [
    GestureDetector(
    onTap: () {
    Navigator.pop(context);
    },
    child: Container(
    color: Colors.black.withOpacity(0.5), // Adjust the opacity and color of the background
    ),
    ),
    BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(40.0),// Adjust the sigma values for desired blur effect
    child: AlertDialog(
    title: const Text("language", style: TextStyle(color: Colors.black),),
    content: const Text("choose your language", style: TextStyle(color: Colors.white),),
    actions: <Widget>[
    TextButton(
    child: const Text("arabic", style: TextStyle(color: Colors.purple),),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  arPerfumeWelcomeScreen()),
      );
    },
    ),
      TextButton(
        child: const Text("english", style: TextStyle(color: Colors.blue),),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const aProfilePage()),
          );
        },
      ),
    ],
      backgroundColor: const Color(0xffa79961),
    elevation: 0,
    ),
    ),
    )],
    );
    },
    );},

                      child: Text(
                        'language ',
                        style: SafeGoogleFont (
                          'Open Sans',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3625*ffem/fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),),

                    Container(

                      // autogroupp5qxYgM (7Dmxxkgkv3BDo8Knfhp5qX)
                      margin:EdgeInsets.only(
                        top: 0 * fem,
                        right: 2 * fem,
                        left: 334*ffem,
                        bottom: 0 * fem,
                      ),

                      width: 6*fem,
                      height: 12*fem,
                      child: Image.asset(
                        'assets/page-1/images/auto-group-p5qx.png',
                        width: 6*fem,
                        height: 12*fem,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
              // autogroupabembMo (7Dmxp1SL7raYVn52jaABEM)
              left: 61.3333282471*fem,
              top: 570*fem,
              child: SizedBox(
                width: 332.67*fem,
                height: 24*fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      // sendWjf (6:185)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16.33*fem, 3.33*fem),
                      width: 13.33*fem,
                      height: 13.33*fem,
                      child: Image.asset(
                        'assets/page-1/images/send.png',
                        width: 13.33*fem,
                        height: 13.33*fem,
                      ),
                    ),

                    Container(
                      // emailnotificationsDty (6:177)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 151*fem, 0*fem),
                      child: GestureDetector(
                        onTap: () {

                          showDialog(
                            context: context,

                            barrierColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5), // Adjust the opacity and color of the background
                                    ),
                                  ),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40.0),// Adjust the sigma values for desired blur effect
                                      child: AlertDialog(
                                        title: const Text("notification", style: TextStyle(color: Colors.black),),
                                        content: const Text("do you want to open notifications", style: TextStyle(color: Colors.white),),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("yes", style: TextStyle(color: Colors.purple),),
                                            onPressed: () {
                                              AppSettings
                                                  .openNotificationSettings();
                                            },      ),
                                          TextButton(
                                            child: const Text("no", style: TextStyle(color: Colors.blue),),
                                            onPressed: () {
                                              AppSettings.openNotificationSettings();
                                            },
                                          ),
                                        ],
                                        backgroundColor: const Color(0xffa79961),
                                        elevation: 0,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );},
                      child: Text(
                        'Email notifications',
                        style: SafeGoogleFont (
                          'Open Sans',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3625*ffem/fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),),
                    SizedBox(
                      // autogroupp5qxYgM (7Dmxxkgkv3BDo8Knfhp5qX)
                      width: 6*fem,
                      height: 12*fem,
                      child: Image.asset(
                        'assets/page-1/images/auto-group-p5qx.png',
                        width: 6*fem,
                        height: 12*fem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Open Appearance Settings Bottom Sheet

            Positioned(
              left: 64 * fem,
              top: 520 * fem,
              child: SizedBox(
                width: 322 * fem,
                height: 30 * fem,
                child: InkWell(
                  onTap: () {
                    _showAppearanceSettingsBottomSheet(context);
                  },
                  child: Container(
                    // appearanceContainer (Modify this container to customize appearance settings button)
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(12 * fem),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // sendWjf (6:185)
                          margin: EdgeInsets.only(left: 0 * fem),
                          width: 13.33*fem,
                          height: 13.33*fem,
                          child: Image.asset(
                            'assets/darmode.png',
                            width: 13.33*fem,
                            height: 13.33*fem,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16 * fem),
                          child: Text(
                            'dark mode',
                            style: SafeGoogleFont(
                              'Open Sans',
                              fontSize: 17 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(193 * fem, 0 * fem, 0* fem, 0 * fem),// Adjust the margin value as per your requirement
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16 * ffem,
                            color: Colors.black,
                          ),
                        ),],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              // accountsyX (6:159)
              left: 37*fem,
              top: 209*fem,
              child: Align(
                child: SizedBox(
                  width: 71*fem,
                  height: 21*fem,
                  child: Text(
                    'ACCOUNT',
                    style: SafeGoogleFont (
                      'Open Sans',
                      fontSize: 15*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3625*ffem/fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // accountsyX (6:159)
              left: 37*fem,
              top: 350*fem,
              child: Align(
                child: SizedBox(
                  width: 71*fem,
                  height: 21*fem,
                  child: Text(
                    'SUPPORT',
                    style: SafeGoogleFont (
                      'Open Sans',
                      fontSize: 15*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3625*ffem/fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // autogroupabembMo (7Dmxp1SL7raYVn52jaABEM)
              left: 61.3333282471*fem,
              top: 380*fem,
              child: SizedBox(
                width: 332.67*fem,
                height: 24*fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      // sendWjf (6:185)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16.33*fem, 3.33*fem),
                      width: 13.33*fem,
                      height: 13.33*fem,
                      child: Image.asset(
                        'assets/ib.png',
                        width: 13.33*fem,
                        height: 13.33*fem,
                      ),
                    ),
              GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AboutUsPage()),
                  );
                },
                child:
                    Container(
                      // emailnotificationsDty (6:177)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 151*fem, 0*fem),
                      child: Text(
                        'about us                ',
                        style: SafeGoogleFont (
                          'Open Sans',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3625*ffem/fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),),
                    SizedBox(
                      // autogroupp5qxYgM (7Dmxxkgkv3BDo8Knfhp5qX)
                      width: 6*fem,
                      height: 12*fem,
                      child: Image.asset(
                        'assets/page-1/images/auto-group-p5qx.png',
                        width: 6*fem,
                        height: 12*fem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // notificationsPBB (6:160)
              left: 31*fem,
              top: 439*fem,
              child: Align(
                child: SizedBox(
                  width: 110*fem,
                  height: 21*fem,
                  child: Text(
                    'NOTIFICATIONS',
                    style: SafeGoogleFont (
                      'Open Sans',
                      fontSize: 15*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3625*ffem/fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // securityVED (6:161)
              left: 37*fem,
              top: 614*fem,
              child: Align(
                child: SizedBox(
                  width: 68*fem,
                  height: 21*fem,
                  child: Text(
                    'SECURITY',
                    style: SafeGoogleFont (
                      'Open Sans',
                      fontSize: 15*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3625*ffem/fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),






          ],
        ),
      ),
        )));
  }
}
class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String errorText = '';

  void _savePassword(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String currentPassword = currentPasswordController.text;
      String newPassword = newPasswordController.text;

      // Verify current password
      AuthCredential credential =
      EmailAuthProvider.credential(email: user.email!, password: currentPassword);
      try {
        await user.reauthenticateWithCredential(credential);
      } catch (e) {
        // Handle authentication error
        setState(() {
          errorText = 'Invalid current password.';
        });
        return;
      }

      // Update password in Firebase Authentication
      try {
        await user.updatePassword(newPassword);
      } catch (e) {
        // Handle password update error
        setState(() {
          errorText = 'Failed to update password.';
        });
        return;
      }

      // Update password in Firestore
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'password': newPassword,
      });

      // Show password saved dialog
      _showPasswordSavedDialog(context);
    }
  }

  void _showPasswordSavedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Saved'),
          content: Text('Your password has been saved.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Column(
        children: [
          TextField(
            controller: currentPasswordController,
            decoration: InputDecoration(labelText: 'Current Password'),
          ),
          TextField(
            controller: newPasswordController,
            decoration: InputDecoration(labelText: 'New Password'),
          ),
          if (errorText.isNotEmpty)
            Text(
              errorText,
              style: TextStyle(color: Colors.red),
            ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                errorText = '';
              });
              _savePassword(context);
            },
            child: Text('Save Password'),
          ),
        ],
      ),
    );
  }
}


