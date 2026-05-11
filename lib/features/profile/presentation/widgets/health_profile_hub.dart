import 'package:flutter/material.dart';

class HealthProfileHub extends StatelessWidget {
  const HealthProfileHub({super.key});

  static const Color _textDark  = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);
  static const Color _card      = Color(0xFFF6F6F6);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Health Profile",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _textDark,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              _buildMetricCard(Icons.bloodtype_rounded, "Blood", "B+", const Color(0xFFFF5640)),
              _buildMetricCard(Icons.monitor_weight_rounded, "Weight", "68 kg", const Color(0xFF2563EB)),
              _buildMetricCard(Icons.height_rounded, "Height", "5'9\"", const Color(0xFF8B5CF6)),
              _buildMetricCard(Icons.cake_rounded, "Age", "24 yrs", const Color(0xFFFF8000)),
            ],
          ),
          const SizedBox(height: 12),
          // Large Allergy Warning Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0EF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFD7D5), width: 1),
            ),
            child: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Color(0xFFFF5640), size: 24),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Allergies",
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Penicillin, Peanuts",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _textDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: _textMuted, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: _textDark, letterSpacing: -0.4),
          ),
        ],
      ),
    );
  }
}
