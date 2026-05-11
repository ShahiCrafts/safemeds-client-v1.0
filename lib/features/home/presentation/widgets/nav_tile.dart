import 'package:flutter/material.dart';

class NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  
  const NavTile({
    super.key,
    required this.icon,
    required this.label,
    required this.active,
  });

  static const Color _brand    = Color(0xFF5271FF);
  static const Color _textMuted = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: active ? _brand : _textMuted),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: active ? FontWeight.w700 : FontWeight.w400,
            color: active ? _brand : _textMuted,
          ),
        ),
      ],
    );
  }
}
