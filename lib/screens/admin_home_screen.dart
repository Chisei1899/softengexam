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
  bool _reportAlertsOn = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const Color adminPurple = Color(0xFF4A3AFF);
  static const Color primaryRed = Color(0xFFB71C1C);
  static const Color lightGray = Color(0xFFF2F2F2);

  final List<Map<String, dynamic>> _stats = [
    {
      'label': 'Active Alerts', 'value': '3', 'sub': 'Broadcasted',
      'bgColor': Color(0xFFFFEBEE), 'valueColor': Color(0xFFB71C1C), 'subColor': Color(0xFFB71C1C),
    },
    {
      'label': 'Evacuees', 'value': '570', 'sub': 'Across 3 Centers',
      'bgColor': Color(0xFFE3F2FD), 'valueColor': Color(0xFF1565C0), 'subColor': Color(0xFF1565C0),
    },
    {
      'label': 'Unverified Reports', 'value': '3', 'sub': 'Pending Review',
      'bgColor': Color(0xFFFFFDE7), 'valueColor': Color(0xFFF9A825), 'subColor': Color(0xFFF9A825),
    },
    {
      'label': 'Verified Incidents', 'value': '3', 'sub': 'Last 24 hours',
      'bgColor': Color(0xFFE8F5E9), 'valueColor': Color(0xFF2E7D32), 'subColor': Color(0xFF2E7D32),
    },
  ];

  final List<Map<String, dynamic>> _activities = [
    {'title': 'Red Warning Issued', 'time': '10m ago', 'icon': Icons.warning_rounded, 'iconColor': Color(0xFFB71C1C), 'iconBg': Color(0xFFFFEBEE)},
    {'title': 'Verified Flood Report in Brgy 1', 'time': '35m ago', 'icon': Icons.check_circle_outline, 'iconColor': Color(0xFF2E7D32), 'iconBg': Color(0xFFE8F5E9)},
    {'title': 'New Landslide Report Received', 'time': '1h ago', 'icon': Icons.inbox_outlined, 'iconColor': Color(0xFFE65100), 'iconBg': Color(0xFFFFF3E0)},
    {'title': 'Evacuation Center #2 Status changed to Full', 'time': '2h ago', 'icon': Icons.location_on_outlined, 'iconColor': Color(0xFF1565C0), 'iconBg': Color(0xFFE3F2FD)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: lightGray,
      endDrawer: _buildAdminDrawer(),
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

  // ── Admin Settings Drawer ─────────────────────────────────────────────────
  Widget _buildAdminDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.82,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // ── Logo ────────────────────────────────────────────────
              Center(
                child: Image.asset(
                  'assets/images/ilocos_logo.png',
                  width: 140, height: 90, fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 8),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              const SizedBox(height: 16),

              // ── Avatar + info ────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72, height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EAF6), shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF9FA8DA), width: 2),
                      ),
                      child: const Center(
                        child: Text('AD', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: adminPurple)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Admin User', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87)),
                    const SizedBox(height: 4),
                    const Text('admin@ilocoalisto.gov.ph', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 2),
                    const Text('+63 912 000 0001', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 2),
                    const Text('Laoag City, Ilocos Norte', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),

              // ── ADMIN CONTROLS section ───────────────────────────────
              _buildSectionHeader('Admin Controls', color: adminPurple),
              _buildDrawerRow(
                icon: Icons.group_outlined,
                iconColor: adminPurple,
                title: 'Manage Users',
                subtitle: 'View citizen accounts',
                onTap: () {
                  // TODO: Navigate to Manage Users
                },
              ),
              _buildDrawerDivider(),
              _buildDrawerRow(
                icon: Icons.location_on_outlined,
                iconColor: adminPurple,
                title: 'Manage Evac Centers',
                subtitle: 'Edit status & capacity',
                onTap: () {
                  // TODO: Navigate to Manage Evac Centers
                },
              ),
              _buildDrawerDivider(),
              _buildDrawerRow(
                icon: Icons.broadcast_on_personal_outlined,
                iconColor: adminPurple,
                title: 'Broadcast Settings',
                subtitle: 'Alert targets & reach',
                onTap: () {
                  // TODO: Navigate to Broadcast Settings
                },
              ),

              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),

              // ── NOTIFICATIONS section ────────────────────────────────
              _buildSectionHeader('Notifications'),
              _buildDrawerToggleRow(
                icon: Icons.notifications_outlined,
                title: 'Report Alerts',
                value: _reportAlertsOn,
                activeColor: adminPurple,
                onChanged: (val) => setState(() => _reportAlertsOn = val),
              ),

              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              const SizedBox(height: 16),

              // ── Log Out button ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: adminPurple,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: adminPurple.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3)),
                      ],
                    ),
                    child: const Center(
                      child: Text('Log Out',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.4)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Drawer helper widgets ─────────────────────────────────────────────────
  Widget _buildSectionHeader(String label, {Color color = Colors.grey}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildDrawerRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 1),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black45)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 18, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerToggleRow({
    required IconData icon,
    required String title,
    required bool value,
    required Color activeColor,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: activeColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerDivider() {
    return const Divider(indent: 56, endIndent: 24, color: Color(0xFFF0F0F0), thickness: 1, height: 1);
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: adminPurple,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 20, left: 20, right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Iloco-Admin', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
              SizedBox(height: 2),
              Text('Laoag City, Ilocos Norte', style: TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w400)),
            ],
          ),
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
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
        const Text('Situation Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.4,
          children: _stats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: stat['bgColor'], borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(stat['label'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
          Text(stat['value'], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: stat['valueColor'], height: 1.1)),
          Text(stat['sub'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: stat['subColor'])),
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
            const Text('Recent Activity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminReportsScreen())),
              child: const Text('View All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFFB71C1C))),
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
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: activity['iconBg'], shape: BoxShape.circle),
            child: Icon(activity['icon'], color: activity['iconColor'], size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity['title'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
                const SizedBox(height: 3),
                Text(activity['time'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
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
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.inbox_outlined, 'label': 'Reports'},
      {'icon': Icons.warning_rounded, 'label': 'Alerts'},
    ];
    return Container(
      decoration: BoxDecoration(color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, -2))]),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? adminPurple.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(items[index]['icon'] as IconData, color: isSelected ? adminPurple : Colors.grey, size: 24),
                      const SizedBox(height: 2),
                      Text(items[index]['label'] as String,
                          style: TextStyle(fontSize: 10,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                              color: isSelected ? adminPurple : Colors.grey)),
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

  void _onNavTap(int index) {
    if (index == 0) return;
    if (index == 1) { Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminReportsScreen())); return; }
    if (index == 2) { Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminAlertsScreen())); return; }
  }
}