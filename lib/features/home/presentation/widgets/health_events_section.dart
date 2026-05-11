import 'package:flutter/material.dart';
import '../../data/models/home_models.dart';

class HealthEventsSection extends StatelessWidget {
  const HealthEventsSection({super.key});

  static const Color _brand      = Color(0xFF2563EB);
  static const Color _brandLight = Color(0xFFEFF6FF);
  static const Color _card       = Color(0xFFF6F6F6);
  static const Color _textDark   = Color(0xFF111827);
  static const Color _textMuted  = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    final events = [
      const EventData(
        icon: Icons.favorite_rounded,
        title: "Blood Donation Camp",
        subtitle: "May 15 · Kathmandu Medical College",
        points: "+50 pts",
        iconBg: Color(0xFFFFF0EF),
        iconColor: Color(0xFFD94035),
      ),
      const EventData(
        icon: Icons.self_improvement_rounded,
        title: "Meditation Session",
        subtitle: "May 18 · City Park, Pokhara",
        points: "+20 pts",
        iconBg: _brandLight,
        iconColor: _brand,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Health Events",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "See all",
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w600,
                    color: _brand,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...events.map((e) => _buildEventCard(e)),
        ],
      ),
    );
  }

  Widget _buildEventCard(EventData e) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: e.iconBg,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(e.icon, color: e.iconColor, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.title,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    e.subtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      color: _textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8EC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    e.points,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFB76E00),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _brandLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Join",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _brand,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
