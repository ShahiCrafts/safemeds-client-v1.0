import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;

  static const Color _brand      = Color(0xFF2563EB); // blue (was 0xFF5271FF purple)
  static const Color _brandLight = Color(0xFFEFF6FF); // blue-50 (was 0xFFF0F2FF)
  static const Color _brandSoft  = Color(0xFFDBEAFE); // blue-100 (new, for stack shadows)
  static const Color _red        = Color(0xFFE8352A);
  static const Color _card       = Color(0xFFF6F6F6);
  static const Color _textDark   = Color(0xFF111827);
  static const Color _textMuted  = Color(0xFF6B7280);



  final List<_ReminderGroup> _reminderGroups = [
    _ReminderGroup(
      timeOfDay: "Morning",
      icon: Icons.wb_sunny_outlined,
      timeRange: "8:00 – 9:00 AM",
      reminders: [
        _ReminderData(
          name: "Amoxicillin 500mg",
          dose: "1 capsule · After meal",
          taken: true,
        ),
        _ReminderData(
          name: "Vitamin D3 1000IU",
          dose: "1 softgel · With meal",
          taken: false,
        ),
      ],
    ),
    _ReminderGroup(
      timeOfDay: "Afternoon",
      icon: Icons.light_mode_outlined,
      timeRange: "1:00 – 2:00 PM",
      reminders: [
        _ReminderData(
          name: "Metformin 850mg",
          dose: "1 tablet · With food",
          taken: false,
        ),
      ],
    ),
    _ReminderGroup(
      timeOfDay: "Night",
      icon: Icons.nightlight_outlined,
      timeRange: "9:00 – 10:00 PM",
      reminders: [
        _ReminderData(
          name: "Atorvastatin 20mg",
          dose: "1 tablet · Before sleep",
          taken: false,
        ),
      ],
    ),
  ];

  List<_ReminderData> get _allReminders =>
      _reminderGroups.expand((g) => g.reminders).toList();

  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildGamificationSection(),
              const SizedBox(height: 32),
              _buildHealthStatsRow(),
              const SizedBox(height: 32),
              _buildRemindersSection(),
              const SizedBox(height: 32),
              _buildMedicationOverview(),
              const SizedBox(height: 32),
              _buildHealthEvents(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _brandLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_rounded, color: _brand, size: 24),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good morning",
                style: TextStyle(fontSize: 16, color: _textMuted),
              ),
              Text(
                "Saugat Shahi",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const Spacer(),
          _HeaderBtn(icon: Icons.search_rounded),
          const SizedBox(width: 8),
          Stack(
            children: [
              _HeaderBtn(icon: Icons.notifications_none_rounded),
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: _red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "6",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Banner carousel ───────────────────────────────────────────────────────



  // ── Today's Reminders ─────────────────────────────────────────────────────
  // CHANGED: single stacked card replaces featured card + peeks + group rows.

  Widget _buildRemindersSection() {
    final allReminders = _allReminders;
    final takenCount = allReminders.where((r) => r.taken).length;
    final pending = allReminders.where((r) => !r.taken).toList();
    final takenList = allReminders.where((r) => r.taken).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 8),
                 
                ],
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
          const SizedBox(height: 6),

          // Stacked card for pending reminders
          if (pending.isNotEmpty) _buildStackedMedicineCard(pending),

          
        ],
      ),
    );
  }

  Widget _buildStackedMedicineCard(List<_ReminderData> pending) {
    final featured = pending.first;
    final extraCount = pending.length - 1;

    // Find which group the featured reminder belongs to
    String timeLabel = '';
    IconData timeIcon = Icons.schedule_rounded;
    for (final g in _reminderGroups) {
      if (g.reminders.contains(featured)) {
        timeLabel = '${g.timeOfDay} · ${g.timeRange}';
        timeIcon = g.icon;
        break;
      }
    }

    return Column(
      children: [
        SizedBox(
          height: extraCount >= 2 ? 108 : extraCount == 1 ? 100 : 84,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // Back shadow card (card 3)
              if (extraCount >= 2)
                Positioned(
                  top: 0,
                  left: 14,
                  right: 14,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBFD4FD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              // Middle shadow card (card 2)
              if (extraCount >= 1)
                Positioned(
                  top: extraCount >= 2 ? 7 : 0,
                  left: 7,
                  right: 7,
                  child: Container(
                    height: 82,
                    decoration: BoxDecoration(
                      color: _brandSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              // Front card
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 16),
                  decoration: BoxDecoration(
                    color: _card,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // Icon circle
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
                      // Name + dose + time
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
                              style: const TextStyle(
                                  fontSize: 15.5, color: _textMuted),
                            ),
                            const SizedBox(height: 7),
                            Row(
                              children: [
                                Icon(timeIcon, size: 12, color: _textMuted),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    timeLabel,
                                    style: const TextStyle(
                                        fontSize: 14.5, color: _textMuted),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Arrow button
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
        // "X more pending" pill
          
      ],
    );
  }

  Widget _buildReminderRow(_ReminderData r) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: r.taken ? const Color(0xFFE8E8E8) : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medication_rounded,
              size: 20,
              color: r.taken ? const Color(0xFFB0B7C3) : _brand,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.name,
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w600,
                    color: r.taken ? _textMuted : _textDark,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  r.dose,
                  style: const TextStyle(fontSize: 15, color: _textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: r.taken ? const Color(0xFFE0E0E0) : _brand,
              shape: BoxShape.circle,
            ),
            child: Icon(
              r.taken ? Icons.check_rounded : Icons.arrow_forward_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ── Gamification ──────────────────────────────────────────────────────────

  Widget _buildGamificationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Redesigned Streak & XP Dashboard
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
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
                            color: Color(0xFF10B981),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayNode(String day, bool isDone, bool isToday) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isDone ? const Color(0xFF10B981) : Colors.transparent,
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

  // ── Health Stats ──────────────────────────────────────────────────────────

  Widget _buildHealthStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.shield_outlined,
                  iconBg: _brandLight,
                  iconColor: const Color(0xFF3B82F6), // Vibrant Blue
                  label: "Verified Meds",
                  value: "12",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.emoji_events_outlined,
                  iconBg: const Color(0xFFFFF8EC),
                  iconColor: const Color(0xFFFF8000), // Vibrant Orange (as suggested)
                  label: "Reward Points",
                  value: "340 pts",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.bloodtype_outlined,
                  iconBg: const Color(0xFFFFF0EF),
                  iconColor: const Color(0xFFFF5640), // Vibrant Red-Orange (as suggested)
                  label: "Blood Type",
                  value: "B+",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.local_hospital_outlined,
                  iconBg: const Color(0xFFEDF7F2),
                  iconColor: const Color(0xFF10B981), // Vibrant Green
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

  // ── Counterfeit Alerts ────────────────────────────────────────────────────

  Widget _buildMedicationOverview() {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Safety Insights",
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
          _buildRiskChart(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildRiskChart() {
    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 104, // Exact diameter (centerSpaceRadius 36 + radius 16) * 2
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 36,
                        startDegreeOffset: -90,
                        sections: [
                          PieChartSectionData(
                            color: const Color(0xFFFF5640),
                            value: 15,
                            title: '',
                            radius: 16,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFFF8000),
                            value: 25,
                            title: '',
                            radius: 16,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFF10B981),
                            value: 60,
                            title: '',
                            radius: 16,
                          ),
                        ],
                      ),
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "92%",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                          ),
                        ),
                        Text(
                          "Safe",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildChartLegend(const Color(0xFF10B981), "Authenticated", "92%"),
                const SizedBox(height: 12),
                _buildChartLegend(const Color(0xFFFF8000), "Under Review", "5%"),
                const SizedBox(height: 12),
                _buildChartLegend(const Color(0xFFFF5640), "Risk Flagged", "3%"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(Color color, String label, String count) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 17, // Increased (14 + 3)
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            fontSize: 17, // Increased (14 + 3)
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }

  // ── Health Events ─────────────────────────────────────────────────────────

  Widget _buildHealthEvents() {
    final events = [
      _EventData(
        icon: Icons.favorite_rounded,
        title: "Blood Donation Camp",
        subtitle: "May 15 · Kathmandu Medical College",
        points: "+50 pts",
        iconBg: const Color(0xFFFFF0EF),
        iconColor: const Color(0xFFD94035),
      ),
      _EventData(
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
          ...events.map(
            (e) => Padding(
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
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
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom nav ────────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    final leftItems = [
      _NavItem(icon: Icons.home_rounded, label: "Home"),
      _NavItem(icon: Icons.calendar_month_rounded, label: "Reminders"),
    ];
    final rightItems = [
      _NavItem(icon: Icons.local_pharmacy_rounded, label: "Pharmacy"),
      _NavItem(icon: Icons.person_rounded, label: "Profile"),
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
                    final active = e.key == _bottomNavIndex;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _bottomNavIndex = e.key),
                        child: _NavTile(
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
                    final active = idx == _bottomNavIndex;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _bottomNavIndex = idx),
                        child: _NavTile(
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
          top: -26,
          child: GestureDetector(
            onTap: () => setState(() => _bottomNavIndex = 2),
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: _brand,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Reusable widgets ──────────────────────────────────────────────────────

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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg, iconColor;
  final String label, value;
  const _StatCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const _NavTile({
    required this.icon,
    required this.label,
    required this.active,
  });

  static const Color _brand    = Color(0xFF2563EB);
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

// ── Data models ───────────────────────────────────────────────────────────

class _ReminderGroup {
  final String timeOfDay, timeRange;
  final IconData icon;
  final List<_ReminderData> reminders;
  const _ReminderGroup({
    required this.timeOfDay,
    required this.timeRange,
    required this.icon,
    required this.reminders,
  });
}

class _ReminderData {
  final String name, dose;
  final bool taken;
  const _ReminderData({
    required this.name,
    required this.dose,
    required this.taken,
  });
}



class _EventData {
  final IconData icon;
  final String title, subtitle, points;
  final Color iconBg, iconColor;
  const _EventData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.iconBg,
    required this.iconColor,
  });
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}