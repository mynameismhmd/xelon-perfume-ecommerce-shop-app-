import 'package:auth1/profile.dart';
import 'package:flutter/material.dart';

class AnimatedDialog extends StatelessWidget {
  final String title;
  final String message;
  final String imagePath;

  const AnimatedDialog({
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
                    builder: (context) =>const gProfilePage(),

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
        return const AnimatedDialog(
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
