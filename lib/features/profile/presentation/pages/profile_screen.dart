import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ── Design tokens (mirrored from home_page.dart) ───────────────────────
  static const Color _brand = Color(0xFF2563EB);
  static const Color _brandLight = Color(0xFFEFF6FF);
  static const Color _card = Color(0xFFF6F6F6);
  static const Color _textDark = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);
  static const Color _green = Color(0xFF10B981);
  static const Color _orange = Color(0xFFFF8000);
  static const Color _red = Color(0xFFFF5640);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              _buildAppBar(),
              const SizedBox(height: 8),
              _buildProfileHeader(),
              const SizedBox(height: 28),
              _buildStatsRow(),
              const SizedBox(height: 28),
              _buildHealthInfoCard(),
              const SizedBox(height: 20),
              _buildAchievementsBanner(),
              const SizedBox(height: 28),
              _buildSettingsSection(),
              const SizedBox(height: 20),
              _buildSupportSection(),
              const SizedBox(height: 28),
              _buildLogoutButton(),
              const SizedBox(height: 12),
              _buildVersionInfo(),
            ],
          ),
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
              child:
                  const Icon(Icons.arrow_back_rounded, size: 20, color: _textDark),
            ),
          ),
          const Spacer(),
          const Text(
            "My Profile",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _textDark,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: _card,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit_rounded, size: 18, color: _textDark),
            ),
          ),
        ],
      ),
    );
  }

  // ── Profile Header ──────────────────────────────────────────────────────

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Avatar with gradient ring
        Container(
          width: 104,
          height: 104,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                _brand,
                Color(0xFF60A5FA),
                _green,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: const BoxDecoration(
                    color: _brandLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 44,
                    color: _brand,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Name
        const Text(
          "Saugat Shahi",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: _textDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        // Email
        const Text(
          "saugat.shahi@gmail.com",
          style: TextStyle(
            fontSize: 15,
            color: _textMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 12),
        // Verified badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEDF7F2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_rounded, size: 16, color: _green),
              SizedBox(width: 6),
              Text(
                "Verified Patient",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _green,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Stats Row ───────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
        ),
        child: Row(
          children: [
            _buildStatItem("12", "Verified\nMeds", _brand),
            _buildStatDivider(),
            _buildStatItem("8", "Day\nStreak", _red),
            _buildStatDivider(),
            _buildStatItem("1,240", "Health\nXP", _green),
            _buildStatDivider(),
            _buildStatItem("340", "Reward\nPts", _orange),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: _textMuted,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 40,
      color: const Color(0xFFE5E7EB),
    );
  }

  // ── Health Info Card ────────────────────────────────────────────────────

  Widget _buildHealthInfoCard() {
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
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
            ),
            child: Column(
              children: [
                _buildHealthRow(
                  Icons.bloodtype_rounded,
                  const Color(0xFFFF5640),
                  const Color(0xFFFFF0EF),
                  "Blood Type",
                  "B+",
                ),
                const SizedBox(height: 14),
                _buildHealthRow(
                  Icons.monitor_weight_rounded,
                  _brand,
                  _brandLight,
                  "Weight",
                  "68 kg",
                ),
                const SizedBox(height: 14),
                _buildHealthRow(
                  Icons.height_rounded,
                  const Color(0xFF8B5CF6),
                  const Color(0xFFF5F3FF),
                  "Height",
                  "5'9\"",
                ),
                const SizedBox(height: 14),
                _buildHealthRow(
                  Icons.cake_rounded,
                  _orange,
                  const Color(0xFFFFF8EC),
                  "Age",
                  "24 yrs",
                ),
                const SizedBox(height: 14),
                _buildHealthRow(
                  Icons.warning_amber_rounded,
                  _red,
                  const Color(0xFFFFF0EF),
                  "Allergies",
                  "Penicillin",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthRow(
    IconData icon,
    Color iconColor,
    Color iconBg,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: _textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _textDark,
          ),
        ),
      ],
    );
  }

  // ── Achievements Banner ─────────────────────────────────────────────────

  Widget _buildAchievementsBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                size: 28,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Health Guardian",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Level 3 · 760 XP to next level",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "View",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _brand,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Settings Section ────────────────────────────────────────────────────

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Settings",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _textDark,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
            ),
            child: Column(
              children: [
                _buildSettingsTile(
                  Icons.notifications_none_rounded,
                  _brand,
                  _brandLight,
                  "Notifications",
                  "Manage alerts & reminders",
                  showToggle: true,
                ),
                _buildSettingsDivider(),
                _buildSettingsTile(
                  Icons.lock_outline_rounded,
                  const Color(0xFF8B5CF6),
                  const Color(0xFFF5F3FF),
                  "Privacy & Security",
                  "Password, 2FA, data",
                ),
                _buildSettingsDivider(),
                _buildSettingsTile(
                  Icons.language_rounded,
                  _green,
                  const Color(0xFFEDF7F2),
                  "Language",
                  "English (US)",
                ),
                _buildSettingsDivider(),
                _buildSettingsTile(
                  Icons.dark_mode_outlined,
                  _orange,
                  const Color(0xFFFFF8EC),
                  "Appearance",
                  "Light mode",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    IconData icon,
    Color iconColor,
    Color iconBg,
    String title,
    String subtitle, {
    bool showToggle = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: _textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (showToggle)
            SizedBox(
              height: 28,
              child: Switch(
                value: true,
                onChanged: (v) {},
                activeColor: _brand,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            )
          else
            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: Color(0xFFD1D5DB),
            ),
        ],
      ),
    );
  }

  Widget _buildSettingsDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: Color(0xFFF3F4F6)),
    );
  }

  // ── Support Section ─────────────────────────────────────────────────────

  Widget _buildSupportSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Support",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _textDark,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
            ),
            child: Column(
              children: [
                _buildSettingsTile(
                  Icons.help_outline_rounded,
                  _brand,
                  _brandLight,
                  "Help Center",
                  "FAQs & troubleshooting",
                ),
                _buildSettingsDivider(),
                _buildSettingsTile(
                  Icons.chat_bubble_outline_rounded,
                  _green,
                  const Color(0xFFEDF7F2),
                  "Contact Us",
                  "Chat or email support",
                ),
                _buildSettingsDivider(),
                _buildSettingsTile(
                  Icons.star_outline_rounded,
                  _orange,
                  const Color(0xFFFFF8EC),
                  "Rate SafeMeds",
                  "Share your experience",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Logout Button ───────────────────────────────────────────────────────

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "Sign Out",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
              content: const Text(
                "Are you sure you want to sign out of your account?",
                style: TextStyle(color: _textMuted, fontSize: 15),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: _textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      color: _red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0EF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFFFD7D5),
              width: 1,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, size: 20, color: _red),
              SizedBox(width: 10),
              Text(
                "Sign Out",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Version Info ────────────────────────────────────────────────────────

  Widget _buildVersionInfo() {
    return const Column(
      children: [
        Text(
          "SafeMeds v1.0.0",
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFFD1D5DB),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2),
        Text(
          "Made with ❤️ in Nepal",
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFD1D5DB),
          ),
        ),
      ],
    );
  }
}

