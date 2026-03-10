import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 80,
                  color: Color(0xFF8B2A9B),
                ),
              ),

              const SizedBox(height: 16),

              const Center(
                child: Text(
                  "Glamorous",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "About Our App",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Glamorous is an online shopping platform designed to provide "
                    "a smooth and convenient shopping experience. Our goal is to "
                    "bring the latest fashion and lifestyle products directly to "
                    "your doorstep with secure payments and fast delivery.",
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 20),

              const Text(
                "Our Mission",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Our mission is to make online shopping easy, reliable, and "
                    "accessible for everyone. We focus on quality products, "
                    "excellent customer service, and a user-friendly mobile app.",
              ),

              const SizedBox(height: 20),

              const Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const ListTile(
                leading: Icon(Icons.email, color: Color(0xFF8B2A9B)),
                title: Text("support@glamorous.com"),
              ),

              const ListTile(
                leading: Icon(Icons.phone, color: Color(0xFF8B2A9B)),
                title: Text("+91 9876543210"),
              ),

              const ListTile(
                leading: Icon(Icons.location_on, color: Color(0xFF8B2A9B)),
                title: Text("India"),
              ),

              const SizedBox(height: 30),

              const Center(
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