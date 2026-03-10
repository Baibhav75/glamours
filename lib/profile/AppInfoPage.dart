import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Info"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 20),

            /// App Icon
            const Icon(
              Icons.shopping_bag,
              size: 80,
              color: Color(0xFF8B2A9B),
            ),

            const SizedBox(height: 10),

            /// App Name
            const Text(
              "Glamorous",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            /// Version
            const Text(
              "Version 1.0.0",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// Description
            const Text(
              "Glamorous is an online shopping application designed "
                  "to provide a smooth and secure shopping experience. "
                  "Browse products, add items to your cart, apply offers, "
                  "and make secure payments easily.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 30),

            const Divider(),

            /// Developer Info
            const ListTile(
              leading: Icon(Icons.person, color: Color(0xFF8B2A9B)),
              title: Text("Developer"),
              subtitle: Text("Shivam Duba"),
            ),

            const ListTile(
              leading: Icon(Icons.email, color: Color(0xFF8B2A9B)),
              title: Text("Email"),
              subtitle: Text("support@glamorous.com"),
            ),

            const ListTile(
              leading: Icon(Icons.language, color: Color(0xFF8B2A9B)),
              title: Text("Website"),
              subtitle: Text("www.glamorous.com"),
            ),

            const Spacer(),

            /// Copyright
            const Text(
              "© 2026 Glamorous. All rights reserved.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}