import 'dart:core';

import 'package:auth1/armyhomepage.dart';
import 'package:auth1/cart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:auth1/settings.dart';
import 'package:auth1/the%20main%20welcome%20screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_icons/line_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'armainwelcomescreen.dart';
import 'choose the language.dart';
import 'controller.dart';
import 'package:auth1/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cartpagee.dart';
import 'cartmodel.dart';
import 'favorits.dart';
import 'package:icon_badge/icon_badge.dart';
import 'firebase_options.dart';
import 'glassirium.dart';
import 'hidden_drawer.dart';
import 'orders.dart';
import 'package:provider/provider.dart';
final CartModel cartModel = CartModel(cartItems: [], itemImages: {}, itemPrices: {}, kkItems: {});
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {

  final CartController cartController = CartController();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  print('User granted permission: ${settings.authorizationStatus}');
  runApp(
    ChangeNotifierProvider(
      create: (context) => OrderStatusProvider(),
      child: MyApp(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class OrderStatusProvider extends ChangeNotifier {
  Map<String, bool> _paymentStatus = {}; // Map to store payment statuses

  bool getPaymentStatus(String orderNumber) {
    return _paymentStatus[orderNumber] ?? false; // Default value is false if not found
  }

  void updatePaymentStatus(String orderNumber, bool paymentStatus) {
    _paymentStatus[orderNumber] = paymentStatus;
    notifyListeners(); // Notify listeners about the change
  }
}


class MyApp extends StatefulWidget {
  final CartModel cartModel = CartModel(cartItems: [], itemImages: {}, itemPrices: {}, kkItems: {});

  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  String selectedLanguage = '';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  User? user;
  bool isDarkMode = false;
  @override
  void initState(){
    super.initState();
    user=FirebaseAuth.instance.currentUser;
    _registerFirebaseMessaging();
    _initializeLocalNotifications();
  }
  void _registerFirebaseMessaging() async {
    // Request permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get FCM token
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');
    }

    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
      _showNotification(message.notification?.title, message.notification?.body);
      // Handle the received message while the app is in the foreground
    });

    // Listen for notifications that open the app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Opened app from notification: ${message.notification?.title}');
      // Handle the action when the user opens the app from a notification
    });
  }

  void _initializeLocalNotifications() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String? title, String? body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',

      importance: Importance.high,
      priority: Priority.high,
    );
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'notification_payload',
    );
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartModel>(
      create: (context) => widget.cartModel,
      // Provide the cartModel instance
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
        child: ChangeNotifierProvider(
    create: (context) => OrderStatusProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            ThemeData appTheme = themeProvider.isDarkMode
                ? ThemeData.dark().copyWith(
              textTheme: ThemeData.dark().textTheme.copyWith(
                bodyText1: ThemeData.dark().textTheme.bodyText1?.copyWith(
                  fontFamily: 'mi',
                  color: Colors.white, // Set the custom font color for dark mode
                ),
                bodyText2: ThemeData.dark().textTheme.bodyText2?.copyWith(
                  fontFamily: 'mi',
                  color: Colors.white, // Set the custom font color for dark mode
                ),
              ),
            )
                : ThemeData.light().copyWith(
              textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: ThemeData.light().textTheme.bodyText1?.copyWith(
                  fontFamily: 'mi', // Set the custom font family for light mode
                ),
                bodyText2: ThemeData.light().textTheme.bodyText2?.copyWith(
                  fontFamily: 'mi', // Set the custom font family for light mode
                ),
              ),
            );

            return GetMaterialApp(
              title: 'xelon ',
              theme: appTheme,
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: null, // Hide the app bar
                body: user != null ? SplashScreen2() : const SplashScreen2(),
              ),
            );
          },
        ),
      ),
      ));
  }}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
bool _colorful = false;


class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
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
        child: _colorful
            ? SlidingClippedNavBar.colorful(
          backgroundColor: Colors.black,
          onButtonPressed: onButtonPressed,
          iconSize: 30,
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              icon: Icons.home,
              title: 'Home',

              activeColor: Colors.blue,
              inactiveColor: Colors.blue,
            ),
            BarItem(
              icon: Icons.favorite,
              title: 'favorites',
              activeColor: Colors.red,
              inactiveColor: Colors.red,
            ),

            BarItem(
              icon: Icons.shopping_cart,
              title: 'Cart',
              activeColor: const Color(0xff4fdfc9),
              inactiveColor: const Color(0xff4fdfc9),
            ),

            BarItem(
              icon: Icons.settings,
              title:
                'Settings',

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
              title: 'Home',

            ),
            BarItem(
              icon: Icons.favorite,
              title: 'favorites',

            ),
            BarItem(
              icon: Icons.shopping_cart,
              title: 'Cart',

            ),
            BarItem(
              icon: Icons.settings,
              title: 'settings',
            ),
          ],
        ),
      ),
    );
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
  AppDrawer(child: Glass(removeItemCallback: (String ) {  },),),

  const AppDrawer(child: FavouriteScreen(),),

  AppDrawer(child: CartPagee()),

const AppDrawer(child: Scene()),

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      // Navigate to the welcome screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  arPerfumeWelcomeScreen()),
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/splash.png', // Replace with your background image file path
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Image.asset(
                'assets/gif.gif', // Replace with your GIF image file path
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashScreen2 extends StatefulWidget {
const SplashScreen2({Key? key}) : super(key: key);

@override
_SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
late String selectedLanguage;

@override
void initState() {
super.initState();
initializeApp();
}

Future<void> initializeApp() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
selectedLanguage = prefs.getString('selectedLanguage') ?? "";

// Delay the navigation for 4 seconds
await Future.delayed(const Duration(seconds: 4));

// Navigate to the appropriate page based on the selected language
if (selectedLanguage == 'English') {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => MyHomePage()),
);
} else if (selectedLanguage == 'Arabic') {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => MyarHomePage()),
);
} else {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => LanguageSelectionPage(
onLanguageSelected: (String language) async {
await prefs.setString('selectedLanguage', language); // Save the selected language to SharedPreferences
setState(() {
selectedLanguage = language;
});
navigateToHomePage(); // Re-call navigateToHomePage after language selection
},
)),
);
}
}

void navigateToHomePage() {
if (selectedLanguage == 'English') {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => MyHomePage()),
);
} else if (selectedLanguage == 'Arabic') {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => MyarHomePage()),
);
} else {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => LanguageSelectionPage(
onLanguageSelected: (String language) {
setState(() {
selectedLanguage = language;
});
navigateToHomePage(); // Re-call navigateToHomePage after language selection
},
)),
);
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: Stack(
children: [
Positioned.fill(
child: Image.asset(
'assets/splash.png', // Replace with your background image file path
fit: BoxFit.cover,
),
),
Align(
alignment: Alignment.bottomCenter,
child: Padding(
padding: const EdgeInsets.only(bottom: 10.0),
child: Image.asset(
'assets/gif.gif', // Replace with your GIF image file path
width: 200, // Adjust the width as needed
height: 200, // Adjust the height as needed
),
),
),
],
),
);
}
}