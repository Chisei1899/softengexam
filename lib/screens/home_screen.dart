import 'package:flutter/material.dart';
import 'report_incident_screen.dart';
import 'evacuation_centers_screen.dart';
import 'map_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _alertNotificationsOn = true;
  bool _soundAlertsOn = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const Color primaryRed = Color(0xFFB71C1C);

  final List<Map<String, dynamic>> _alerts = [
    {
      'title': 'Red Rainfall Warning',
      'description': 'Severe flooding expected in low-lying areas of Laoag City. Evacuate immediately.',
      'bgColor': Color(0xFFFFEBEE), 'borderColor': Color(0xFFE57373),
      'iconBgColor': Color(0xFFB71C1C), 'titleColor': Color(0xFFB71C1C),
    },
    {
      'title': 'Orange Wind Signal',
      'description': 'Typhoon Egay approaching. Secure loose objects and stay indoors.',
      'bgColor': Color(0xFFFFF3E0), 'borderColor': Color(0xFFFFB74D),
      'iconBgColor': Color(0xFFE65100), 'titleColor': Color(0xFFE65100),
    },
    {
      'title': 'Yellow Thunderstorm Advisory',
      'description': 'Light to moderate rains affecting portions of Ilocos Norte.',
      'bgColor': Color(0xFFFFFDE7), 'borderColor': Color(0xFFFFD54F),
      'iconBgColor': Color(0xFFF9A825), 'titleColor': Color(0xFFF57F00),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF2F2F2),
      endDrawer: _buildCitizenDrawer(),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildActiveAlerts(),
                  const SizedBox(height: 28),
                  _buildQuickActions(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Citizen Settings Drawer ───────────────────────────────────────────────
  Widget _buildCitizenDrawer() {
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

              // Logo
              Center(
                child: Image.asset(
                  'assets/images/ilocos_logo.png',
                  width: 140, height: 90, fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 8),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              const SizedBox(height: 16),

              // Avatar + info
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72, height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCDD2), shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFEF9A9A), width: 2),
                      ),
                      child: const Center(
                        child: Text('JD', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: primaryRed)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Jane Doe', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87)),
                    const SizedBox(height: 4),
                    const Text('jane_doe@gmail.com', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 2),
                    const Text('+63 912 345 6789', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 2),
                    const Text('Brgy. 1, Laoag City, Ilocos Norte', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),

              // ACCOUNT
              _buildSectionHeader('Account'),
              _buildDrawerRow(
                icon: Icons.person_outline, iconColor: Colors.black54,
                title: 'Edit Profile', subtitle: 'Name, phone, address',
                onTap: () {},
              ),
              _buildDrawerDivider(),
              _buildDrawerRow(
                icon: Icons.lock_outline, iconColor: Colors.black54,
                title: 'Change Password', subtitle: 'Update credentials',
                onTap: () {},
              ),
              _buildDrawerDivider(),
              _buildDrawerRow(
                icon: Icons.location_on_outlined, iconColor: Colors.black54,
                title: 'Municipality', subtitle: 'Laoag City',
                onTap: () {},
              ),

              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),

              // NOTIFICATIONS
              _buildSectionHeader('Notifications'),
              _buildDrawerToggleRow(
                icon: Icons.notifications_outlined,
                title: 'Alert Notifications',
                value: _alertNotificationsOn,
                activeColor: primaryRed,
                onChanged: (val) => setState(() => _alertNotificationsOn = val),
              ),
              _buildDrawerDivider(),
              _buildDrawerToggleRow(
                icon: Icons.volume_up_outlined,
                title: 'Sound Alerts',
                value: _soundAlertsOn,
                activeColor: primaryRed,
                onChanged: (val) => setState(() => _soundAlertsOn = val),
              ),

              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),

              // PRIVACY
              _buildSectionHeader('Privacy'),
              _buildDrawerRow(
                icon: Icons.shield_outlined, iconColor: Colors.black54,
                title: 'App Permissions', subtitle: 'Location, camera, mic',
                onTap: () {},
              ),

              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              const SizedBox(height: 16),

              // Log Out
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
                    width: double.infinity, height: 50,
                    decoration: BoxDecoration(
                      color: primaryRed, borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: primaryRed.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3))],
                    ),
                    child: const Center(
                      child: Text('Log Out', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.4)),
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

  // ── Drawer helpers ────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      child: Text(label.toUpperCase(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey, letterSpacing: 0.8)),
    );
  }

  Widget _buildDrawerRow({
    required IconData icon, required Color iconColor,
    required String title, required String subtitle,
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
    required IconData icon, required String title,
    required bool value, required Color activeColor,
    required ValueChanged<bool> onChanged,
  }) {
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
      color: primaryRed,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, bottom: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Iloco-Alisto', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
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

  // ── Active Alerts ─────────────────────────────────────────────────────────
  Widget _buildActiveAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Active Alerts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryRed, width: 1),
              ),
              child: Text('${_alerts.length} Localized', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: primaryRed)),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ..._alerts.map((alert) => _buildAlertCard(alert)),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: alert['bgColor'], borderRadius: BorderRadius.circular(12),
        border: Border.all(color: alert['borderColor'], width: 1.2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
            child: Icon(Icons.warning_rounded, color: alert['iconBgColor'], size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert['title'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: alert['titleColor'])),
                const SizedBox(height: 4),
                Text(alert['description'], style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Quick Actions ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _buildActionCard(icon: Icons.monitor_heart_outlined, iconColor: primaryRed, label: 'SOS Emergency', onTap: () {})),
            const SizedBox(width: 14),
            Expanded(child: _buildActionCard(icon: Icons.info_outline_rounded, iconColor: Colors.black87, label: 'Preparedness\nGuide', onTap: () {})),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({required IconData icon, required Color iconColor, required String label, required VoidCallback onTap}) {
    return Material(
      color: Colors.white, borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap, borderRadius: BorderRadius.circular(14),
        splashColor: primaryRed.withOpacity(0.08), highlightColor: primaryRed.withOpacity(0.04),
        child: Container(
          height: 110,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 3))]),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 34, color: iconColor),
            const SizedBox(height: 10),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87, height: 1.3)),
          ]),
        ),
      ),
    );
  }

  // ── Bottom Nav ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.monitor_heart_rounded, 'label': 'Report'},
      {'icon': Icons.location_on_outlined, 'label': 'Map'},
      {'icon': Icons.info_outline_rounded, 'label': 'Evacuation'},
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryRed.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(items[index]['icon'] as IconData, color: isSelected ? primaryRed : Colors.grey, size: 24),
                    const SizedBox(height: 2),
                    Text(items[index]['label'] as String,
                        style: TextStyle(fontSize: 10, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400, color: isSelected ? primaryRed : Colors.grey)),
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
    if (index == 0) return;
    if (index == 1) { Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportIncidentScreen())); return; }
    if (index == 2) { Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen())); return; }
    if (index == 3) { Navigator.push(context, MaterialPageRoute(builder: (context) => const EvacuationCentersScreen())); return; }
    setState(() => _selectedIndex = index);
  }
}