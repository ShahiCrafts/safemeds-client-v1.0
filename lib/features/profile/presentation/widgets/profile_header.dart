import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  static const Color _brand      = Color(0xFF2563EB);
  static const Color _brandLight = Color(0xFFEFF6FF);
  static const Color _textDark   = Color(0xFF111827);
  static const Color _textMuted  = Color(0xFF6B7280);
  static const Color _green      = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Premium solid-ring avatar
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer Ring (Solid Brand Color)
            Container(
              width: 112,
              height: 112,
              decoration: const BoxDecoration(
                color: _brand,
                shape: BoxShape.circle,
              ),
            ),
            // Middle Spacer
            Container(
              width: 104,
              height: 104,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            // Inner Avatar Area
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: _brandLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 48,
                color: _brand,
              ),
            ),
            // Floating 'Edit' indicator
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.camera_alt_rounded, size: 16, color: _textDark),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "Saugat Shahi",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: _textDark,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "saugat.shahi@gmail.com",
          style: TextStyle(
            fontSize: 15,
            color: _textMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        // Premium Verification Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFDCFCE7), width: 1),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_rounded, size: 16, color: _green),
              SizedBox(width: 6),
              Text(
                "VERIFIED PATIENT",
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: _green,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
