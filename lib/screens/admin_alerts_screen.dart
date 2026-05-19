import 'package:flutter/material.dart';
import 'admin_home_screen.dart';
import 'admin_reports_screen.dart';

class AdminAlertsScreen extends StatefulWidget {
  const AdminAlertsScreen({super.key});

  @override
  State<AdminAlertsScreen> createState() => _AdminAlertsScreenState();
}

class _AdminAlertsScreenState extends State<AdminAlertsScreen> {
  static const Color adminPurple = Color(0xFF4A3AFF);
  static const Color primaryRed = Color(0xFFB71C1C);
  int _selectedIndex = 2; // Alerts is index 2

  // ── Alert data ────────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _alerts = [
    {
      'title': 'Red Rainfall Warning',
      'issued': 'Issued: 10 mins ago',
      'target': 'All Citizens (Push + SMS)',
      'targetColor': Color(0xFFB71C1C),
      'status': 'Active',
      'bgColor': Color(0xFFFFEBEE),
      'borderColor': Color(0xFFE57373),
      'iconBgColor': Color(0xFFB71C1C),
    },
    {
      'title': 'Orange Wind Signal',
      'issued': 'Issued: 2 hours ago',
      'target': 'App Users Only',
      'targetColor': Color(0xFFE65100),
      'status': 'Active',
      'bgColor': Color(0xFFFFF3E0),
      'borderColor': Color(0xFFFFB74D),
      'iconBgColor': Color(0xFFE65100),
    },
    {
      'title': 'Yellow Thunderstorm Advisory',
      'issued': 'Issued: 5 hours ago',
      'target': 'App Users Only',
      'targetColor': Color(0xFFF57F00),
      'status': 'Active',
      'bgColor': Color(0xFFFFFDE7),
      'borderColor': Color(0xFFFFD54F),
      'iconBgColor': Color(0xFFF9A825),
    },
    {
      'title': 'Routine Check',
      'issued': 'Issued: Yesterday',
      'target': 'All Citizens',
      'targetColor': Color(0xFFAAAAAA),
      'status': 'Ended',
      'bgColor': Color(0xFFF5F5F5),
      'borderColor': Color(0xFFE0E0E0),
      'iconBgColor': Color(0xFFBDBDBD),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeCount = _alerts.where((a) => a['status'] == 'Active').length;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Page heading + add button ───────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Broadcast Alerts',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Manage active localized warnings',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      // ── Red "+" add button ──────────────────────────
                      GestureDetector(
                        onTap: () {
                          // TODO: Create new alert
                        },
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: primaryRed,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: primaryRed.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Alert cards ─────────────────────────────────────
                  ..._alerts.asMap().entries.map(
                        (entry) => _buildAlertCard(entry.key, entry.value),
                  ),
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
            onTap: () {
              // TODO: Open drawer
            },
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

  // ── Alert Card ────────────────────────────────────────────────────────────
  Widget _buildAlertCard(int index, Map<String, dynamic> alert) {
    final bool isActive = alert['status'] == 'Active';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: alert['bgColor'],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: alert['borderColor'],
          width: 1.2,
        ),
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
        children: [
          // ── Icon + title + status badge ─────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Warning triangle icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (alert['iconBgColor'] as Color).withOpacity(
                    isActive ? 1.0 : 0.4,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.white.withOpacity(isActive ? 1.0 : 0.7),
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              // Title + issued time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert['title'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isActive ? Colors.black87 : Colors.black38,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      alert['issued'],
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? Colors.black54 : Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Active / Ended badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isActive
                        ? Colors.grey.shade300
                        : Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: Text(
                  alert['status'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.black87 : Colors.black38,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(height: 1, color: (alert['borderColor'] as Color).withOpacity(0.5)),
          const SizedBox(height: 10),

          // ── Target + Edit/Cancel row ────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Target label
              Row(
                children: [
                  Text(
                    'Target: ',
                    style: TextStyle(
                      fontSize: 13,
                      color: isActive ? Colors.black54 : Colors.black26,
                    ),
                  ),
                  Text(
                    alert['target'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isActive
                          ? alert['targetColor']
                          : Colors.black26,
                    ),
                  ),
                ],
              ),

              // Edit/Cancel button
              GestureDetector(
                onTap: () {
                  // TODO: Edit or cancel alert
                },
                child: Text(
                  'Edit/Cancel >',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isActive ? primaryRed : Colors.black26,
                  ),
                ),
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

  void _onNavTap(int index) {
    if (index == 2) return; // already on Alerts
    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
            (route) => false,
      );
      return;
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminReportsScreen()),
      );
      return;
    }
  }
}
