import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileImagePage extends StatefulWidget {
  const EditProfileImagePage({Key? key}) : super(key: key);

  @override
  _EditProfileImagePageState createState() => _EditProfileImagePageState();
}

class _EditProfileImagePageState extends State<EditProfileImagePage> {
  File? _imageFile;
  String? _imageUrl;

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_imageFile != null) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final destination = 'profile_images/$fileName.png';

      try {
        await firebase_storage.FirebaseStorage.instance.ref(destination).putFile(_imageFile!);
        final imageUrl = await firebase_storage.FirebaseStorage.instance.ref(destination).getDownloadURL();
        setState(() {
          _imageUrl = imageUrl;
        });
      } catch (e) {
        print('Error uploading image to Firebase: $e');
      }
    }
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
          children: [
            if (_imageUrl != null)
              CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(_imageUrl!),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImageToFirebase,
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
