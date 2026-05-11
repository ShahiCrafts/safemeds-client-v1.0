import 'package:flutter/material.dart';
import 'nav_tile.dart';
import '../../data/models/home_models.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color _brand = Color(0xFF5271FF);

  @override
  Widget build(BuildContext context) {
    final leftItems = [
      const NavItem(icon: Icons.home_rounded, label: "Home"),
      const NavItem(icon: Icons.calendar_month_rounded, label: "Reminders"),
    ];
    final rightItems = [
      const NavItem(icon: Icons.local_pharmacy_rounded, label: "Pharmacy"),
      const NavItem(icon: Icons.person_rounded, label: "Profile"),
    ];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFEEEFF2), width: 1)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 62,
              child: Row(
                children: [
                  ...leftItems.asMap().entries.map((e) {
                    final active = e.key == currentIndex;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTap(e.key),
                        child: NavTile(
                          icon: e.value.icon,
                          label: e.value.label,
                          active: active,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 68),
                  ...rightItems.asMap().entries.map((e) {
                    final idx = e.key + 3;
                    final active = idx == currentIndex;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTap(idx),
                        child: NavTile(
                          icon: e.value.icon,
                          label: e.value.label,
                          active: active,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -32,
          child: GestureDetector(
            onTap: () => onTap(2),
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: _brand,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
