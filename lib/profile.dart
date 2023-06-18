import 'package:auth1/signup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class gProfilePage extends StatefulWidget {
  const gProfilePage({super.key});





 
  
  @override
  _gProfilePageState createState() => _gProfilePageState();
}

class _gProfilePageState extends State<gProfilePage> {
   
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   User? _user;
   String? _name;
   String? _email;
  String? _phone;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _fetchUserData();
  }

  void _fetchUserData() async {
    final doc = await _firestore.collection('users').doc(_user?.uid).get();
    setState(() {
      _name = doc['name'];
      _email = doc['email'];
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
          child: const Text('Sign Out'),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
      
          },
        ),
            Text(
              'Name: $_name',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Email: $_email',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Phone: $_phone',
              style: const TextStyle(fontSize: 24),
            ),
            
          ],
        ),
      ),
    );
  }
  
}
