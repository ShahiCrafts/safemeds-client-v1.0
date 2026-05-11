import 'package:flutter/material.dart';
import 'package:safemeds/features/home/data/models/home_models.dart';
import 'package:safemeds/features/home/presentation/widgets/gamification_section.dart';
import 'package:safemeds/features/home/presentation/widgets/health_events_section.dart';
import 'package:safemeds/features/home/presentation/widgets/health_stats_section.dart';
import 'package:safemeds/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:safemeds/features/home/presentation/widgets/home_header.dart';
import 'package:safemeds/features/home/presentation/widgets/reminders_section.dart';
import 'package:safemeds/features/home/presentation/widgets/safety_insights_section.dart';

import 'package:safemeds/features/reminders/presentation/pages/reminders_page.dart';
import 'package:safemeds/features/pharmacy/presentation/pages/pharmacy_page.dart';
import 'package:safemeds/features/profile/presentation/pages/profile_screen.dart';
import 'package:safemeds/features/verification/presentation/pages/verification_page.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;
  bool _isStreakExpanded = false;

  late final List<Widget> _pages;

  final List<ReminderGroup> _reminderGroups = [
    const ReminderGroup(
      timeOfDay: "Morning",
      icon: Icons.wb_sunny_outlined,
      timeRange: "8:00 – 9:00 AM",
      reminders: [
        ReminderData(
          name: "Amoxicillin 500mg",
          dose: "1 capsule · After meal",
          taken: true,
        ),
        ReminderData(
          name: "Vitamin D3 1000IU",
          dose: "1 softgel · With meal",
          taken: false,
        ),
      ],
    ),
    const ReminderGroup(
      timeOfDay: "Afternoon",
      icon: Icons.wb_cloudy_outlined,
      timeRange: "1:00 – 2:00 PM",
      reminders: [
        ReminderData(
          name: "Ibuprofen 400mg",
          dose: "1 tablet · After meal",
          taken: false,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeView(),
      const RemindersPage(),
      const VerificationPage(),
      const PharmacyPage(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _bottomNavIndex,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _pages,
      ),
    );
  }

  Widget _buildHomeView() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            const SizedBox(height: 20),
            GamificationSection(
              isExpanded: _isStreakExpanded,
              onToggle: () => setState(() => _isStreakExpanded = !_isStreakExpanded),
            ),
            const SizedBox(height: 32),
            const HealthStatsSection(),
            const SizedBox(height: 32),
            RemindersSection(groups: _reminderGroups),
            const SizedBox(height: 32),
            const SafetyInsightsSection(),
            const SizedBox(height: 32),
            const HealthEventsSection(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}