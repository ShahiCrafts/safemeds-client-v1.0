import 'package:flutter/material.dart';
import '../../data/models/home_models.dart';

class RemindersSection extends StatelessWidget {
  final List<ReminderGroup> groups;

  const RemindersSection({super.key, required this.groups});

  static const Color _brand      = Color(0xFF5271FF);
  static const Color _brandSoft  = Color(0xFFE0E7FF);
  static const Color _card       = Color(0xFFF6F6F6);
  static const Color _textDark   = Color(0xFF111827);
  static const Color _textMuted  = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    // Flatten all reminders to find pending ones
    final allReminders = groups.expand((g) => g.reminders).toList();
    final pending = allReminders.where((r) => !r.taken).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              const Text(
                "Today's Reminders",
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
          const SizedBox(height: 16),

          // Stacked Card for pending reminders
          if (pending.isNotEmpty) 
            _buildStackedMedicineCard(pending)
          else
            _buildEmptyState(),
        ],
      ),
    );
  }

  Widget _buildStackedMedicineCard(List<ReminderData> pending) {
    final featured = pending.first;
    final extraCount = pending.length - 1;

    // Find which group the featured reminder belongs to for the time label
    String timeLabel = '';
    IconData timeIcon = Icons.schedule_rounded;
    for (final g in groups) {
      if (g.reminders.contains(featured)) {
        timeLabel = '${g.timeOfDay} · ${g.timeRange}';
        timeIcon = g.icon;
        break;
      }
    }

    return Column(
      children: [
        SizedBox(
          height: extraCount >= 2 ? 112 : extraCount == 1 ? 104 : 88,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // Back shadow card (Layer 3)
              if (extraCount >= 2)
                Positioned(
                  top: 0,
                  left: 14,
                  right: 14,
                  child: Container(
                    height: 84,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD0D7FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              // Middle shadow card (Layer 2)
              if (extraCount >= 1)
                Positioned(
                  top: extraCount >= 2 ? 8 : 0,
                  left: 7,
                  right: 7,
                  child: Container(
                    height: 86,
                    decoration: BoxDecoration(
                      color: _brandSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              // Front card (Layer 1)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  decoration: BoxDecoration(
                    color: _card,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // Medication Icon Circle
                      Container(
                        width: 52,
                        height: 52,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.medication_rounded,
                          size: 26,
                          color: _brand,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Info: Name + Dose + Time
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              featured.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: _textDark,
                                letterSpacing: -0.2,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              featured.dose,
                              style: const TextStyle(fontSize: 15.5, color: _textMuted),
                            ),
                            const SizedBox(height: 7),
                            Row(
                              children: [
                                Icon(timeIcon, size: 12, color: _textMuted),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    timeLabel,
                                    style: const TextStyle(fontSize: 14.5, color: _textMuted),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Action Button
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: _brand,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(Icons.check_circle_outline_rounded, size: 32, color: Color(0xFF10B981)),
          SizedBox(height: 12),
          Text(
            "All caught up!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _textDark),
          ),
          SizedBox(height: 2),
          Text(
            "You've taken all your meds for today.",
            style: TextStyle(fontSize: 14, color: _textMuted),
          ),
        ],
      ),
    );
  }
}
