import 'package:flutter/material.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Verify Medicine", style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF111827))),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: const Center(
        child: Text("Scan or enter batch number to verify your medicine.", style: TextStyle(color: Color(0xFF6B7280))),
      ),
    );
  }
}
