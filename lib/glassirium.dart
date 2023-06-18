import 'dart:ui';

import 'package:auth1/cartpagee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import 'cartmodel.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'favorits.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:path/path.dart' as path;

import 'main.dart';


class Glass extends StatefulWidget {
  final Function(String) removeItemCallback;

  Glass({Key? key, required this.removeItemCallback}) : super(key: key);

  @override
  State<Glass> createState() => _GlassState();
}

class _GlassState extends State<Glass> {

  bool isFavorite = false;
  String perfumeName = '';
  List<String> favoriteItems = [];
  int selectedStarCount = 5;
  late Map<String, String> itemImages;
  String searchQuery = '';
  late List<String> cartItems = [];
  final stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String recognizedText = '';
  FlutterTts flutterTts = FlutterTts();
  int get cartLength => cartItems.length;
  final FocusNode searchFocusNode = FocusNode();
  late CartModel cartModel;
  final CartController cartController = Get.put(CartController());
  List<String> uniqueCartItems = [];
  late FocusNode _searchFocusNode;
  late Map<String, String> itemPrices = {};

  List<Map<String, dynamic>> displayedPerfumes = [];
  List<int> selectedStarCounts = [];
  List<Map<String, dynamic>> perfumes = [
    {'name': 'gucci', 'price': '22'},
    {'name': 'sarada', 'price': '66'},
    {'name': 'boruto', 'price': '88'},
    {'name': 'mansu', 'price': '99'},
    {'name': 'jaguar', 'price': '44'},
  ];
  List<String> kk = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  List<String> suggestions = [
    'gucci',
    'boruto',

  ];
  bool isSearchFocused = false;
  List<String> filteredSuggestions = [];
  @override
  void initState() {
    super.initState();
    displayedPerfumes = List.from(perfumes);
    selectedStarCounts = List<int>.filled(perfumes.length, 5);
    cartModel = CartModel(
      cartItems: [], // Convert cartItems to List<String>

      itemPrices: {}, // Use an empty Map<String, String>
      kkItems: {}, itemImages: {},
    );
    itemImages = {};
    speech.initialize();


    filteredSuggestions = suggestions;
    _searchFocusNode = FocusNode();
    initItemImages();
  }


