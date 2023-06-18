import 'package:auth1/profile.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String _address = "";
  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 10),
            Text(
              "Address: $_address",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("get your current location"),
              onPressed: () {

                _saveAddress();

              },
            ),
        ElevatedButton(
          child: const Text("continume to next page"),
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const gProfilePage()),
            );

          },
        ),

          ],
        ),
      ),
    );
  }

  _saveAddress() async {
    // Get the user's current location
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Save the latitude and longitude to state
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
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
      "latitude": _latitude,
      "longitude": _longitude,
      "address": _address,
    });

    // Show a snackbar to let the user know the address was saved
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Address saved successfully!"),
      duration: Duration(seconds: 2),
    ));
  }
}
