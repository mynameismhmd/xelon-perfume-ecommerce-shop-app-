import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneNumberPage2 extends StatefulWidget {
  const PhoneNumberPage2({super.key});

  @override
  _PhoneNumberPage2State createState() => _PhoneNumberPage2State();
}

class _PhoneNumberPage2State extends State<PhoneNumberPage2> {
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _getPhoneNumber();
  }

  Future<void> _getPhoneNumber() async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc('user_id').get();

    setState(() {
      _phoneNumber = documentSnapshot.get('phoneNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Number Page'),
      ),
      body: Center(
        child: Text(
          'Phone Number: $_phoneNumber',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
