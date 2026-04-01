import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../theme/app_colors.dart';
import '../Controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final ProfileController controller = Get.put(ProfileController());

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _selfIdController = TextEditingController();
  final _sponsorIdController = TextEditingController();
  final _addressController = TextEditingController();
  final _joiningDateController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();

  String _selectedCountry = 'India';
  String _selectedState = 'Delhi';
  String _selectedCity = 'Delhi';
  String _selectedGender = 'Male';

  final List<String> _cities = ['Delhi', 'Gandhinagar', 'Ahmedabad', 'Surat'];
  final List<String> _states = ['Delhi', 'Gujarat', 'Maharashtra', 'Karnataka'];
  final List<String> _countries = ['India', 'Bangladesh', 'USA', 'UK'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();

    final box = Hive.box('authBox');
    String? selfId = box.get('selfId');

    if (selfId != null) {
      controller.fetchProfile(selfId);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _selfIdController.dispose();
    _sponsorIdController.dispose();
    _addressController.dispose();
    _joiningDateController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),

      /// 🔥 GETX UI
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.profile.value?.data;

        if (data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  controller.profile.value?.message ?? "No Data Found",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final box = Hive.box('authBox');
                    String? selfId = box.get('selfId');
                    if (selfId != null) controller.fetchProfile(selfId);
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        /// 🔥 SET VALUE ONLY ONCE
        if (_nameController.text.isEmpty) {
          _nameController.text = data.fullName;
          _phoneController.text = data.mobile;
          _selfIdController.text = data.selfId;
          _sponsorIdController.text = data.sponsorId ?? "";
          _addressController.text = data.address ?? "";
          _joiningDateController.text = data.joiningDate ?? "";
          _dobController.text = data.dob ?? ""; // Set DOB
          _genderController.text = data.gender ?? ""; // Set Gender

          // Add user's city, state, country if not in lists
          if (data.city != null && !_cities.contains(data.city)) _cities.add(data.city!);
          if (data.state != null && !_states.contains(data.state)) _states.add(data.state!);
          if (data.country != null && !_countries.contains(data.country)) _countries.add(data.country!);
          if (data.gender != null && !_genders.contains(data.gender)) _genders.add(data.gender!);

          _selectedCity = data.city ?? "Delhi";
          _selectedState = data.state ?? "Delhi";
          _selectedCountry = data.country ?? "India";
          _selectedGender = data.gender ?? "Male"; // Set selected gender
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                const SizedBox(height: 20),

                /// PROFILE IMAGE
                _buildProfilePicture(),

                const SizedBox(height: 16),

                Text(
                  data.fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                /// NAME
                _buildTextField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 16),

                /// PHONE
                _buildPhoneField(),

                const SizedBox(height: 16),

                /// SELF ID (READ ONLY)
                TextFormField(
                  controller: _selfIdController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Self ID',
                    prefixIcon: const Icon(Icons.badge_outlined, color: AppColors.primaryGold),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// JOINING DATE (READ ONLY)
                TextFormField(
                  controller: _joiningDateController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Joining Date',
                    prefixIcon: const Icon(Icons.calendar_today_outlined, color: AppColors.primaryGold),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// GENDER
                _buildDropdownField(
                  label: 'Gender',
                  value: _selectedGender,
                  items: _genders,
                  onChanged: (value) {
                    setState(() => _selectedGender = value!);
                  },
                ),

                const SizedBox(height: 16),

                /// DOB
                _buildTextField(
                  controller: _dobController,
                  label: 'Date of Birth',
                  icon: Icons.cake_outlined,
                ),

                const SizedBox(height: 16),

                /// SPONSOR ID
                _buildTextField(
                  controller: _sponsorIdController,
                  label: 'Sponser ID',
                  icon: Icons.group_outlined,
                ),

                const SizedBox(height: 16),

                /// COUNTRY
                _buildDropdownField(
                  label: 'Country',
                  value: _selectedCountry,
                  items: _countries,
                  onChanged: (value) {
                    setState(() => _selectedCountry = value!);
                  },
                ),

                const SizedBox(height: 16),

                /// STATE
                _buildDropdownField(
                  label: 'State',
                  value: _selectedState,
                  items: _states,
                  onChanged: (value) {
                    setState(() => _selectedState = value!);
                  },
                ),

                const SizedBox(height: 16),

                /// CITY
                _buildDropdownField(
                  label: 'City',
                  value: _selectedCity,
                  items: _cities,
                  onChanged: (value) {
                    setState(() => _selectedCity = value!);
                  },
                ),

                const SizedBox(height: 16),

                /// ADDRESS
                _buildTextField(
                  controller: _addressController,
                  label: 'Address',
                  icon: Icons.location_on_outlined,
                ),

                const SizedBox(height: 32),

                /// UPDATE BUTTON
                _buildUpdateButton(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// ================= UI WIDGETS =================

  Widget _buildProfilePicture() {
    final data = controller.profile.value?.data;
    String? imageUrl = data?.profilePic;
    
    // Prefix with domain if it's a relative path
    if (imageUrl != null && imageUrl.startsWith('/')) {
      imageUrl = "https://glamorousfilmcity.com$imageUrl";
    }

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryGold, width: 3),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80',
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.person, size: 60),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primaryGold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone',
        prefixIcon: const Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Get.snackbar("Success", "Profile Updated");
          }
        },
        child: const Text("Update Profile"),
      ),
    );
  }
}