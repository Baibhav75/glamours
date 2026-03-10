import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12),

              Text(
                "At Glamorous, we value your privacy and are committed to protecting your personal information. "
                    "This Privacy Policy explains how we collect, use, and safeguard your data when you use our mobile application.",
                style: TextStyle(fontSize: 14),
              ),

              SizedBox(height: 20),

              Text(
                "1. Information We Collect",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "We may collect personal information such as your name, email address, phone number, "
                    "delivery address, and payment details when you register or place an order in the app.",
              ),

              SizedBox(height: 20),

              Text(
                "2. How We Use Your Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "Your information is used to process orders, provide customer support, "
                    "improve app performance, and offer personalized shopping experiences.",
              ),

              SizedBox(height: 20),

              Text(
                "3. Data Protection",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "We implement appropriate security measures to protect your personal data "
                    "from unauthorized access, alteration, or disclosure.",
              ),

              SizedBox(height: 20),

              Text(
                "4. Sharing of Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "We do not sell or rent your personal information to third parties. "
                    "However, we may share limited information with trusted partners to "
                    "process payments, deliver products, or comply with legal obligations.",
              ),

              SizedBox(height: 20),

              Text(
                "5. Updates to Privacy Policy",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "We may update this Privacy Policy from time to time. "
                    "Any changes will be posted within the application.",
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