import 'package:flutter/material.dart';
import 'add_address_page.dart';
import 'map_location_picker.dart';

class SelectAddressSheet extends StatefulWidget {
  const SelectAddressSheet({super.key});

  @override
  State<SelectAddressSheet> createState() => _SelectAddressSheetState();
}

class _SelectAddressSheetState extends State<SelectAddressSheet> {

  String selectedAddress = "No location selected";

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      height: 420,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER
          const Text(
            "Select Delivery Address",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          /// SAVED ADDRESS
          _addressTile(
            "Home",
            "123 Main Street, Phase 1, City Name",
            "+91 9876543210",
          ),

          const SizedBox(height: 10),

          _addressTile(
            "Office",
            "IT Park Road, Tech City",
            "+91 9876543210",
          ),

          const SizedBox(height: 10),

          /// MAP SELECTED ADDRESS
          if (selectedAddress != "No location selected")
            _addressTile(
              "Selected Location",
              selectedAddress,
              "",
            ),

          const SizedBox(height: 20),

          /// ADD NEW ADDRESS
          ListTile(
            leading: const Icon(Icons.add_location_alt, color: Colors.purple),
            title: const Text("Add New Address"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddAddressPage(),
                ),
              );
            },
          ),

          /// CURRENT LOCATION
          ListTile(
            leading: const Icon(Icons.my_location, color: Colors.purple),
            title: const Text("Use Current Location"),

            onTap: () async {

              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapLocationPicker(),
                ),
              );

              if(result != null){

                setState(() {
                  selectedAddress = result["address"];
                });

                Navigator.pop(context, result);

              }

            },
          ),
        ],
      ),
    );
  }

  /// ADDRESS TILE
  Widget _addressTile(String title, String address, String phone) {

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [

          const Icon(Icons.location_on, color: Colors.purple),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  address,
                  style: const TextStyle(fontSize: 13),
                ),

                if(phone.isNotEmpty)
                  const SizedBox(height: 4),

                if(phone.isNotEmpty)
                  Text(
                    phone,
                    style: const TextStyle(fontSize: 13),
                  ),

              ],
            ),
          ),

          const Icon(Icons.check_circle, color: Colors.green)

        ],
      ),
    );
  }
}