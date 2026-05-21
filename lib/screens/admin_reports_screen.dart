import 'package:flutter/material.dart';
import 'admin_home_screen.dart';
import 'admin_alerts_screen.dart';
import 'login_screen.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  static const Color adminPurple = Color(0xFF4A3AFF);
  static const Color primaryRed = Color(0xFFB71C1C);
  int _selectedIndex = 1;
  bool _reportAlertsOn = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _reports = [
    {'id': 'REP-0192', 'time': '10 mins ago', 'location': 'Brgy. 1 San Lorenzo', 'description': '"Waist-deep water near the plaza."', 'type': 'flood', 'status': 'PENDING'},
    {'id': 'REP-0191', 'time': '25 mins ago', 'location': 'Sitio Bato', 'description': '"Rocks blocking the main road."', 'type': 'landslide', 'status': 'PENDING'},
    {'id': 'REP-0190', 'time': '30 mins ago', 'location': 'Sitio Bato', 'description': '"Rocks blocking the main road."', 'type': 'landslide', 'status': 'VERIFIED'},
  ];

  @override
  Widget build(BuildContext context) {
    final pendingCount = _reports.where((r) => r['status'] == 'PENDING').length;
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
                        Text('Citizen Reports', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                        SizedBox(height: 3),
                        Text('Verify incoming hazard reports', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryRed, width: 1),
                        ),
                        child: Text('$pendingCount Pending', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: primaryRed)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ..._reports.asMap().entries.map((entry) => _buildReportCard(entry.key, entry.value)),
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
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),

              // ── Admin Controls ────────────────────────────────────────────────
              _buildSectionHeader('Admin Controls', color: adminPurple),
              _buildDrawerRow(icon: Icons.group_outlined, iconColor: adminPurple, title: 'Manage Users', subtitle: 'View citizen accounts', onTap: () {}),
              _buildDrawerDivider(),
              _buildDrawerRow(icon: Icons.location_on_outlined, iconColor: adminPurple, title: 'Manage Evac Centers', subtitle: 'Edit status & capacity', onTap: () {}),
              _buildDrawerDivider(),
              _buildDrawerRow(icon: Icons.broadcast_on_personal_outlined, iconColor: adminPurple, title: 'Broadcast Settings', subtitle: 'Alert targets & reach', onTap: () {}),
              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),

              // ── Notifications ────────────────────────────────────────────────
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

  Widget _buildDrawerToggleRow({required IconData icon, required String title, required bool value, required Color activeColor, required ValueChanged<bool> onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87))),
          Switch(value: value, onChanged: onChanged, activeColor: activeColor, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
        ],
      ),
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

  // ── Report Card ───────────────────────────────────────────────────────────
  Widget _buildReportCard(int index, Map<String, dynamic> report) {
    final bool isPending  = report['status'] == 'PENDING';
    final bool isVerified = report['status'] == 'VERIFIED';
    final bool isRejected = report['status'] == 'REJECTED';
    final bool isFlood    = report['type'] == 'flood';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  width: 34, height: 34,
                  decoration: BoxDecoration(color: isFlood ? const Color(0xFFE3F2FD) : const Color(0xFFFFF3E0), shape: BoxShape.circle),
                  child: Icon(isFlood ? Icons.water : Icons.landscape, size: 17, color: isFlood ? const Color(0xFF1565C0) : const Color(0xFFE65100)),
                ),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(report['id'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black87)),
                  Text(report['time'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ]),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPending ? const Color(0xFFFFFDE7) : isVerified ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: isPending ? const Color(0xFFF9A825) : isVerified ? const Color(0xFF2E7D32) : primaryRed, width: 1),
                ),
                child: Text(report['status'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isPending ? const Color(0xFFF9A825) : isVerified ? const Color(0xFF2E7D32) : primaryRed)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(children: [
            const Icon(Icons.location_on, size: 16, color: primaryRed),
            const SizedBox(width: 4),
            Text(report['location'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ]),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(report['description'], style: const TextStyle(fontSize: 13, color: Colors.black54, fontStyle: FontStyle.italic)),
          ),
          if (isPending) ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _reports[index]['status'] = 'VERIFIED'),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF2E7D32), width: 1)),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF2E7D32)),
                      SizedBox(width: 6),
                      Text('Verify', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
                    ]),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _reports[index]['status'] = 'REJECTED'),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(8), border: Border.all(color: primaryRed, width: 1)),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.cancel_outlined, size: 16, color: primaryRed),
                      SizedBox(width: 6),
                      Text('Reject', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: primaryRed)),
                    ]),
                  ),
                ),
              ),
            ]),
          ],
          if (isVerified) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF2E7D32), width: 1)),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.check_circle, size: 15, color: Color(0xFF2E7D32)),
                SizedBox(width: 6),
                Text('This report has been verified.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2E7D32))),
              ]),
            ),
          ],
          if (isRejected) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(8), border: Border.all(color: primaryRed, width: 1)),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.cancel, size: 15, color: primaryRed),
                SizedBox(width: 6),
                Text('This report has been rejected.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primaryRed)),
              ]),
            ),
          ],
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
                  decoration: BoxDecoration(
                    color: isSelected ? adminPurple.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(items[index]['icon'] as IconData, color: isSelected ? adminPurple : Colors.grey, size: 24),
                      const SizedBox(height: 2),
                      Text(items[index]['label'] as String, style: TextStyle(fontSize: 10, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400, color: isSelected ? adminPurple : Colors.grey)),
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
    if (index == 1) return;
    if (index == 0) { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AdminHomeScreen()), (route) => false); return; }
    if (index == 2) { Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminAlertsScreen())); return; }
  }
}