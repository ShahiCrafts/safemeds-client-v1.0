import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  // ── Design tokens (mirrored from home_page.dart) ───────────────────────
  static const Color _brand = Color(0xFF2563EB);
  static const Color _brandLight = Color(0xFFEFF6FF);
  static const Color _card = Color(0xFFF6F6F6);
  static const Color _textDark = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);
  static const Color _green = Color(0xFF10B981);
  static const Color _orange = Color(0xFFFF8000);
  static const Color _red = Color(0xFFFF5640);

  int _selectedFilter = 0;
  bool _showMap = false;
  final List<String> _filters = ["All", "Nearby", "24hr", "Verified", "Offers"];

  final List<_PharmacyData> _pharmacies = [
    _PharmacyData(
      name: "MedPoint Pharmacy",
      address: "Putalisadak, Kathmandu",
      distance: "0.8 km",
      rating: 4.8,
      reviews: 124,
      isOpen: true,
      is24hr: true,
      isVerified: true,
      hasOffer: false,
      icon: Icons.local_pharmacy_rounded,
      iconColor: Color(0xFF2563EB),
      iconBg: Color(0xFFEFF6FF),
      location: const LatLng(27.7056, 85.3206),
    ),
    _PharmacyData(
      name: "HealthCare Chemist",
      address: "New Road, Kathmandu",
      distance: "1.2 km",
      rating: 4.6,
      reviews: 89,
      isOpen: true,
      is24hr: false,
      isVerified: true,
      hasOffer: true,
      icon: Icons.medication_rounded,
      iconColor: Color(0xFF10B981),
      iconBg: Color(0xFFEDF7F2),
      location: const LatLng(27.7033, 85.3110),
    ),
    _PharmacyData(
      name: "Nepal Pharma Hub",
      address: "Baluwatar, Kathmandu",
      distance: "2.4 km",
      rating: 4.9,
      reviews: 210,
      isOpen: false,
      is24hr: false,
      isVerified: true,
      hasOffer: false,
      icon: Icons.local_hospital_rounded,
      iconColor: Color(0xFF8B5CF6),
      iconBg: Color(0xFFF5F3FF),
      location: const LatLng(27.7303, 85.3301),
    ),
    _PharmacyData(
      name: "City MedStore",
      address: "Thamel, Kathmandu",
      distance: "3.1 km",
      rating: 4.3,
      reviews: 56,
      isOpen: true,
      is24hr: false,
      isVerified: false,
      hasOffer: true,
      icon: Icons.storefront_rounded,
      iconColor: Color(0xFFFF8000),
      iconBg: Color(0xFFFFF8EC),
      location: const LatLng(27.7150, 85.3100),
    ),
    _PharmacyData(
      name: "SafeMeds Outlet",
      address: "Maharajgunj, Kathmandu",
      distance: "4.0 km",
      rating: 4.7,
      reviews: 178,
      isOpen: true,
      is24hr: true,
      isVerified: true,
      hasOffer: false,
      icon: Icons.shield_rounded,
      iconColor: Color(0xFF2563EB),
      iconBg: Color(0xFFEFF6FF),
      location: const LatLng(27.7371, 85.3340),
    ),
    _PharmacyData(
      name: "Wellness Pharmacy",
      address: "Lazimpat, Kathmandu",
      distance: "5.2 km",
      rating: 4.5,
      reviews: 95,
      isOpen: true,
      is24hr: false,
      isVerified: true,
      hasOffer: true,
      icon: Icons.favorite_rounded,
      iconColor: Color(0xFFFF5640),
      iconBg: Color(0xFFFFF0EF),
      location: const LatLng(27.7214, 85.3197),
    ),
  ];

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
            _buildFilterChips(),
            const SizedBox(height: 6),
            Expanded(child: _showMap ? _buildMap() : _buildContent()),
          ],
        ),
      ),
    );
  }

  // ── App Bar ─────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(color: _card, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_rounded, size: 20, color: _textDark),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text("Pharmacy",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark, letterSpacing: -0.3)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _showMap = !_showMap;
              });
            },
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: _showMap ? _brand : _card, shape: BoxShape.circle),
              child: Icon(Icons.map_rounded, size: 20, color: _showMap ? Colors.white : _textDark),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(color: _card, shape: BoxShape.circle),
              child: const Icon(Icons.tune_rounded, size: 20, color: _textDark),
            ),
          ),
        ],
      ),
    );
  }

  // ── Search Bar ──────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
        ),
        child: const Row(
          children: [
            SizedBox(width: 16),
            Icon(Icons.search_rounded, size: 22, color: _textMuted),
            SizedBox(width: 10),
            Expanded(
              child: Text("Search pharmacies...",
                style: TextStyle(fontSize: 16, color: Color(0xFFB0B7C3), fontWeight: FontWeight.w400)),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  // ── Filter Chips ────────────────────────────────────────────────────────

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isActive = i == _selectedFilter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isActive ? _brand : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isActive ? _brand : const Color(0xFFE5E7EB), width: 1.5),
              ),
              child: Center(
                child: Text(_filters[i],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isActive ? Colors.white : _textMuted)),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Map View ─────────────────────────────────────────────────────────────

  Widget _buildMap() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(27.7172, 85.3240), // Kathmandu Center
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.safemeds.app',
        ),
        MarkerLayer(
          markers: _pharmacies.map((p) {
            return Marker(
              point: p.location,
              width: 50,
              height: 50,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: p.iconBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: p.iconColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: p.iconColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(p.icon, size: 24, color: p.iconColor),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Content ─────────────────────────────────────────────────────────────

  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      children: [
        // Stats row
        _buildStatsRow(),
        const SizedBox(height: 28),

        // Featured pharmacy
        _buildSectionHeader("Featured Pharmacy"),
        const SizedBox(height: 14),
        _buildFeaturedCard(_pharmacies.first),
        const SizedBox(height: 28),

        // Quick categories
        _buildSectionHeader("Categories"),
        const SizedBox(height: 14),
        _buildQuickCategories(),
        const SizedBox(height: 28),

        // All pharmacies
        _buildSectionHeader("Nearby Pharmacies", trailingText: "See all"),
        const SizedBox(height: 14),
        ..._pharmacies.map((p) => _buildPharmacyCard(p)),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Stats Row ───────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatItem(Icons.local_pharmacy_rounded, _brand, "12", "Pharmacies")),
        const SizedBox(width: 12),
        Expanded(child: _buildStatItem(Icons.verified_rounded, _green, "8", "Verified")),
        const SizedBox(width: 12),
        Expanded(child: _buildStatItem(Icons.access_time_filled_rounded, _orange, "3", "Open 24hr")),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, Color color, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark, letterSpacing: -0.3)),
          const SizedBox(height: 2),
          Text(label,
            style: const TextStyle(fontSize: 13, color: _textMuted, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ── Section Header ──────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title, {String? trailingText}) {
    return Row(
      children: [
        Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark, letterSpacing: -0.3)),
        const Spacer(),
        if (trailingText != null)
          GestureDetector(
            onTap: () {},
            child: Text(trailingText,
              style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w600, color: _brand)),
          ),
      ],
    );
  }

  // ── Featured Card ───────────────────────────────────────────────────────

  Widget _buildFeaturedCard(_PharmacyData p) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _brand,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.local_pharmacy_rounded, size: 26, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.2)),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded, size: 14, color: Colors.white70),
                        const SizedBox(width: 4),
                        Text(p.address,
                          style: const TextStyle(fontSize: 14, color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _buildFeaturedPill(Icons.star_rounded, "${p.rating}", Colors.white.withOpacity(0.2), Colors.white),
              const SizedBox(width: 8),
              _buildFeaturedPill(Icons.near_me_rounded, p.distance, Colors.white.withOpacity(0.2), Colors.white),
              const SizedBox(width: 8),
              if (p.is24hr) _buildFeaturedPill(Icons.access_time_rounded, "24hr", Colors.white.withOpacity(0.2), Colors.white),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: const Text("Visit",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _brand)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedPill(IconData icon, String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: fg)),
        ],
      ),
    );
  }

  // ── Quick Categories ────────────────────────────────────────────────────

  Widget _buildQuickCategories() {
    final cats = [
      _CatItem(Icons.access_time_filled_rounded, "Open Now", _green),
      _CatItem(Icons.verified_rounded, "Verified", _brand),
      _CatItem(Icons.local_offer_rounded, "Offers", _orange),
      _CatItem(Icons.delivery_dining_rounded, "Delivery", _red),
    ];
    return Row(
      children: cats.map((c) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: c == cats.last ? 0 : 10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
              ),
              child: Column(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(color: c.color, shape: BoxShape.circle),
                    child: Icon(c.icon, size: 22, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(c.label, textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: _textDark, height: 1.3)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Pharmacy Card ───────────────────────────────────────────────────────

  Widget _buildPharmacyCard(_PharmacyData p) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            // Icon
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(color: p.iconBg, borderRadius: BorderRadius.circular(14)),
              child: Icon(p.icon, size: 24, color: p.iconColor),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(p.name,
                          style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w700, color: _textDark, letterSpacing: -0.1),
                          overflow: TextOverflow.ellipsis),
                      ),
                      // Status pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: p.isOpen ? const Color(0xFFEDF7F2) : const Color(0xFFFFF0EF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(p.isOpen ? "Open" : "Closed",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: p.isOpen ? _green : _red)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 13, color: _textMuted),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text("${p.address} · ${p.distance}",
                          style: const TextStyle(fontSize: 14, color: _textMuted),
                          overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 14, color: Color(0xFFFBBF24)),
                      const SizedBox(width: 3),
                      Text("${p.rating}",
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _textDark)),
                      Text(" (${p.reviews})",
                        style: const TextStyle(fontSize: 13, color: _textMuted)),
                      if (p.isVerified) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: _brandLight, borderRadius: BorderRadius.circular(6)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified_rounded, size: 11, color: _brand),
                              SizedBox(width: 3),
                              Text("Verified", style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _brand)),
                            ],
                          ),
                        ),
                      ],
                      if (p.hasOffer) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFFFFF8EC), borderRadius: BorderRadius.circular(6)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_offer_rounded, size: 11, color: _orange),
                              SizedBox(width: 3),
                              Text("Offers", style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _orange)),
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
            Container(
              width: 34, height: 34,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_forward_rounded, size: 16, color: _brand),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data Models ───────────────────────────────────────────────────────────

class _PharmacyData {
  final String name, address, distance;
  final double rating;
  final int reviews;
  final bool isOpen, is24hr, isVerified, hasOffer;
  final IconData icon;
  final Color iconColor, iconBg;
  final LatLng location;
  const _PharmacyData({
    required this.name, required this.address, required this.distance,
    required this.rating, required this.reviews, required this.isOpen,
    required this.is24hr, required this.isVerified, required this.hasOffer,
    required this.icon, required this.iconColor, required this.iconBg,
    required this.location,
  });
}

class _CatItem {
  final IconData icon;
  final String label;
  final Color color;
  const _CatItem(this.icon, this.label, this.color);
}
