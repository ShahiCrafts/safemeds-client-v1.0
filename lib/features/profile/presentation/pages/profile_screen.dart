import 'package:flutter/material.dart';
import 'package:safemeds/features/profile/presentation/widgets/profile_header.dart';
import 'package:safemeds/features/profile/presentation/widgets/health_profile_hub.dart';
import 'package:safemeds/features/profile/presentation/widgets/settings_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _textDark = Color(0xFF111827);
  static const Color _card     = Color(0xFFF6F6F6);

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
              const ProfileHeader(),
              const SizedBox(height: 32),
              const HealthProfileHub(),
              const SizedBox(height: 32),
              const SettingsSection(
                title: "Settings",
                tiles: [
                  SettingsTile(
                    icon: Icons.notifications_none_rounded,
                    iconColor: Color(0xFF2563EB),
                    iconBg: Color(0xFFEFF6FF),
                    title: "Notifications",
                    subtitle: "Daily reminders & alerts",
                    showToggle: true,
                  ),
                  SettingsTile(
                    icon: Icons.lock_outline_rounded,
                    iconColor: Color(0xFF8B5CF6),
                    iconBg: Color(0xFFF5F3FF),
                    title: "Privacy & Security",
                    subtitle: "Manage your medical data",
                  ),
                  SettingsTile(
                    icon: Icons.language_rounded,
                    iconColor: Color(0xFF10B981),
                    iconBg: Color(0xFFECFDF5),
                    title: "Language",
                    subtitle: "English (US)",
                    showDivider: false,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const SettingsSection(
                title: "Support",
                tiles: [
                  SettingsTile(
                    icon: Icons.help_outline_rounded,
                    iconColor: Color(0xFF2563EB),
                    iconBg: Color(0xFFEFF6FF),
                    title: "Help Center",
                    subtitle: "FAQs & troubleshooting",
                  ),
                  SettingsTile(
                    icon: Icons.chat_bubble_outline_rounded,
                    iconColor: Color(0xFF10B981),
                    iconBg: Color(0xFFECFDF5),
                    title: "Contact Us",
                    subtitle: "Talk to our medical team",
                    showDivider: false,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildLogoutButton(),
              const SizedBox(height: 16),
              const Text(
                "SafeMeds v1.0.0 · Made with ❤️",
                style: TextStyle(fontSize: 13, color: Color(0xFFD1D5DB), fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              decoration: const BoxDecoration(color: _card, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_rounded, size: 20, color: _textDark),
            ),
          ),
          const Spacer(),
          const Text(
            "My Profile",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark, letterSpacing: -0.5),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/edit-profile'),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(color: _card, shape: BoxShape.circle),
              child: const Icon(Icons.edit_rounded, size: 20, color: _textDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0EF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFFFD7D5), width: 1),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, size: 20, color: Color(0xFFFF5640)),
              SizedBox(width: 10),
              Text(
                "Sign Out",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFFF5640)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
