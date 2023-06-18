import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class FavouritearScreen extends StatefulWidget {
  const FavouritearScreen({Key? key}) : super(key: key);

  @override
  State<FavouritearScreen> createState() => _FavouritearScreenState();

  static List<String> favoriteItems = [];

  static void addFavorite(String item) {
    favoriteItems.add(item);
  }

  static void removeFavorite(String item) {
    favoriteItems.remove(item);
  }
}

class _FavouritearScreenState extends State<FavouritearScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Retrieve the theme provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('العطور المفضلة', style: TextStyle(fontFamily: 'nz')),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : const Color(0xFF842D4F),
      ),
      body: FavouritearScreen.favoriteItems.isEmpty
          ? _buildEmptyFavorites(themeProvider)
          : _buildFavoriteList(themeProvider),
    );
  }

  Widget _buildEmptyFavorites(ThemeProvider themeProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'احفظ عطرك المفضل هنا',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'nz',
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            width: 200,
            child: Lottie.network(
              'https://assets6.lottiefiles.com/private_files/lf30_DXPazq.json',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteList(ThemeProvider themeProvider) {
    return ListView.builder(
      itemCount: FavouritearScreen.favoriteItems.length,
      itemBuilder: (context, index) {
        String item = FavouritearScreen.favoriteItems[index];
        return ListTile(
          title: Text(
            item,
            style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            onPressed: () {
              setState(() {
                FavouritearScreen.removeFavorite(item);
              });
            },
          ),
        );
      },
    );
  }
}
