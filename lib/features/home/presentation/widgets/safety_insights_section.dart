import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SafetyInsightsSection extends StatelessWidget {
  const SafetyInsightsSection({super.key});

  static const Color _brand      = Color(0xFF2563EB);
  static const Color _textDark   = Color(0xFF111827);
  static const Color _textMuted  = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
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
                width: 104,
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
              fontSize: 17,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}
