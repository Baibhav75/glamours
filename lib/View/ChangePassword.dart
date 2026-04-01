import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final controller = Get.put(ChangePasswordController());

  final oldPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              _field("Old Password", oldPassCtrl),
              const SizedBox(height: 16),

              _field("New Password", newPassCtrl),
              const SizedBox(height: 16),

              _field("Confirm Password", confirmPassCtrl),
              const SizedBox(height: 30),

              Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {

                      if (newPassCtrl.text != confirmPassCtrl.text) {
                        Get.snackbar("Error", "Passwords do not match");
                        return;
                      }

                      controller.changePassword(
                        oldPassword: oldPassCtrl.text.trim(),
                        newPassword: newPassCtrl.text.trim(),
                        confirmPassword: confirmPassCtrl.text.trim(),
                      );
                    }
                  },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Change Password"),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      validator: (value) =>
      value == null || value.isEmpty ? "Enter $label" : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}