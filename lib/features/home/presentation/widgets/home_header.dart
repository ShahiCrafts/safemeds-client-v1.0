import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  static const Color _textDark  = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);
  static const Color _card      = Color(0xFFF6F6F6);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning,",
                style: TextStyle(fontSize: 15, color: _textMuted, fontWeight: FontWeight.w500),
              ),
              Text(
                "Saugat Shahi 👋",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          const _HeaderBtn(icon: Icons.search_rounded),
          const SizedBox(width: 10),
          const _HeaderBtn(icon: Icons.notifications_none_rounded),
        ],
      ),
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  final IconData icon;
  const _HeaderBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFFF6F6F6),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF111827)),
    );
  }
}
