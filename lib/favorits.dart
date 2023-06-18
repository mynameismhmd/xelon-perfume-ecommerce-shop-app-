import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';
import 'package:provider/provider.dart';
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();

  static List<String> favoriteItems = [];

  static void addFavorite(String item) {
    favoriteItems.add(item);
  }

  static void removeFavorite(String item) {
    favoriteItems.remove(item);
  }
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Perfumes',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Color(0xff842d4f) : Colors.white,
      ),
      body: FavouriteScreen.favoriteItems.isEmpty
          ? _buildEmptyFavorites(isDarkMode)
          : _buildFavoriteList(),
    );
  }

  Widget _buildEmptyFavorites(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Save your Favorite Perfumes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 16),
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

  Widget _buildFavoriteList() {
    return ListView.builder(
      itemCount: FavouriteScreen.favoriteItems.length,
      itemBuilder: (context, index) {
        String item = FavouriteScreen.favoriteItems[index];
        return ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                FavouriteScreen.removeFavorite(item);
              });
            },
          ),
        );
      },
    );
  }
}
