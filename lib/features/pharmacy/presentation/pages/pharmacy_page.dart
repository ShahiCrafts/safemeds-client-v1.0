import 'package:flutter/material.dart';

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pharmacy", style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF111827))),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: const Center(
        child: Text("Find nearby pharmacies and check drug availability.", style: TextStyle(color: Color(0xFF6B7280))),
      ),
    );
  }
}
