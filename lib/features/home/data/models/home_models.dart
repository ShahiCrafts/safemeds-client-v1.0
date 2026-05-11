import 'package:flutter/material.dart';

class ReminderGroup {
  final String timeOfDay, timeRange;
  final IconData icon;
  final List<ReminderData> reminders;
  const ReminderGroup({
    required this.timeOfDay,
    required this.timeRange,
    required this.icon,
    required this.reminders,
  });
}

class ReminderData {
  final String name, dose;
  final bool taken;
  const ReminderData({
    required this.name,
    required this.dose,
    required this.taken,
  });
}

class EventData {
  final IconData icon;
  final String title, subtitle, points;
  final Color iconBg, iconColor;
  const EventData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.iconBg,
    required this.iconColor,
  });
}

class NavItem {
  final IconData icon;
  final String label;
  const NavItem({required this.icon, required this.label});
}