  Future<void> initItemImages() async {
  // Load the list of item names
  List<String> itemNames = filteredPerfumes().map((perfume) => perfume['name'] as String).toList();

  // Iterate through the item names and generate image paths
  for (String itemName in itemNames) {
    String imagePath = await getImagePath(itemName);

    itemImages[itemName] = imagePath;
  }

  cartModel = CartModel(

    itemPrices: {}, // Replace with the appropriate item prices map
    kkItems: {}, // Replace with the appropriate kkItems map
    itemImages: itemImages, cartItems: [],
  );
}
  void _updateSuggestions(String input) {
    setState(() {
      filteredSuggestions = suggestions
          .where((suggestion) =>
          suggestion.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  void startListening() async {
    bool microphonePermissionGranted = await Permission.microphone.request().isGranted;
    if (microphonePermissionGranted) {
      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        setState(() {
          isListening = true;
        });
        speech.listen(
          onResult: (result) {
            setState(() {
              recognizedText = result.recognizedWords;
              flutterTts.speak(result.recognizedWords);
              searchQuery = recognizedText;
            });
          },
        );
      }
    }
 }



    @override
  void dispose() {
    super.dispose();
    speech.cancel();
    _searchFocusNode.dispose();


  }

  Future<String> getImagePath(String perfumeName) async {
    String imageName = perfumeName.toLowerCase().replaceAll(' ', '_');
    String imagePath = 'assets/$imageName.png';

    // Check if the image file exists in the assets folder
    bool fileExists = await rootBundle
        .load(imagePath)
        .then((value) => true)
        .catchError((_) => false);

    // If the image file does not exist, use a placeholder image path
    if (!fileExists) {
      imagePath = 'assets/pg.png';
    }

    return imagePath;
  }

  List<Map<String, dynamic>> filteredPerfumes() {
    if (searchQuery.isEmpty) {
      return displayedPerfumes;
    } else {
      return displayedPerfumes.where((perfume) {
        final name = perfume['name'] as String;
        return name.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
  }


  void _toggleFavorite(String perfumeName) {
    setState(() {
      isFavorite = FavouriteScreen.favoriteItems.contains(perfumeName);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
      if (!isFavorite) {
        FavouriteScreen.addFavorite(perfumeName);
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .doc(perfumeName)
            .set({'name': perfumeName})
            .then((_) {
          print('Item added to favorites: $perfumeName');
        })
            .catchError((error) {
          print('Failed to add item to favorites: $error');
        });
      } else {
        FavouriteScreen.removeFavorite(perfumeName);
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .doc(perfumeName)
            .delete()
            .then((_) {
          print('Item removed from favorites: $perfumeName');
      });
    }}});
  }

  void _addToCart(int index, String perfumeName, Widget imagePath, String? price) {
    final cartController = Get.find<CartController>();
    final user = FirebaseAuth.instance.currentUser;
    final cartModel = Provider.of<CartModel>(context, listen: false);
    if (_isItemInCart(cartController.cartItems, perfumeName)) {
      // Item is already in cart, so remove it
      cartController.removeItem(perfumeName, imagePath, price!);

      // Remove the item from Firestore
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .doc(perfumeName)
            .delete()
            .catchError((error) {
          print('Failed to remove item from cart: $error');
        });
      }
    } else {
      // Item is not in cart, so add it
      cartController.addToCart(perfumeName, imagePath, price ?? '');

      // Add the item to Firestore
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .doc(perfumeName)
            .set({
          'name': perfumeName,
          'imagePath': imagePath.toString(),
          'price': price,
        })
            .catchError((error) {
          print('Failed to add item to cart: $error');
        });
      }
    }

    setState(() {
      cartModel.cartItems = List.from(cartController.cartItems);
      cartItems = cartModel.cartItems.map<String>((item) => item['name'] as String).toList();
      itemPrices[perfumeName] = price ?? '';
    });
  }


  bool _isItemInCart(List<Map<String, dynamic>> cartItems, String perfumeName) {
    return cartItems.any((item) => item['name'] == perfumeName);
  }






// ...



  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context, listen: false);

    return ChangeNotifierProvider(
        create: (context) => cartModel,

    child: Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pxfuel-2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GlassContainer(
            height: 600,
            width: 350,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.40),
                Colors.white.withOpacity(0.10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.60),
                Colors.white.withOpacity(0.10),
                Colors.purpleAccent.withOpacity(0.05),
                Colors.purpleAccent.withOpacity(0.60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.39, 0.40, 1.0],
            ),
            blur: 4,
            borderRadius: BorderRadius.circular(30.0),
            borderWidth: 1.0,
            elevation: 3.0,
            isFrostedGlass: true,
            shadowColor: Colors.purple.withOpacity(0.20),
            child: Stack(
              children: [
                const Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    'Choose Perfume',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(

                  onTap: () {
                    if (isSearchFocused) {
                      setState(() {
                        isSearchFocused = false;
                        searchFocusNode.unfocus();
                      });
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 16,
                  right: 16,
                  child: TextField(
                    focusNode: searchFocusNode,
                    onTap: () {
                      setState(() {
                        isSearchFocused = true;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _updateSuggestions(value);

                      });
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search Perfumes',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 110,
                  left: 40,
                  right: 40,
                  child: Visibility(
                    visible: isSearchFocused && filteredSuggestions.isNotEmpty,
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredSuggestions.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Suggestions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          } else {
                            final suggestion = filteredSuggestions[index - 1];
                            return ListTile(
                              title: Text(
                                suggestion,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  searchQuery = suggestion;
                                  isSearchFocused = false;
                                  searchFocusNode.unfocus();
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),


                Positioned(
                  top: 88,
                  right: 87,
                  child: GestureDetector(
                    onTap: showSortOptions,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 88,
                  right: 40,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isListening) {
                          startListening();
                        } else {
                          startListening();
                        }
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      child:  IconButton(
                        onPressed: () {
                          if (isListening) {
                            stopListening();
                          } else {
                            startListening();
                          }
                        },
                        icon: Icon(isListening ? Icons.mic : Icons.mic_none,color: Colors.white,),

                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 18,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredPerfumes().length,
                      itemBuilder: (context, index) {
                        final perfume = filteredPerfumes()[index];
                        final perfumeName = perfume['name'];

                        final price = perfume['price']; // Retrieve the price from the perfume object
                        if (perfumeName == 'gucci') {
    return _buildCard(
    Container(
    margin: EdgeInsets.only(top: 20, right: 40 ,bottom: 60),
    child: Image(
    image: AssetImage('assets/shelmar.png'),
    ),
    ),
    perfumeName,
    price,
    cartItems,
    kk[index],
    );
    }




    if (perfumeName == 'sarada') {
    return _buildCard(
    Column(
    children: [
    Align(
    alignment: FractionalOffset.topLeft,
    child: Image.asset(
    'assets/pp.png',
    width: 200,
    height: 168,
    ),
    ),

    ],
    ),
    perfumeName,
    price,
    cartItems,
    kk[index],
    );}
                        if (perfumeName == 'jaguar') {
                          return _buildCard(
                            Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 40,
                                  child: Image.asset(
                                    'assets/jcct.png',
                                    width: 200,
                                    height: 126,
                                  ),
                                ),
                              ],
                            ),
                            perfumeName,
                            price,
                            cartItems,
                            kk[index],
                          );}

                        return _buildCard(
                          Image.asset(
                            'assets/pg.png',
                            width: 80,
                            height: 90,
                          ),
                          perfumeName,
                          price,
                          cartItems,
                          kk[index],
                        );
                      } ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )));}

  Widget _buildCard(
      Widget  imagePath,
      String perfumeName,
      String price,
      List<String> cartItems,
      String kkItem,

      ) {
    bool isInCart = cartItems.contains(perfumeName);
    bool isFavorite = FavouriteScreen.favoriteItems.contains(perfumeName);
    int index =
    perfumes.indexWhere((perfume) => perfume['name'] == perfumeName);






    // Replace with the actual price of the perfume

    return Stack(
      children: [
        // Card container
        Container(
          width: 200,

          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          decoration: BoxDecoration(
            color: const Color(0xff2a5896),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        // Favorite icon
        Positioned(
          left: 16,
          bottom: 154,
          child: Container(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () => _toggleFavorite(perfumeName),
              child: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.red : Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
        // Perfume image
        Positioned(
          top: -18,
          left: 140,
          child: imagePath != null
              ? SizedBox(
            width: 200,
            height: 200,
            child: imagePath,
          )
              : Image.asset(
            'assets/pg.png',
            width: 200,
            height: 200,
          ),
        ),
        // Perfume name
        Positioned(
          top: 60,
          bottom: 80,
          left: 80,
          right: 60,
          child: Text(
            perfumeName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Star rating
          // Star rating
        // Star rating
        Positioned(
          top: 120,
          left: 40,
          right: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (starIndex) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedStarCounts[index] = starIndex + 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    starIndex < selectedStarCounts[index]
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.yellow,
                    size: 20,
                  ),
                ),
              );
            }),
          ),
        ),
        // Add to cart button
        Positioned(
          bottom: 0,
          right: (MediaQuery.of(context).size.width - 120) / 2,
          top: 150,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: isInCart ? Colors.transparent : Colors.transparent,
              borderRadius: BorderRadius.circular(44),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(44),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: InkWell(
                  onTap: () {
                    _addToCart(index,perfumeName, imagePath,price);
                  },
                  child: Container(


                    child: Center(
                      child: Text(
                        isInCart ? 'Remove' : 'Add to Cart',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 0, top: 160, left: 160),
  child: Text(
  '$price \$', // Display the item price
  style: const TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  ),
  ),

        ),
        Positioned(
          bottom: 120,
          left: 40,
          right: 40,
          child: Text(
            kkItem,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
  void showSortOptions() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: isDarkMode ? Colors.black : Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Sort by Price', style: TextStyle( fontFamily:'mi',color: isDarkMode ? Colors.white : Colors.black,)),
                onTap: () {
                  setState(() {
                    displayedPerfumes.sort((a, b) => int.parse(a['price']).compareTo(int.parse(b['price'])));
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                title: Text('Sort by Name', style: TextStyle( fontFamily:'mi', color: isDarkMode ? Colors.white : Colors.black,)),
                onTap: () {
                  setState(() {
                    displayedPerfumes.sort((a, b) => a['name'].compareTo(b['name']));
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void stopListening() {
    speech.stop();
    setState(() {
      isListening = false;
    });

  }



}
