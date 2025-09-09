import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // CONTROLLER OBSERVES THE CHANGES
  final Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(31.540703116329073, 74.3290539815909),
    zoom: 14,
  );

  final List<Marker> _marker = const [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(31.540703116329073, 74.3290539815909),
      infoWindow: InfoWindow(title: "My Current Location"),
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(31.52240111559777, 74.33196295230148),
      infoWindow: InfoWindow(title: "My University"),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          GoogleMapController controller = await _mapController.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(31.481690468258073, 74.30301410000001),
                zoom: 14,
              ),
            ),
          );
        },
        child: Icon(Icons.location_on, size: 28, color: Colors.white),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_marker),
        ),
      ),
    );
  }
}
