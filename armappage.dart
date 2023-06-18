
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'armyhomepage.dart';
import 'main.dart';

class arMapPage extends StatefulWidget {
  const arMapPage({super.key});

  @override
  _arMapPageState createState() => _arMapPageState();
}

class _arMapPageState extends State<arMapPage> {
  GoogleMapController? mapController;
  Location location = Location();
  LatLng? _currentLocation;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCurrentLocation() async {
    LocationData currentLocation = await location.getLocation();
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 15,
      ),
    ));
  }

  void _onSaveLocation() async {
    if (_currentLocation != null) {
      await firestore.collection('locations').add({
        'latitude': _currentLocation!.latitude,
        'longitude': _currentLocation!.longitude,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(

        content: const Text('تم حفظ الموقع',style: TextStyle(fontFamily: 'nz'),),
        action: SnackBarAction(
          textColor: Colors.yellow,

          label: 'التالي',

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyarHomePage()),
            );
          },
        ),

      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الخريطة',style: TextStyle(fontFamily: 'nz'),),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 12,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: _currentLocation != null ? {
              Marker(
                markerId: const MarkerId('current_location'),
                position: _currentLocation!,
                infoWindow: const InfoWindow(title: 'Current Location'),
              ),
            } : {},
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _onCurrentLocation,
                  child: const Icon(Icons.location_searching),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: _onSaveLocation,
                  child: const Icon(Icons.save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
