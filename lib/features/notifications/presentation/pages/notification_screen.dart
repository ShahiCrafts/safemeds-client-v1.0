import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // ── Design tokens (mirrored from home_page.dart) ───────────────────────
  static const Color _brand = Color(0xFF2563EB);
  static const Color _brandLight = Color(0xFFEFF6FF);
  static const Color _card = Color(0xFFF6F6F6);
  static const Color _textDark = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);
  static const Color _green = Color(0xFF10B981);
  static const Color _orange = Color(0xFFFF8000);
  static const Color _red = Color(0xFFFF5640);

  int _selectedTab = 0;
  final List<String> _tabs = ["All", "Reminders", "Safety", "Rewards"];

  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      type: NotifType.alert,
      title: "Counterfeit Alert",
      body: "A batch of Paracetamol 500mg (Lot #BX9201) has been flagged as counterfeit in your area. Check your supply.",
      time: "2 min ago",
      isUnread: true,
    ),
    _NotificationItem(
      type: NotifType.reminder,
      title: "Time for Amoxicillin 500mg",
      body: "Take 1 capsule after your morning meal. Stay on track with your 8-day streak!",
      time: "15 min ago",
      isUnread: true,
    ),
    _NotificationItem(
      type: NotifType.reward,
      title: "Achievement Unlocked! 🏆",
      body: "You earned the \"Health Guardian\" badge for verifying 10 medicines. +50 XP",
      time: "1 hr ago",
      isUnread: true,
    ),
    _NotificationItem(
      type: NotifType.safety,
      title: "Verification Complete",
      body: "Your scan of Metformin 850mg has been authenticated. Medicine is safe to use.",
      time: "2 hrs ago",
      isUnread: false,
    ),
    _NotificationItem(
      type: NotifType.reminder,
      title: "Upcoming: Atorvastatin 20mg",
      body: "Scheduled for tonight at 9:00 PM — 1 tablet before sleep.",
      time: "3 hrs ago",
      isUnread: false,
    ),
    _NotificationItem(
      type: NotifType.reward,
      title: "Weekly Streak Bonus",
      body: "You completed all reminders for 7 days straight! +100 XP and 20 Reward Points added.",
      time: "5 hrs ago",
      isUnread: false,
    ),
    _NotificationItem(
      type: NotifType.safety,
      title: "Medicine Recall Notice",
      body: "Ibuprofen 400mg by PharmaCo (Lot #KL3847) has been recalled. Tap for details.",
      time: "8 hrs ago",
      isUnread: false,
    ),
    _NotificationItem(
      type: NotifType.alert,
      title: "Expiry Warning",
      body: "Your Vitamin D3 1000IU expires in 5 days. Consider getting a refill from a verified pharmacy.",
      time: "1 day ago",
      isUnread: false,
    ),
    _NotificationItem(
      type: NotifType.reminder,
      title: "Missed: Metformin 850mg",
      body: "You missed your afternoon dose yesterday at 1:00 PM. Try to stay consistent.",
      time: "1 day ago",
      isUnread: false,
    ),
    _NotificationItem(
      type: NotifType.reward,
      title: "Blood Donation Event",
      body: "Earn +50 pts by joining the Blood Donation Camp on May 15 at Kathmandu Medical College.",
      time: "2 days ago",
      isUnread: false,
    ),
  ];

  List<_NotificationItem> get _filteredNotifications {
    if (_selectedTab == 0) return _notifications;
    final type = [
      NotifType.reminder,
      NotifType.reminder,
      NotifType.safety,
      NotifType.reward,
    ][_selectedTab];

    if (_selectedTab == 2) {
      return _notifications
          .where((n) => n.type == NotifType.safety || n.type == NotifType.alert)
          .toList();
    }
    return _notifications.where((n) => n.type == type).toList();
  }

  int get _unreadCount => _notifications.where((n) => n.isUnread).length;

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n.isUnread = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            const SizedBox(height: 4),
            _buildTabs(),
            const SizedBox(height: 4),
            Expanded(child: _buildNotificationList()),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: _card,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: _textDark,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              "Notifications",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _textDark,
                letterSpacing: -0.3,
              ),
            ),
          ),
          // Unread count badge
          if (_unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0EF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "$_unreadCount new",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _red,
                ),
              ),
            ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _markAllRead,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: _card,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.done_all_rounded,
                size: 20,
                color: _textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Filter Tabs ─────────────────────────────────────────────────────────

  Widget _buildTabs() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isActive = i == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isActive ? _brand : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isActive ? _brand : const Color(0xFFE5E7EB),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  _tabs[i],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.white : _textMuted,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Notification List ───────────────────────────────────────────────────

  Widget _buildNotificationList() {
    final items = _filteredNotifications;

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: _card,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_off_outlined,
                size: 32,
                color: _textMuted,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "No notifications yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "You're all caught up!",
              style: TextStyle(
                fontSize: 14,
                color: _textMuted,
              ),
            ),
          ],
        ),
      );
    }

    // Group notifications: Today and Earlier
    final todayItems = items.where((n) => _isToday(n.time)).toList();
    final earlierItems = items.where((n) => !_isToday(n.time)).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        if (todayItems.isNotEmpty) ...[
          _buildSectionLabel("Today"),
          const SizedBox(height: 8),
          ...todayItems.map((n) => _buildNotificationCard(n)),
        ],
        if (earlierItems.isNotEmpty) ...[
          const SizedBox(height: 20),
          _buildSectionLabel("Earlier"),
          const SizedBox(height: 8),
          ...earlierItems.map((n) => _buildNotificationCard(n)),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  bool _isToday(String time) {
    return time.contains("min") || time.contains("hr");
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: _textMuted,
        letterSpacing: 0.3,
      ),
    );
  }

  // ── Notification Card ───────────────────────────────────────────────────

  Widget _buildNotificationCard(_NotificationItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: ValueKey(item.hashCode),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0EF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.delete_outline_rounded, color: _red, size: 24),
        ),
        onDismissed: (_) {
          setState(() => _notifications.remove(item));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: item.isUnread ? _brandLight : _card,
            borderRadius: BorderRadius.circular(18),
            border: item.isUnread
                ? Border.all(color: const Color(0xFFBFDBFE), width: 1)
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              _buildNotifIcon(item.type),
              const SizedBox(width: 14),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  item.isUnread ? FontWeight.w700 : FontWeight.w600,
                              color: _textDark,
                              letterSpacing: -0.1,
                            ),
                          ),
                        ),
                        if (item.isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: _brand,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.body,
                      style: const TextStyle(
                        fontSize: 14,
                        color: _textMuted,
                        height: 1.45,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 13,
                          color: Color(0xFFD1D5DB),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.time,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFFD1D5DB),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        _buildActionChip(item.type),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotifIcon(NotifType type) {
    IconData icon;
    Color color;
    Color bg;

    switch (type) {
      case NotifType.reminder:
        icon = Icons.medication_rounded;
        color = _brand;
        bg = _brandLight;
        break;
      case NotifType.alert:
        icon = Icons.warning_amber_rounded;
        color = _red;
        bg = const Color(0xFFFFF0EF);
        break;
      case NotifType.safety:
        icon = Icons.shield_rounded;
        color = _green;
        bg = const Color(0xFFEDF7F2);
        break;
      case NotifType.reward:
        icon = Icons.emoji_events_rounded;
        color = _orange;
        bg = const Color(0xFFFFF8EC);
        break;
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, size: 22, color: color),
    );
  }

  Widget _buildActionChip(NotifType type) {
    String label;
    Color color;
    Color bg;

    switch (type) {
      case NotifType.reminder:
        label = "Take Now";
        color = _brand;
        bg = _brandLight;
        break;
      case NotifType.alert:
        label = "View Details";
        color = _red;
        bg = const Color(0xFFFFF0EF);
        break;
      case NotifType.safety:
        label = "View Report";
        color = _green;
        bg = const Color(0xFFEDF7F2);
        break;
      case NotifType.reward:
        label = "Claim";
        color = _orange;
        bg = const Color(0xFFFFF8EC);
        break;
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}

// ── Data Models ───────────────────────────────────────────────────────────

enum NotifType { reminder, alert, safety, reward }

class _NotificationItem {
  final NotifType type;
  final String title;
  final String body;
  final String time;
  bool isUnread;

  _NotificationItem({
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    required this.isUnread,
  });
}
