import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
   // Declare a variable to store the phone number
  final String phoneNumber = '+964 07509012913'; // Replace with the specific phone number you want to call

  Future<void> makePhoneCall() async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
    } else {
      throw 'Could not launch $url';
    }
  }


  User? _user;
  DocumentSnapshot? _userDoc;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _getPhoneNumber();
  }

  Future<void> _getPhoneNumber() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc('user_id').get();
      _phoneNumberController.text = documentSnapshot['phoneNumber'] ?? '';
    } catch (e) {
      print('Error retrieving phone number from Firebase: $e');
    }
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser;
    _userDoc = await _firestore.collection('users').doc(_user?.uid).get();
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(_user?.photoURL ?? ''),
              radius: 50,
            ),
            const SizedBox(height: 16),
            Text(
              _user?.displayName ?? '',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              _phoneNumberController.text,
              style: const TextStyle(fontSize: 20),
            ),

      ElevatedButton(
        onPressed: () async {
          await makePhoneCall();
        },
        child: const Text('Call'),)
          ],
        ),
      ),
    );
  }
}
