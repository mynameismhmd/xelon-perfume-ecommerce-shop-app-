import 'package:flutter/material.dart';

import 'maps.dart';

class gAnimatedDialog extends StatelessWidget {
  final String title;
  final String message;
  final String imagePath;

  const gAnimatedDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,

            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const MapPage(),

                  ),
                );
              },
              child: const Text('ok' ) ,
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const gAnimatedDialog(
          title: 'Success ' ,
          message: 'The operation was successful.',
          imagePath: 'assets/loading.gif',

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Dialog'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showDialog(context),
          child: const Text('Show Dialog'),
        ),
      ),
    );
  }
}
