import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'admin_reports_screen.dart';
import 'admin_alerts_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  static const Color adminPurple = Color(0xFF4A3AFF);
  static const Color lightGray = Color(0xFFF2F2F2);

  final List<Map<String, dynamic>> _stats = [
    {
      'label': 'Active Alerts',
      'value': '3',
      'sub': 'Broadcasted',
      'bgColor': Color(0xFFFFEBEE),
      'valueColor': Color(0xFFB71C1C),
      'subColor': Color(0xFFB71C1C),
    },
    {
      'label': 'Evacuees',
      'value': '570',
      'sub': 'Across 3 Centers',
      'bgColor': Color(0xFFE3F2FD),
      'valueColor': Color(0xFF1565C0),
      'subColor': Color(0xFF1565C0),
    },
    {
      'label': 'Unverified Reports',
      'value': '3',
      'sub': 'Pending Review',
      'bgColor': Color(0xFFFFFDE7),
      'valueColor': Color(0xFFF9A825),
      'subColor': Color(0xFFF9A825),
    },
    {
      'label': 'Verified Incidents',
      'value': '3',
      'sub': 'Last 24 hours',
      'bgColor': Color(0xFFE8F5E9),
      'valueColor': Color(0xFF2E7D32),
      'subColor': Color(0xFF2E7D32),
    },
  ];

  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'Red Warning Issued',
      'time': '10m ago',
      'icon': Icons.warning_rounded,
      'iconColor': Color(0xFFB71C1C),
      'iconBg': Color(0xFFFFEBEE),
    },
    {
      'title': 'Verified Flood Report in Brgy 1',
      'time': '35m ago',
      'icon': Icons.check_circle_outline,
      'iconColor': Color(0xFF2E7D32),
      'iconBg': Color(0xFFE8F5E9),
    },
    {
      'title': 'New Landslide Report Received',
      'time': '1h ago',
      'icon': Icons.inbox_outlined,
      'iconColor': Color(0xFFE65100),
      'iconBg': Color(0xFFFFF3E0),
    },
    {
      'title': 'Evacuation Center #2 Status changed to Full',
      'time': '2h ago',
      'icon': Icons.location_on_outlined,
      'iconColor': Color(0xFF1565C0),
      'iconBg': Color(0xFFE3F2FD),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSituationOverview(),
                  const SizedBox(height: 28),
                  _buildRecentActivity(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: adminPurple,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Iloco-Admin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Laoag City, Ilocos Norte',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.menu, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // ── Situation Overview ────────────────────────────────────────────────────
  Widget _buildSituationOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Situation Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: _stats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: stat['bgColor'],
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            stat['label'],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          Text(
            stat['value'],
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: stat['valueColor'],
              height: 1.1,
            ),
          ),
          Text(
            stat['sub'],
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: stat['subColor'],
            ),
          ),
        ],
      ),
    );
  }

  // ── Recent Activity ───────────────────────────────────────────────────────
  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            // ── View All → AdminReportsScreen ─────────────────────────
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminReportsScreen(),
                  ),
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFB71C1C),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ..._activities.map((activity) => _buildActivityItem(activity)),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: activity['iconBg'],
              shape: BoxShape.circle,
            ),
            child: Icon(
              activity['icon'],
              color: activity['iconColor'],
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  activity['time'],
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Nav ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded,    'label': 'Home'},
      {'icon': Icons.inbox_outlined,  'label': 'Reports'},
      {'icon': Icons.warning_rounded, 'label': 'Alerts'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => _onNavTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? adminPurple.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[index]['icon'] as IconData,
                        color: isSelected ? adminPurple : Colors.grey,
                        size: 24,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        items[index]['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isSelected ? adminPurple : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // ── Nav tap handler ───────────────────────────────────────────────────────
  void _onNavTap(int index) {
    if (index == 0) return; // already on Home
    if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AdminReportsScreen()));
      return;
    }
    if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AdminAlertsScreen()));
      return;
    }
  }
}