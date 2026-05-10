import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ── Design tokens (mirrored from home_page.dart) ───────────────────────
  static const Color _brand = Color(0xFF2563EB);
  static const Color _brandLight = Color(0xFFEFF6FF);
  static const Color _card = Color(0xFFF6F6F6);
  static const Color _textDark = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);
  static const Color _green = Color(0xFF10B981);
  static const Color _orange = Color(0xFFFF8000);
  static const Color _red = Color(0xFFFF5640);

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String _query = "";
  int _selectedCategory = 0;

  final List<String> _categories = [
    "All",
    "Medicines",
    "Pharmacies",
    "Symptoms",
    "Articles",
  ];

  final List<String> _recentSearches = [
    "Amoxicillin 500mg",
    "Metformin 850mg",
    "Nearest pharmacy",
    "Vitamin D3",
    "Blood pressure medication",
  ];

  final List<_TrendingItem> _trending = [
    _TrendingItem(
      title: "Paracetamol Safety Alert",
      subtitle: "Counterfeit batch reported in Kathmandu",
      icon: Icons.warning_amber_rounded,
      tag: "Trending",
      tagColor: Color(0xFFFF5640),
      tagBg: Color(0xFFFFF0EF),
    ),
    _TrendingItem(
      title: "COVID-19 Booster",
      subtitle: "Availability in your area",
      icon: Icons.vaccines_rounded,
      tag: "Popular",
      tagColor: Color(0xFFFF8000),
      tagBg: Color(0xFFFFF8EC),
    ),
    _TrendingItem(
      title: "Diabetes Medication Guide",
      subtitle: "Updated dosage recommendations",
      icon: Icons.auto_stories_rounded,
      tag: "New",
      tagColor: Color(0xFF10B981),
      tagBg: Color(0xFFEDF7F2),
    ),
  ];

  final List<_MedicineResult> _allMedicines = [
    _MedicineResult(
      name: "Amoxicillin 500mg",
      category: "Antibiotic",
      manufacturer: "Cipla Ltd.",
      verified: true,
      icon: Icons.medication_rounded,
      iconColor: Color(0xFF2563EB),
      iconBg: Color(0xFFEFF6FF),
    ),
    _MedicineResult(
      name: "Metformin 850mg",
      category: "Antidiabetic",
      manufacturer: "Sun Pharma",
      verified: true,
      icon: Icons.medication_liquid_rounded,
      iconColor: Color(0xFF10B981),
      iconBg: Color(0xFFEDF7F2),
    ),
    _MedicineResult(
      name: "Atorvastatin 20mg",
      category: "Cholesterol",
      manufacturer: "Ranbaxy Labs",
      verified: true,
      icon: Icons.medication_rounded,
      iconColor: Color(0xFF8B5CF6),
      iconBg: Color(0xFFF5F3FF),
    ),
    _MedicineResult(
      name: "Vitamin D3 1000IU",
      category: "Supplement",
      manufacturer: "HealthVit",
      verified: false,
      icon: Icons.wb_sunny_rounded,
      iconColor: Color(0xFFFF8000),
      iconBg: Color(0xFFFFF8EC),
    ),
    _MedicineResult(
      name: "Ibuprofen 400mg",
      category: "Pain Relief",
      manufacturer: "GSK Pharma",
      verified: true,
      icon: Icons.healing_rounded,
      iconColor: Color(0xFFFF5640),
      iconBg: Color(0xFFFFF0EF),
    ),
    _MedicineResult(
      name: "Omeprazole 20mg",
      category: "Gastric",
      manufacturer: "Dr. Reddy's",
      verified: true,
      icon: Icons.medication_rounded,
      iconColor: Color(0xFF2563EB),
      iconBg: Color(0xFFEFF6FF),
    ),
    _MedicineResult(
      name: "Cetirizine 10mg",
      category: "Antihistamine",
      manufacturer: "Mankind Pharma",
      verified: true,
      icon: Icons.air_rounded,
      iconColor: Color(0xFF10B981),
      iconBg: Color(0xFFEDF7F2),
    ),
    _MedicineResult(
      name: "Azithromycin 250mg",
      category: "Antibiotic",
      manufacturer: "Cipla Ltd.",
      verified: false,
      icon: Icons.medication_rounded,
      iconColor: Color(0xFF8B5CF6),
      iconBg: Color(0xFFF5F3FF),
    ),
  ];

  List<_MedicineResult> get _filteredResults {
    if (_query.isEmpty) return [];
    return _allMedicines
        .where((m) =>
            m.name.toLowerCase().contains(_query.toLowerCase()) ||
            m.category.toLowerCase().contains(_query.toLowerCase()) ||
            m.manufacturer.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _searchFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 14),
            _buildCategoryChips(),
            const SizedBox(height: 6),
            Expanded(
              child: _query.isNotEmpty
                  ? _buildSearchResults()
                  : _buildDiscoverContent(),
            ),
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
              "Search",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _textDark,
                letterSpacing: -0.3,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: _card,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.tune_rounded,
                size: 20,
                color: _textDark,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: _card,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                size: 20,
                color: _textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Search Bar ──────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    final bool hasFocus = _searchFocus.hasFocus;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: hasFocus ? Colors.white : _card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasFocus ? _brand : const Color(0xFFE5E7EB),
            width: hasFocus ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.search_rounded,
              size: 22,
              color: hasFocus ? _brand : _textMuted,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocus,
                onChanged: (v) => setState(() => _query = v),
                style: const TextStyle(
                  fontSize: 16,
                  color: _textDark,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  hintText: "Search medicines, pharmacies...",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFB0B7C3),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (_query.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _searchController.clear();
                  setState(() => _query = "");
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: _card,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: _textMuted,
                  ),
                ),
              )
            else
              const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  // ── Category Chips ──────────────────────────────────────────────────────

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isActive = i == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = i),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
                  _categories[i],
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

  // ── Discover Content (shown when no query) ──────────────────────────────

  Widget _buildDiscoverContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      children: [
        // Recent Searches
        if (_recentSearches.isNotEmpty) ...[
          _buildSectionHeader(
            "Recent Searches",
            trailingText: "Clear all",
            onTrailingTap: () => setState(() => _recentSearches.clear()),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _recentSearches.map((s) => _buildRecentChip(s)).toList(),
          ),
          const SizedBox(height: 28),
        ],

        // Quick Actions
        _buildSectionHeader("Quick Actions"),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildQuickAction(
                Icons.qr_code_scanner_rounded,
                "Scan\nMedicine",
                _brand,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildQuickAction(
                Icons.local_pharmacy_rounded,
                "Find\nPharmacy",
                _green,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildQuickAction(
                Icons.report_problem_rounded,
                "Report\nFake Med",
                _red,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildQuickAction(
                Icons.article_rounded,
                "Health\nArticles",
                _orange,
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // Trending Now
        _buildSectionHeader("Trending Now"),
        const SizedBox(height: 14),
        ..._trending.map((t) => _buildTrendingCard(t)),

        const SizedBox(height: 28),

        // Popular Medicines
        _buildSectionHeader(
          "Popular Medicines",
          trailingText: "See all",
          onTrailingTap: () {},
        ),
        const SizedBox(height: 14),
        ..._allMedicines.take(4).map((m) => _buildMedicineResultCard(m)),

        const SizedBox(height: 20),
      ],
    );
  }

  // ── Section Header ──────────────────────────────────────────────────────

  Widget _buildSectionHeader(
    String title, {
    String? trailingText,
    VoidCallback? onTrailingTap,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _textDark,
            letterSpacing: -0.3,
          ),
        ),
        const Spacer(),
        if (trailingText != null)
          GestureDetector(
            onTap: onTrailingTap,
            child: Text(
              trailingText,
              style: const TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
                color: _brand,
              ),
            ),
          ),
      ],
    );
  }

  // ── Recent Search Chip ──────────────────────────────────────────────────

  Widget _buildRecentChip(String label) {
    return GestureDetector(
      onTap: () {
        _searchController.text = label;
        setState(() => _query = label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.history_rounded, size: 15, color: _textMuted),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: _textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: () {
                setState(() => _recentSearches.remove(label));
              },
              child: const Icon(
                Icons.close_rounded,
                size: 13,
                color: Color(0xFFB0B7C3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Trending Card ──────────────────────────────────────────────────────

  Widget _buildTrendingCard(_TrendingItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                color: item.tagBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                item.icon,
                size: 24,
                color: item.tagColor,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: _textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: item.tagBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item.tag,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: item.tagColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Quick Action ──────────────────────────────────────────────────────

  Widget _buildQuickAction(
    IconData icon,
    String label,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFF3F4F6),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: _textDark,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Search Results ──────────────────────────────────────────────────────

  Widget _buildSearchResults() {
    final results = _filteredResults;

    if (results.isEmpty) {
      return _buildEmptyState();
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        // Result count
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _brandLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "${results.length} result${results.length != 1 ? 's' : ''} found",
                  style: const TextStyle(
                    fontSize: 13,
                    color: _brand,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.sort_rounded,
                size: 20,
                color: _textMuted,
              ),
              const SizedBox(width: 4),
              const Text(
                "Relevance",
                style: TextStyle(
                  fontSize: 13,
                  color: _textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        ...results.map((m) => _buildMedicineResultCard(m)),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Empty State ──────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: _brandLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 40,
                color: _brand,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "No results found",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _textDark,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We couldn't find anything matching\n\"$_query\". Try different keywords.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: _textMuted,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() => _query = "");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 13),
                decoration: BoxDecoration(
                  color: _brand,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  "Clear Search",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Medicine Result Card ──────────────────────────────────────────────

  Widget _buildMedicineResultCard(_MedicineResult med) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            // Medicine icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: med.iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(med.icon, size: 24, color: med.iconColor),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    med.name,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                      letterSpacing: -0.1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "${med.category} · ${med.manufacturer}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: _textMuted,
                        ),
                      ),
                      if (med.verified) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDF7F2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified_rounded,
                                  size: 12, color: _green),
                              SizedBox(width: 3),
                              Text(
                                "Verified",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Arrow
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: _brand,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data Models ───────────────────────────────────────────────────────────

class _TrendingItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String tag;
  final Color tagColor;
  final Color tagBg;

  const _TrendingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tag,
    required this.tagColor,
    required this.tagBg,
  });
}

class _MedicineResult {
  final String name;
  final String category;
  final String manufacturer;
  final bool verified;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _MedicineResult({
    required this.name,
    required this.category,
    required this.manufacturer,
    required this.verified,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });
}
