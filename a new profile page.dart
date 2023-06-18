import 'dart:io';


import 'package:auth1/aneweditprofile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' ;


import 'editemailandname.dart';
import 'editprofilephonenumber.dart';

class aProfilePage extends StatefulWidget {
  const aProfilePage({Key? key}) : super(key: key);

  @override
  State<aProfilePage> createState() => _aProfilePageState();
}

class _aProfilePageState extends State<aProfilePage> {
  File? _selectedImage;
  final double _outerPadding = 16;
  final double _largePadding = 40;
  final double _smallPadding = 16;
  final double _smallerPadding = 8;
  String _address = "";

  final Color _mainPurple = Colors.deepPurpleAccent.shade100;
  final int _whiteAlpha = 90;
  final int _blackAlpha = 90;

  final TextStyle _heading1 =
      const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700);
  final TextStyle _heading2 =
      const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  final TextStyle _buttonText =
      const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);
  final TextStyle _subtitle1 =
      const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);

  final List<Map<String, dynamic>> _places = [
    {
      'title': 'Mount Fuji',
      'image':
          'https://cdn.britannica.com/47/80547-050-8B316D38/Field-green-tea-Mount-Fuji-Shizuoka-prefecture.jpg',
      'date': '19 Jan - 20 Feb 2023',
    },
    {
      'title': 'Mount Drakensberg',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPggZ3NbRl8eAwYcwzbs6I3OmQVmctRjXYxTHLN7LucgFL7vFvKU5VUyElSm3cHCDkGr8&usqp=CAU',
      'date': '19 March - 20 April 2023',
    },
    {
      'title': 'Mount Everest',
      'image': 'https://cdn.britannica.com/17/83817-050-67C814CD/Mount-Everest.jpg',
      'date': '10 Jan - 18 Jan 2023',
    },
    {
      'title': 'Mount Rushmore',
      'image': 'https://s27363.pcdn.co/wp-content/uploads/2020/10/Mt-Rushmore-Travel-Guide.jpg.optimal.jpg',
      'date': '1 May - 20 May 2023',
    },
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _phoneNumberController = TextEditingController();

  User? _user;
  DocumentSnapshot? _userDoc;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _getPhoneNumber();
  }

  _getPhoneNumber() async {
    final DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc('user_id').get();
    setState(() {
      _phoneNumberController.text = documentSnapshot['phoneNumber'] ?? '';
    });
  }
  Future<void> _updateProfileImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Upload the image to Firebase Storage
      File imageFile = File(pickedFile.path);
      Reference storageReference = FirebaseStorage.instance.ref().child('profile_images/${_user?.uid}.jpg');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() {});

      // Get the download URL of the uploaded image
      String imageUrl = await storageReference.getDownloadURL();

      // Update the user's profile photo URL in Firebase Auth
      User? currentUser = FirebaseAuth.instance.currentUser;
      await currentUser?.updateProfile(photoURL: imageUrl);

      // Update the UI with the new image
      setState(() {
        _user = FirebaseAuth.instance.currentUser;
      });
    }
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser;
    _userDoc = await _firestore.collection('users').doc(_user?.uid).get();
    setState(() {});
  }

 _saveAddress() async {
    // Get the user's current location
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Save the latitude and longitude to state
    setState(() {

    });

    // Get the address from the latitude and longitude
    final List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    // Save the address to state
    setState(() {
      _address = "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
    });

    // Save the address to Firestore
    FirebaseFirestore.instance.collection("addresses").add({

      "address": _address,
    });

    // Show a snackbar to let the user know the address was saved
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Address saved successfully!"),
      duration: Duration(seconds: 2),
    ));
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/background.jpeg'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(_outerPadding),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text('Your profile', style: _heading1),

                    ],
                  ),
                  SizedBox(height: _largePadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                     GestureDetector(
                          onTap: _updateProfileImage,


                          child: Stack(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(_whiteAlpha),
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white.withAlpha(_whiteAlpha),
                                  radius: 50,
                                  child: ClipOval(
                                    child: Image.network(
                                      _user?.photoURL ?? '',
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.edit, color: Colors.black, size: 16),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: _smallPadding),


                            Text(_user?.displayName ?? '', style: _heading1.copyWith(fontFamily: 'sc'),),


                        SizedBox(height: _smallPadding),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                const Icon(Icons.email, color: Colors.white),

                                const SizedBox(width: 5),
                                Text(_user?.email ?? '', style: _subtitle1.copyWith(color: Colors.white, fontSize: 20,fontFamily: 'mi')),
                              ],
                            ),
                            const SizedBox(), // Add spacing between the email and location
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on_outlined, color: Colors.white),
                                const SizedBox(width: 10,),
                                Text(_address, style: _subtitle1.copyWith(color: Colors.white, fontSize: 13,fontFamily: 'mi')),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: _smallPadding),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _mainPurple,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                          ),
                          child: const Text("get your current location" ,style:TextStyle(fontFamily: 'mi', fontWeight: FontWeight.bold,fontSize: 14)),
                          onPressed: () {

                            _saveAddress();

                          },
                        ),
                        ElevatedButton(
                          onPressed: () { Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => editprofile(),
                            ),
                          );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _mainPurple,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                          ),
                          child: Text('Edit Your Profile', style: _buttonText.copyWith(fontFamily: 'mi')),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: _largePadding),

                  SizedBox(height: _smallPadding),

                  SizedBox(height: _largePadding),

                  SizedBox(height: _smallPadding),

                  SizedBox(height: _smallerPadding),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}