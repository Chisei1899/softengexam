import 'package:flutter/material.dart';
import 'admin_home_screen.dart';
import 'admin_reports_screen.dart';
import 'login_screen.dart';

class AdminAlertsScreen extends StatefulWidget {
  const AdminAlertsScreen({super.key});

  @override
  State<AdminAlertsScreen> createState() => _AdminAlertsScreenState();
}

class _AdminAlertsScreenState extends State<AdminAlertsScreen> {
  static const Color adminPurple = Color(0xFF4A3AFF);
  static const Color primaryRed = Color(0xFFB71C1C);
  int _selectedIndex = 2;
  bool _reportAlertsOn = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _alerts = [
    {'title': 'Red Rainfall Warning', 'issued': 'Issued: 10 mins ago', 'target': 'All Citizens (Push + SMS)', 'targetColor': Color(0xFFB71C1C), 'status': 'Active', 'bgColor': Color(0xFFFFEBEE), 'borderColor': Color(0xFFE57373), 'iconBgColor': Color(0xFFB71C1C)},
    {'title': 'Orange Wind Signal', 'issued': 'Issued: 2 hours ago', 'target': 'App Users Only', 'targetColor': Color(0xFFE65100), 'status': 'Active', 'bgColor': Color(0xFFFFF3E0), 'borderColor': Color(0xFFFFB74D), 'iconBgColor': Color(0xFFE65100)},
    {'title': 'Yellow Thunderstorm Advisory', 'issued': 'Issued: 5 hours ago', 'target': 'App Users Only', 'targetColor': Color(0xFFF57F00), 'status': 'Active', 'bgColor': Color(0xFFFFFDE7), 'borderColor': Color(0xFFFFD54F), 'iconBgColor': Color(0xFFF9A825)},
    {'title': 'Routine Check', 'issued': 'Issued: Yesterday', 'target': 'All Citizens', 'targetColor': Color(0xFFAAAAAA), 'status': 'Ended', 'bgColor': Color(0xFFF5F5F5), 'borderColor': Color(0xFFE0E0E0), 'iconBgColor': Color(0xFFBDBDBD)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF2F2F2),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Broadcast Alerts', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                        SizedBox(height: 3),
                        Text('Manage active localized warnings', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ]),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 42, height: 42,
                          decoration: BoxDecoration(color: primaryRed, shape: BoxShape.circle, boxShadow: [BoxShadow(color: primaryRed.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3))]),
                          child: const Icon(Icons.add, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ..._alerts.asMap().entries.map((entry) => _buildAlertCard(entry.key, entry.value)),
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Center(child: Image.asset('assets/images/ilocos_logo.png', width: 140, height: 90, fit: BoxFit.contain)),
              const SizedBox(height: 8),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              const SizedBox(height: 16),
              Center(
                child: Column(children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(color: const Color(0xFFE8EAF6), shape: BoxShape.circle, border: Border.all(color: const Color(0xFF9FA8DA), width: 2)),
                    child: const Center(child: Text('AD', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: adminPurple))),
                  ),
                  const SizedBox(height: 10),
                  const Text('Admin User', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87)),
                  const SizedBox(height: 4),
                  const Text('admin@ilocoalisto.gov.ph', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 2),
                  const Text('+63 912 000 0001', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 2),
                  const Text('Laoag City, Ilocos Norte', style: TextStyle(fontSize: 12, color: Colors.black54)),
                ]),
              ),
              const SizedBox(height: 20),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              _buildSectionHeader('Admin Controls', color: adminPurple),
              _buildDrawerRow(icon: Icons.group_outlined, iconColor: adminPurple, title: 'Manage Users', subtitle: 'View citizen accounts', onTap: () {}),
              _buildDrawerDivider(),
              _buildDrawerRow(icon: Icons.location_on_outlined, iconColor: adminPurple, title: 'Manage Evac Centers', subtitle: 'Edit status & capacity', onTap: () {}),
              _buildDrawerDivider(),
              _buildDrawerRow(icon: Icons.broadcast_on_personal_outlined, iconColor: adminPurple, title: 'Broadcast Settings', subtitle: 'Alert targets & reach', onTap: () {}),
              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              _buildSectionHeader('Notifications'),
              _buildDrawerToggleRow(icon: Icons.notifications_outlined, title: 'Report Alerts', value: _reportAlertsOn, activeColor: adminPurple, onChanged: (val) => setState(() => _reportAlertsOn = val)),
              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                  },
                  child: Container(
                    width: double.infinity, height: 50,
                    decoration: BoxDecoration(
                      color: adminPurple, borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: adminPurple.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3))],
                    ),
                    child: const Center(child: Text('Log Out', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.4))),
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

  Widget _buildSectionHeader(String label, {Color color = Colors.grey}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      child: Text(label.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.8)),
    );
  }

  Widget _buildDrawerRow({required IconData icon, required Color iconColor, required String title, required String subtitle, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 1),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black45)),
          ])),
          const Icon(Icons.chevron_right, size: 18, color: Colors.black26),
        ]),
      ),
    );
  }

  Widget _buildDrawerToggleRow({required IconData icon, required String title, required bool value, required Color activeColor, required ValueChanged<bool> onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Row(children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87))),
        Switch(value: value, onChanged: onChanged, activeColor: activeColor, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ]),
    );
  }

  Widget _buildDrawerDivider() => const Divider(indent: 56, endIndent: 24, color: Color(0xFFF0F0F0), thickness: 1, height: 1);

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: adminPurple,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, bottom: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Iloco-Admin', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
            SizedBox(height: 2),
            Text('Laoag City, Ilocos Norte', style: TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w400)),
          ]),
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

  // ── Alert Card ────────────────────────────────────────────────────────────
  Widget _buildAlertCard(int index, Map<String, dynamic> alert) {
    final bool isActive = alert['status'] == 'Active';
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: alert['bgColor'], borderRadius: BorderRadius.circular(14),
        border: Border.all(color: alert['borderColor'], width: 1.2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: (alert['iconBgColor'] as Color).withOpacity(isActive ? 1.0 : 0.4), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
            child: Icon(Icons.warning_rounded, color: Colors.white.withOpacity(isActive ? 1.0 : 0.7), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(alert['title'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: isActive ? Colors.black87 : Colors.black38)),
            const SizedBox(height: 2),
            Text(alert['issued'], style: TextStyle(fontSize: 12, color: isActive ? Colors.black54 : Colors.black26)),
          ])),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: isActive ? Colors.grey.shade300 : Colors.grey.shade200, width: 1)),
            child: Text(alert['status'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isActive ? Colors.black87 : Colors.black38)),
          ),
        ]),
        const SizedBox(height: 12),
        Divider(height: 1, color: (alert['borderColor'] as Color).withOpacity(0.5)),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Text('Target: ', style: TextStyle(fontSize: 13, color: isActive ? Colors.black54 : Colors.black26)),
            Text(alert['target'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isActive ? alert['targetColor'] : Colors.black26)),
          ]),
          GestureDetector(
            onTap: () {},
            child: Text('Edit/Cancel >', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isActive ? primaryRed : Colors.black26)),
          ),
        ]),
      ]),
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
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, -2))]),
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
                  decoration: BoxDecoration(color: isSelected ? adminPurple.withOpacity(0.1) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(items[index]['icon'] as IconData, color: isSelected ? adminPurple : Colors.grey, size: 24),
                    const SizedBox(height: 2),
                    Text(items[index]['label'] as String, style: TextStyle(fontSize: 10, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400, color: isSelected ? adminPurple : Colors.grey)),
                  ]),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _onNavTap(int index) {
    if (index == 2) return;
    if (index == 0) { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AdminHomeScreen()), (route) => false); return; }
    if (index == 1) { Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminReportsScreen())); return; }
  }
}