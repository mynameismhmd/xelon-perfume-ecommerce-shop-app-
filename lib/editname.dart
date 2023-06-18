import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'a new profile page.dart';

class nEditProfilePage extends StatefulWidget {
  User? user;

  nEditProfilePage({super.key});

  @override
  _nEditProfilePageState createState() => _nEditProfilePageState();
}

class _nEditProfilePageState extends State<nEditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.displayName);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Google Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Google name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateProfile(
                      _nameController.text,

                    );
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    final usersRef = FirebaseFirestore.instance.collection('users');

    try {
      await user!.updateDisplayName(name);
      await usersRef.doc(user.uid).update({
        'displayName': name,

      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated'),
        ),
      );

      Future.delayed(const Duration(seconds: 1)).then((_) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const aProfilePage()));
      });
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error updating profile'),
        ),
      );
    }
  }
}