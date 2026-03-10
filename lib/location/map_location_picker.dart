import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapLocationPicker extends StatefulWidget {
  const MapLocationPicker({super.key});

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {

  final MapController mapController = MapController();

  LatLng selectedLocation = const LatLng(28.6139, 77.2090);

  String address = "Fetching address...";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// GET CURRENT LOCATION
  Future<void> _getCurrentLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      setState(() {
        address = "Location service disabled";
      });
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng newLocation = LatLng(
      position.latitude,
      position.longitude,
    );

    mapController.move(newLocation, 16);

    setState(() {
      selectedLocation = newLocation;
    });

    await _getAddress(newLocation);
  }

  /// GET ADDRESS FROM LAT LNG
  Future<void> _getAddress(LatLng location) async {

    try {

      setState(() {
        isLoading = true;
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      Placemark place = placemarks.first;

      setState(() {

        address =
        "${place.street}, ${place.locality}, ${place.administrativeArea}";

        isLoading = false;

      });

    } catch (e) {

      setState(() {
        address = "Unable to fetch address";
        isLoading = false;
      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Select Delivery Location"),
      ),

      body: Stack(
        children: [

          /// MAP
          FlutterMap(
            mapController: mapController,

            options: MapOptions(
              initialCenter: selectedLocation,
              initialZoom: 16,

              onPositionChanged: (position, hasGesture) {

                if (hasGesture) {

                  selectedLocation = position.center!;

                  _getAddress(selectedLocation);

                }

              },
            ),

            children: [

              /// FREE TILE SERVER
              TileLayer(
                urlTemplate:
                "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
                subdomains: const ['a','b','c','d'],
                userAgentPackageName: 'com.glamorous.app',
              ),

            ],
          ),

          /// CENTER PIN
          const Center(
            child: Icon(
              Icons.location_pin,
              size: 50,
              color: Colors.red,
            ),
          ),

          /// CURRENT LOCATION BUTTON
          Positioned(
            right: 16,
            bottom: 160,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.my_location),
            ),
          ),

          /// ADDRESS CARD
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,

            child: Container(

              padding: const EdgeInsets.all(16),

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    "Delivery Location",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                    address,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(

                    onPressed: () {

                      Navigator.pop(
                        context,
                        {
                          "lat": selectedLocation.latitude,
                          "lng": selectedLocation.longitude,
                          "address": address,
                        },
                      );

                    },

                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),

                    child: const Text("Confirm Location"),
                  ),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}