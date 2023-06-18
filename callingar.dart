import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class callingar extends StatefulWidget {
  const callingar({super.key});

  @override
  State<callingar> createState() => _callingarState();
}

class _callingarState extends State<callingar> {
  final String phoneNumber = '07509012913'; // Replace with the specific phone number you want to call

  Future<void> makePhoneCall() async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffa79961),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              ' اتصل بهذا  الرقم لمعرفة حالة طلبك',
              style: TextStyle(fontSize: 16,fontFamily: 'nz',color: Colors.yellow),
            ),
            const Text(
              '07509012913',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16), // Add some vertical spacing
            ElevatedButton(
              onPressed: () async {
                await makePhoneCall();
              },
              child: const Text('اتصل'),)
          ],
        ),
      ),
    );
  }
}