import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: true,
        backgroundColor: AppColors.backgroundBlack,
        foregroundColor: AppColors.textWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              Text(
                "Welcome to Glamorous",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12),

              Text(
                "These terms and conditions outline the rules and regulations for the use of the Glamorous mobile application. "
                    "By accessing this app we assume you accept these terms and conditions. Do not continue to use the app if you do not agree to all the terms stated on this page.",
                style: TextStyle(fontSize: 14),
              ),

              SizedBox(height: 20),

              Text(
                "1. User Account",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "Users must provide accurate and complete information during registration. "
                    "You are responsible for maintaining the confidentiality of your account and password.",
              ),

              SizedBox(height: 20),

              Text(
                "2. Orders & Payments",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "All orders placed through the app are subject to availability and confirmation of payment. "
                    "We reserve the right to cancel any order if fraud or unauthorized activity is suspected.",
              ),

              SizedBox(height: 20),

              Text(
                "3. Returns & Refunds",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "Products can be returned within the allowed return period. Refunds will be processed "
                    "according to the company’s refund policy.",
              ),

              SizedBox(height: 20),

              Text(
                "4. Privacy Policy",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "We respect your privacy and are committed to protecting your personal data. "
                    "Information collected will only be used to improve user experience and provide services.",
              ),

              SizedBox(height: 20),

              Text(
                "5. Changes to Terms",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "We reserve the right to modify these terms at any time. Changes will be effective "
                    "immediately after posting in the app.",
              ),

              SizedBox(height: 30),

              Center(
                child: Text(
                  "© 2026 Glamorous. All rights reserved.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}