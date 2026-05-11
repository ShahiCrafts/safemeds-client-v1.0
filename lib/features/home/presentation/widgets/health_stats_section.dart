import 'package:flutter/material.dart';
import 'stat_card.dart';

class HealthStatsSection extends StatelessWidget {
  const HealthStatsSection({super.key});

  static const Color _brandLight = Color(0xFFEFF6FF);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: StatCard(
                  icon: Icons.shield_outlined,
                  iconBg: _brandLight,
                  iconColor: Color(0xFF3B82F6),
                  label: "Verified Meds",
                  value: "12",
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StatCard(
                  icon: Icons.emoji_events_outlined,
                  iconBg: Color(0xFFFFF8EC),
                  iconColor: Color(0xFFFF8000),
                  label: "Reward Points",
                  value: "340 pts",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: StatCard(
                  icon: Icons.bloodtype_outlined,
                  iconBg: Color(0xFFFFF0EF),
                  iconColor: Color(0xFFFF5640),
                  label: "Blood Type",
                  value: "B+",
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StatCard(
                  icon: Icons.local_hospital_outlined,
                  iconBg: Color(0xFFEDF7F2),
                  iconColor: Color(0xFF10B981),
                  label: "Ambulance",
                  value: "3 nearby",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
