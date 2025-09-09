import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LatLngToAddress extends StatefulWidget {
  const LatLngToAddress({super.key});

  @override
  State<LatLngToAddress> createState() => _LatLngToAddressState();
}

class _LatLngToAddressState extends State<LatLngToAddress> {
  String address = "";
  String coordinates = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Map"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    31.512314994592337,
                    74.32827221443432,
                  );
                  Placemark placemark = placemarks.first;
                  setState(() {
                    address =
                        "${placemark.name}, ${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.country}";
                  });
                },
                child: Text(
                  "Coordinates to Address",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Text("ADDRESS:\n$address", textAlign: TextAlign.center),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  List<Location> locations = await locationFromAddress(
                    "Gronausestraat 710, Enschede",
                  );
                  setState(() {
                    coordinates =
                        "${locations.first.latitude.toString()}, ${locations.first.longitude.toString()}";
                  });
                },
                child: Text(
                  "Address to Coordinates",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Text("COORDINATES:\n$coordinates", textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
