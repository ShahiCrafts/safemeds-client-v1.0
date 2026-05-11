import 'package:flutter/material.dart';

class GamificationSection extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const GamificationSection({
    super.key,
    required this.isExpanded,
    required this.onToggle,
  });

  static const Color _brand      = Color(0xFF2563EB);
  static const Color _card       = Color(0xFFF6F6F6);
  static const Color _textDark   = Color(0xFF111827);
  static const Color _textMuted  = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Large Fire Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5640),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "8 Day Streak",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        Text(
                          "Personal best is 14 days!",
                          style: TextStyle(fontSize: 14, color: _textMuted),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // XP Badge
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "1,240",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF5271FF),
                          ),
                        ),
                        Text(
                          "HEALTH XP",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _textMuted,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // 7-Day History Strip
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDayNode("S", true, false),
                    _buildDayNode("M", true, false),
                    _buildDayNode("T", true, false),
                    _buildDayNode("W", true, true), // Current Day
                    _buildDayNode("T", false, false),
                    _buildDayNode("F", false, false),
                    _buildDayNode("S", false, false),
                  ],
                ),

                // Expanded Content
                if (isExpanded) ...[
                  const SizedBox(height: 20),
                  Container(
                    height: 1.2,
                    color: const Color(0xFFE5E7EB),
                  ),
                  const SizedBox(height: 20),
                  _buildMilestoneRow(Icons.verified_user_rounded, "Total Scans", "142 Batches"),
                  const SizedBox(height: 16),
                  _buildMilestoneRow(Icons.emoji_events_rounded, "Current Level", "Master (Lvl 4)"),
                  const SizedBox(height: 16),
                  _buildMilestoneRow(Icons.calendar_today_rounded, "Joined Date", "March 2024"),
                  const SizedBox(height: 6),
                ],
              ],
            ),
          ),
          // Docked Toggle Handle
          Positioned(
            bottom: -22,
            child: GestureDetector(
              onTap: onToggle,
              child: Container(
                width: 48,
                height: 32,
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: Icon(
                  isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: _textMuted,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: _brand),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: _textMuted, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _textDark),
        ),
      ],
    );
  }

  Widget _buildDayNode(String day, bool isDone, bool isToday) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isDone ? const Color(0xFF5271FF) : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: isToday ? _brand : (isDone ? Colors.transparent : const Color(0xFFE5E7EB)),
              width: isToday ? 2 : 1.5,
            ),
          ),
          child: Center(
            child: isDone
                ? const Icon(Icons.check, size: 18, color: Colors.white)
                : Text(
                    day,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isToday ? _brand : _textMuted,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
