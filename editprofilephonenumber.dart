import 'package:auth1/secndprofile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilephonenumber extends StatefulWidget {
  const EditProfilephonenumber({super.key});

  @override
  _EditProfilephonenumberState createState() => _EditProfilephonenumberState();
}

class _EditProfilephonenumberState extends State<EditProfilephonenumber> {
  final phoneController = TextEditingController();
  String phone = '';

  @override
  void initState() {
    super.initState();
    getPhoneNumber();
  }

  Future<void> getPhoneNumber() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc('user-id')
        .get();
    final data = doc.data();
    if (data != null) {
      setState(() {
        phone = data['phone'] ?? '';
      });
    }
  }

  Future<void> updatePhoneNumber(String newPhone) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('user_id')
        .update({'phoneNumber': newPhone});
    setState(() {
      phone = newPhone;
    });
  }

  void showEditPhoneNumberDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Phone Number'),
            content: TextFormField(
              controller: phoneController..text = phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'first Enter your phone number',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await updatePhoneNumber(phoneController.text.trim());
                  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
                },
                child: const Text('UPDATE'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Phone Number'),
            trailing: TextButton(
              onPressed: showEditPhoneNumberDialog,
              child: Text(
                phone.isEmpty ? 'Add Phone Number' : phone,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
