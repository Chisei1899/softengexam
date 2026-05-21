import 'package:flutter/material.dart';
import 'report_incident_screen.dart';
import 'map_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class EvacuationCentersScreen extends StatefulWidget {
  const EvacuationCentersScreen({super.key});

  @override
  State<EvacuationCentersScreen> createState() => _EvacuationCentersScreenState();
}

class _EvacuationCentersScreenState extends State<EvacuationCentersScreen> {
  static const Color primaryRed = Color(0xFFB71C1C);
  int _selectedIndex = 3;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _centers = const [
    {
      'name': 'Laoag City Centennial Arena',
      'distance': '1.2 km away',
      'capacity': 450,
      'maxCapacity': 1000,
      'status': 'Open',
    },
    {
      'name': 'Ilocos Norte National Highschool',
      'distance': '3.5 km away',
      'capacity': 500,
      'maxCapacity': 500,
      'status': 'Full',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF2F2F2),
      endDrawer: _buildProfileDrawer(),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Evacuation Centers',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 4),
                  const Text('Find the nearest safe zones in your area.',
                      style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.4)),
                  const SizedBox(height: 20),
                  ..._centers.map((center) => _buildCenterCard(center)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Profile Drawer (citizen — red theme) ──────────────────────────────────
  Widget _buildProfileDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Image.asset('assets/images/ilocos_logo.png', width: 160, height: 100, fit: BoxFit.contain),
            const SizedBox(height: 8),
            const Divider(indent: 32, endIndent: 32, color: Color(0xFFEEEEEE), thickness: 1),
            const SizedBox(height: 24),
            Container(
              width: 90, height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFFFCDD2), shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEF9A9A), width: 2),
              ),
              child: const Center(
                child: Text('JD',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Color(0xFFB71C1C))),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Jane Doe',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87)),
            const SizedBox(height: 6),
            const Text('jane_doe@gmail.com', style: TextStyle(fontSize: 13, color: Colors.black54)),
            const SizedBox(height: 4),
            const Text('+63 912 345 6789', style: TextStyle(fontSize: 13, color: Colors.black54)),
            const SizedBox(height: 4),
            const Text('Brgy. 1, Laoag City, Ilocos Norte',
                style: TextStyle(fontSize: 13, color: Colors.black54)),
            const SizedBox(height: 24),
            const Divider(indent: 32, endIndent: 32, color: Color(0xFFEEEEEE), thickness: 1),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.settings_outlined, size: 20, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Settings', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                  ]),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                },
                child: Container(
                  width: double.infinity, height: 50,
                  decoration: BoxDecoration(
                    color: primaryRed, borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: primaryRed.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3))],
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
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: primaryRed,
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
              Text('Iloco-Alisto',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
              SizedBox(height: 2),
              Text('Laoag City, Ilocos Norte',
                  style: TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w400)),
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

  // ── Center Card ───────────────────────────────────────────────────────────
  Widget _buildCenterCard(Map<String, dynamic> center) {
    final bool isOpen = center['status'] == 'Open';
    final int capacity = center['capacity'];
    final int maxCapacity = center['maxCapacity'];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(center['name'],
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isOpen ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isOpen ? const Color(0xFF2E7D32) : primaryRed, width: 1),
                ),
                child: Text(center['status'],
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                        color: isOpen ? const Color(0xFF2E7D32) : primaryRed)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 3),
              Text(center['distance'], style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Capacity: ',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  children: [
                    TextSpan(text: '$capacity/$maxCapacity',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text('Get Directions >',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: primaryRed)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Bottom Nav ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded,          'label': 'Home'},
      {'icon': Icons.monitor_heart_rounded, 'label': 'Report'},
      {'icon': Icons.location_on_outlined,  'label': 'Map'},
      {'icon': Icons.info_outline_rounded,  'label': 'Evac'},
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
                onTap: () {
                  if (index == 3) return;
                  if (index == 0) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
                    return;
                  }
                  if (index == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ReportIncidentScreen()));
                    return;
                  }
                  if (index == 2) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MapScreen()));
                    return;
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryRed.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(items[index]['icon'] as IconData,
                          color: isSelected ? primaryRed : Colors.grey, size: 24),
                      const SizedBox(height: 2),
                      Text(items[index]['label'] as String,
                          style: TextStyle(fontSize: 10,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                              color: isSelected ? primaryRed : Colors.grey)),
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
}