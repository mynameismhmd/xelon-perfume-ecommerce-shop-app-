import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'orders.dart';


class CallingPage extends StatefulWidget {
  final Function(bool) onCallMade; // Add onCallMade as a parameter to the CallingPage

  const CallingPage({Key? key, required this.onCallMade}) : super(key: key);

  @override
  _CallingPageState createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  final String phoneNumber = '07509012913'; // Replace with the specific phone number you want to call
  bool callMade = false; // Track if the call was made

  Future<void> makePhoneCall() async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
      setState(() {
        callMade = true;
      });

      widget.onCallMade(true); // Notify the parent widget about the call being made
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrdersPage(callMade: true)),
      ); // Navigate to the OrdersPage
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: callMade ? Colors.green : const Color(0xffa79961),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Call this number to see your order stats',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Text(
              '07509012913',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: callMade ? null : () async {
                await makePhoneCall();
              },
              child: const Text('Call'),
            ),
          ],
        ),
      ),
    );
  }
}
