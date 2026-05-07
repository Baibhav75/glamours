import 'package:flutter/material.dart';

import 'map_location_picker.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final houseController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  String selectedAddress = "No location selected";
  double? latitude;
  double? longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Address"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location Card
            GestureDetector(
              onTap: _pickLocation,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red.shade200, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.my_location, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Delivery Location",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedAddress,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: Colors.red.shade700),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "User Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _buildTextField("Full Name", nameController, Icons.person_outline),
            _buildTextField("Phone Number", phoneController, Icons.phone_outlined,
                inputType: TextInputType.phone),

            const SizedBox(height: 24),
            const Text(
              "Address Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _buildTextField("House / Flat / Block No.", houseController, Icons.home_outlined),
            _buildTextField("Apartment / Road / Area", addressController, Icons.map_outlined),

            Row(
              children: [
                Expanded(child: _buildTextField("City", cityController, Icons.location_city_outlined)),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField("Pincode", pincodeController, Icons.pin_drop_outlined,
                      inputType: TextInputType.number),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                onPressed: _saveAddress,
                child: const Text(
                  "Save Address",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapLocationPicker()),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        selectedAddress = result['address'] ?? "Unknown Location";
        latitude = result['lat'];
        longitude = result['lng'];
        addressController.text = result['area'] ?? selectedAddress;
        if (result['city'] != null && result['city'].toString().isNotEmpty) {
          cityController.text = result['city'];
        }
        if (result['pincode'] != null && result['pincode'].toString().isNotEmpty) {
          pincodeController.text = result['pincode'];
        }
      });
    }
  }

  void _saveAddress() {
    if (latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a valid delivery location from the map.")),
      );
      return;
    }
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter User Details.")),
      );
      return;
    }
    if (houseController.text.isEmpty || cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter complete Address Details.")),
      );
      return;
    }

    // Process and save address
    Navigator.pop(context, {
      "name": nameController.text,
      "phone": phoneController.text,
      "house": houseController.text,
      "address": addressController.text,
      "city": cityController.text,
      "pincode": pincodeController.text,
      "lat": latitude,
      "lng": longitude,
    });
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey.shade600),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }
}