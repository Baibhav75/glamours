import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/Model/UpdateProfileModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/Controller/ UpdateProfileController.dart';

class updatedProfileScreen extends StatefulWidget {
  final String selfId;

  const updatedProfileScreen({super.key,  required this.selfId});

  @override
  State<updatedProfileScreen> createState() => _updatedProfileScreenState();
}

class _updatedProfileScreenState extends State<updatedProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  final Profilecontroller controller = Get.put(Profilecontroller());
  late String selfId;

  // Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final sponsorController = TextEditingController();
  final emailController = TextEditingController(); // ✅ ADD THIS LINE

  // Dropdown values
  String selectedGender = "Male";
  String selectedCountry = "India";
  String selectedState = "Delhi";
  String selectedCity = "Delhi";

  final genders = ["Male", "Female", "Other"];
  final countries = ["India", "USA", "UK"];
  final states = ["Delhi", "Gujarat", "Maharashtra"];
  final cities = ["Delhi", "Ahmedabad", "Mumbai"];

  @override
  void initState() {
    super.initState();
    selfId = widget.selfId; //
   // ✅ ADD HERE

    print("Self ID: $selfId");

    // 🔥 Dummy Data (Replace with API response)
    _setInitialData();
  }

  void _setInitialData() {
    nameController.text = "Ankur Kumar";
    phoneController.text = "9876543210";
    dobController.text = "01-01-2000";
    addressController.text = "Delhi, India";
    sponsorController.text = "SP12345";

    selectedGender = "Male";
    selectedCountry = "India";
    selectedState = "Delhi";
    selectedCity = "Delhi";
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    dobController.dispose();
    addressController.dispose();
    sponsorController.dispose();
    emailController.dispose(); // ✅ ADD THIS
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        title: const Text("Updated Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// PROFILE IMAGE
              _buildProfileImage(),

              const SizedBox(height: 20),

              /// NAME
              _buildTextField(
                controller: nameController,
                label: "Full Name",
                icon: Icons.person,
              ),

              const SizedBox(height: 15),

              /// PHONE
              _buildTextField(
                controller: phoneController,
                label: "Phone",
                icon: Icons.phone,
                keyboard: TextInputType.phone,
              ),

              const SizedBox(height: 15),

              /// EMAIL ✅ ADD HERE
              _buildTextField(
                controller: emailController,
                label: "Email",
                icon: Icons.email,
              ),

              const SizedBox(height: 15),

              /// GENDER
              _buildDropdown(
                label: "Gender",
                value: selectedGender,
                items: genders,
                onChanged: (val) => setState(() => selectedGender = val!),
              ),

              const SizedBox(height: 15),

              /// DOB (Date Picker)
              _buildDateField(),

              const SizedBox(height: 15),

              /// SPONSOR
              _buildTextField(
                controller: sponsorController,
                label: "Sponsor ID",
                icon: Icons.group,
              ),

              const SizedBox(height: 15),

              /// COUNTRY
              _buildDropdown(
                label: "Country",
                value: selectedCountry,
                items: countries,
                onChanged: (val) => setState(() => selectedCountry = val!),
              ),

              const SizedBox(height: 15),

              /// STATE
              _buildDropdown(
                label: "State",
                value: selectedState,
                items: states,
                onChanged: (val) => setState(() => selectedState = val!),
              ),

              const SizedBox(height: 15),

              /// CITY
              _buildDropdown(
                label: "City",
                value: selectedCity,
                items: cities,
                onChanged: (val) => setState(() => selectedCity = val!),
              ),

              const SizedBox(height: 15),

              /// ADDRESS
              _buildTextField(
                controller: addressController,
                label: "Address",
                icon: Icons.location_on,
              ),

              const SizedBox(height: 30),

              /// UPDATE BUTTON
              _buildButton(),

            ],
          ),
        ),
      ),
    );
  }

  // ================= Widgets =================

  Widget _buildProfileImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.amber, width: 3),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl:
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200",
          fit: BoxFit.cover,
          placeholder: (c, s) => const CircularProgressIndicator(),
          errorWidget: (c, s, e) => const Icon(Icons.person, size: 60),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label is required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );

        if (picked != null) {
          dobController.text =
          "${picked.day}-${picked.month}-${picked.year}";
        }
      },
      decoration: InputDecoration(
        labelText: "Date of Birth",
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {


              final request = UpdateProfileRequest(
                selfId: selfId,
                fullName: nameController.text,
                mobile: phoneController.text,
                email: emailController.text,
                address: addressController.text,
                city: selectedCity,
                state: selectedState,
                country: selectedCountry,
                gender: selectedGender,
              );

              await controller.updateUserProfile(request);
            }
          }, // ✅ comma missing tha
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Update Profile"),
        ),
      );
    });
  }
}