import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'home_screen.dart';
import 'report_incident_screen.dart';
import 'evacuation_centers_screen.dart';
import 'login_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const Color primaryRed = Color(0xFFB71C1C);
  int _selectedIndex = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _landslideMarkers = [
    {'lat': 17.8956, 'lng': 120.6199},
    {'lat': 17.5824, 'lng': 120.3847},
    {'lat': 17.4014, 'lng': 120.4506},
  ];

  final List<Map<String, dynamic>> _evacuationMarkers = [
    {'lat': 18.1975, 'lng': 120.5932},
    {'lat': 17.7430, 'lng': 120.4560},
    {'lat': 17.5200, 'lng': 120.3900},
  ];

  final List<Map<String, dynamic>> _floodMarkers = [
    {'lat': 18.0700, 'lng': 120.5500},
    {'lat': 17.9600, 'lng': 120.6100},
    {'lat': 17.6500, 'lng': 120.4100},
  ];

  final List<Map<String, dynamic>> _safezoneMarkers = [
    {'lat': 18.1700, 'lng': 120.5700},
    {'lat': 17.7200, 'lng': 120.4400},
    {'lat': 17.4500, 'lng': 120.4600},
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
            child: Stack(
              children: [
                FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(17.8, 120.52),
                    initialZoom: 9.5,
                    minZoom: 8.0,
                    maxZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.ilocos.ilocoalisto',
                    ),
                    MarkerLayer(
                      markers: [
                        ..._buildMarkers(
                          _landslideMarkers,
                          Icons.warning_rounded,
                          const Color(0xFFFF9800),
                          Colors.white,
                        ),
                        ..._buildMarkers(
                          _evacuationMarkers,
                          Icons.local_hospital_outlined,
                          const Color(0xFF1565C0),
                          Colors.white,
                        ),
                        ..._buildMarkers(
                          _floodMarkers,
                          Icons.water,
                          primaryRed,
                          Colors.white,
                        ),
                        ..._buildMarkers(
                          _safezoneMarkers,
                          Icons.shield_outlined,
                          const Color(0xFF2E7D32),
                          Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildLegend(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Profile Drawer ────────────────────────────────────────────────────────
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
            Image.asset(
              'assets/images/ilocos_logo.png',
              width: 160,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            const Divider(
                indent: 32, endIndent: 32,
                color: Color(0xFFEEEEEE), thickness: 1),
            const SizedBox(height: 24),

            // Avatar
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFFFCDD2),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEF9A9A), width: 2),
              ),
              child: const Center(
                child: Text(
                  'JD',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB71C1C),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text('Jane Doe',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87)),
            const SizedBox(height: 6),
            const Text('jane_doe@gmail.com',
                style: TextStyle(fontSize: 13, color: Colors.black54)),
            const SizedBox(height: 4),
            const Text('+63 912 345 6789',
                style: TextStyle(fontSize: 13, color: Colors.black54)),
            const SizedBox(height: 4),
            const Text('Brgy. 1, Laoag City, Ilocos Norte',
                style: TextStyle(fontSize: 13, color: Colors.black54)),
            const SizedBox(height: 24),
            const Divider(
                indent: 32, endIndent: 32,
                color: Color(0xFFEEEEEE), thickness: 1),
            const Spacer(),

            // Settings button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  // TODO: Navigate to Settings
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: Colors.grey.shade300, width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings_outlined,
                          size: 20, color: Colors.black54),
                      SizedBox(width: 8),
                      Text('Settings',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Log Out button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                        (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryRed,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: primaryRed.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.4,
                      ),
                    ),
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

  // ── Build marker list ─────────────────────────────────────────────────────
  List<Marker> _buildMarkers(
      List<Map<String, dynamic>> points,
      IconData icon,
      Color bgColor,
      Color iconColor,
      ) {
    return points.map((p) {
      return Marker(
        point: LatLng(p['lat'], p['lng']),
        width: 36,
        height: 36,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: bgColor.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
      );
    }).toList();
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: primaryRed,
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
                'Iloco-Alisto',
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
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
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

  // ── Map Legend ────────────────────────────────────────────────────────────
  Widget _buildLegend() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Map Legend',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                        Icons.warning_rounded,
                        const Color(0xFFFF9800),
                        'Landslide'),
                    const SizedBox(height: 8),
                    _buildLegendItem(Icons.water, primaryRed, 'Flood'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                        Icons.local_hospital_outlined,
                        const Color(0xFF1565C0),
                        'Evacuation'),
                    const SizedBox(height: 8),
                    _buildLegendItem(
                        Icons.shield_outlined,
                        const Color(0xFF2E7D32),
                        'Safezone'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(IconData icon, Color color, String label) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
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
                      horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primaryRed.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[index]['icon'] as IconData,
                        color: isSelected ? primaryRed : Colors.grey,
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
                          color: isSelected ? primaryRed : Colors.grey,
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

  void _onNavTap(int index) {
    if (index == 2) return;
    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
      );
      return;
    }
    if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => const ReportIncidentScreen()));
      return;
    }
    if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => const EvacuationCentersScreen()));
      return;
    }
  }
}