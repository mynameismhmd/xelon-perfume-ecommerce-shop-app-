
import 'package:auth1/secndprofile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneNumberController = TextEditingController();

  void _submitPhoneNumber() async {
    String phoneNumber = _phoneNumberController.text.trim();

    if (phoneNumber.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('user_id') // Replace with the actual user ID
            .set({'phoneNumber': phoneNumber}, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Phone number updated successfully!'),
            duration: const Duration(seconds: 1),
                onVisible: () {
      Future.delayed(const Duration(seconds: 3)).then((_) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfilePage()));
      });
               
            
       },
        
  ),
);
     
      } catch (e) {
        print('Error updating phone number: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a phone number!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Phone Number'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitPhoneNumber,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
