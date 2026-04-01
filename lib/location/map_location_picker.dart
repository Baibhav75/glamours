import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapLocationPicker extends StatefulWidget {
  const MapLocationPicker({super.key});

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {

  GoogleMapController? _mapController;

  LatLng selectedLocation = const LatLng(28.6139, 77.2090);

  String address = "Fetching address...";
  bool isLoading = true;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  /// INIT LOCATION (permission + fetch)
  Future<void> _initLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        address = "Location permission denied permanently";
      });
      return;
    }

    _getCurrentLocation();
  }

  /// GET CURRENT LOCATION
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng newLocation = LatLng(
        position.latitude,
        position.longitude,
      );

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(newLocation, 16),
      );

      setState(() {
        selectedLocation = newLocation;
      });

      _getAddress(newLocation);

    } catch (e) {
      setState(() {
        address = "Unable to fetch location";
      });
    }
  }

  /// GET ADDRESS FROM LAT LNG
  Future<void> _getAddress(LatLng location) async {

    setState(() => isLoading = true);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      Placemark place = placemarks.first;

      setState(() {
        address =
        "${place.name}, ${place.locality}, ${place.administrativeArea}";
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
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Select Delivery Location"),
      ),

      body: Stack(
        children: [

          /// GOOGLE MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLocation,
              zoom: 16,
            ),

            myLocationEnabled: true,
            myLocationButtonEnabled: false,

            onMapCreated: (controller) {
              _mapController = controller;
            },

            /// CAMERA MOVE
            onCameraMove: (position) {

              selectedLocation = position.target;

              if (_debounce?.isActive ?? false) {
                _debounce!.cancel();
              }

              _debounce = Timer(const Duration(milliseconds: 500), () {
                _getAddress(selectedLocation);
              });
            },
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
            bottom: 170,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
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