import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // ── Design Tokens ────────────────────────────────────────────────────────
  static const Color _brand      = Color(0xFF2563EB);
  static const Color _card       = Color(0xFFF6F6F6);
  static const Color _textDark   = Color(0xFF111827);
  static const Color _textMuted  = Color(0xFF6B7280);

  // ── Controllers ──────────────────────────────────────────────────────────
  final _nameController = TextEditingController(text: "Saugat Shahi");
  final _weightController = TextEditingController(text: "68");
  final _heightController = TextEditingController(text: "5'9\"");
  final _ageController = TextEditingController(text: "24");
  final _allergiesController = TextEditingController(text: "Penicillin, Peanuts");
  
  String _selectedBloodGroup = "B+";
  final List<String> _bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Personal Information"),
            const SizedBox(height: 16),
            _buildInputField("Full Name", _nameController, Icons.person_outline_rounded),
            
            const SizedBox(height: 32),
            _buildSectionHeader("Health Profile"),
            const SizedBox(height: 16),
            
            // Blood Group & Age Row
            Row(
              children: [
                Expanded(child: _buildBloodGroupDropdown()),
                const SizedBox(width: 16),
                Expanded(child: _buildInputField("Age", _ageController, Icons.cake_outlined, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 16),
            
            // Weight & Height Row
            Row(
              children: [
                Expanded(child: _buildInputField("Weight (kg)", _weightController, Icons.monitor_weight_outlined, keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: _buildInputField("Height", _heightController, Icons.height_rounded)),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildInputField(
              "Allergies", 
              _allergiesController, 
              Icons.warning_amber_rounded, 
              maxLines: 3,
              hint: "List any medical allergies..."
            ),
            
            const SizedBox(height: 48),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: _textDark),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Edit Profile",
        style: TextStyle(
          color: _textDark,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: _brand,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildInputField(
    String label, 
    TextEditingController controller, 
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textMuted),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _textDark),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: _brand),
            filled: true,
            fillColor: _card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFF3F4F6), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: _brand, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildBloodGroupDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Blood Group",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textMuted),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedBloodGroup,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _textMuted),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _textDark),
              onChanged: (String? newValue) {
                if (newValue != null) setState(() => _selectedBloodGroup = newValue);
              },
              items: _bloodGroups.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () {
        // Mock save action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile updated successfully!"),
            backgroundColor: Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: _brand,
          borderRadius: BorderRadius.circular(20),
          // REMOVED SHADOW
        ),
        child: const Center(
          child: Text(
            "Save Changes",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
