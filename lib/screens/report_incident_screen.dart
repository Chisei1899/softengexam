import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  State<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  static const Color primaryRed = Color(0xFFB71C1C);
  static const Color selectedBlue = Color(0xFF1565C0);
  static const Color hintColor = Color(0xFFAAAAAA);

  String _selectedIncident = 'Flood';
  bool _alertNotificationsOn = true;
  bool _soundAlertsOn = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<Map<String, dynamic>> _incidentTypes = [
    {'label': 'Flood', 'icon': Icons.water},
    {'label': 'Landslide', 'icon': Icons.landscape},
  ];

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                  const Text('Report Incident', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 4),
                  const Text('Help the community by reporting hazards in your area.', style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.4)),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Incident Type'),
                  const SizedBox(height: 10),
                  _buildIncidentTypeRow(),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Location'),
                  const SizedBox(height: 8),
                  _buildLocationField(),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Description'),
                  const SizedBox(height: 8),
                  _buildDescriptionField(),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Photo Evidence'),
                  const SizedBox(height: 8),
                  _buildPhotoUpload(),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity, height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false),
                      style: ElevatedButton.styleFrom(backgroundColor: primaryRed, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 2),
                      child: const Text('Submit Report', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Citizen Settings Drawer ───────────────────────────────────────────────
  Widget _buildCitizenDrawer() {
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
                    decoration: BoxDecoration(color: const Color(0xFFFFCDD2), shape: BoxShape.circle, border: Border.all(color: const Color(0xFFEF9A9A), width: 2)),
                    child: const Center(child: Text('JD', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: primaryRed))),
                  ),
                  const SizedBox(height: 10),
                  const Text('Jane Doe', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87)),
                  const SizedBox(height: 4),
                  const Text('jane_doe@gmail.com', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 2),
                  const Text('+63 912 345 6789', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 2),
                  const Text('Brgy. 1, Laoag City, Ilocos Norte', style: TextStyle(fontSize: 12, color: Colors.black54)),
                ]),
              ),
              const SizedBox(height: 20),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              _buildSectionHeaderLabel('Account'),
              _buildDrawerRow(icon: Icons.person_outline, iconColor: Colors.black54, title: 'Edit Profile', subtitle: 'Name, phone, address', onTap: () {}),
              _buildDrawerDivider(),
              _buildDrawerRow(icon: Icons.lock_outline, iconColor: Colors.black54, title: 'Change Password', subtitle: 'Update credentials', onTap: () {}),
              _buildDrawerDivider(),
              _buildDrawerRow(icon: Icons.location_on_outlined, iconColor: Colors.black54, title: 'Municipality', subtitle: 'Laoag City', onTap: () {}),
              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              _buildSectionHeaderLabel('Notifications'),
              _buildDrawerToggleRow(icon: Icons.notifications_outlined, title: 'Alert Notifications', value: _alertNotificationsOn, activeColor: primaryRed, onChanged: (val) => setState(() => _alertNotificationsOn = val)),
              _buildDrawerDivider(),
              _buildDrawerToggleRow(icon: Icons.volume_up_outlined, title: 'Sound Alerts', value: _soundAlertsOn, activeColor: primaryRed, onChanged: (val) => setState(() => _soundAlertsOn = val)),
              const SizedBox(height: 4),
              const Divider(indent: 24, endIndent: 24, color: Color(0xFFEEEEEE), thickness: 1),
              _buildSectionHeaderLabel('Privacy'),
              _buildDrawerRow(icon: Icons.shield_outlined, iconColor: Colors.black54, title: 'App Permissions', subtitle: 'Location, camera, mic', onTap: () {}),
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
                    decoration: BoxDecoration(color: primaryRed, borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: primaryRed.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3))]),
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

  Widget _buildSectionHeaderLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      child: Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey, letterSpacing: 0.8)),
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
            child: Container(padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.menu, color: Colors.white, size: 22)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black87));
  }

  Widget _buildIncidentTypeRow() {
    return Row(
      children: _incidentTypes.map((type) {
        final isSelected = _selectedIncident == type['label'];
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedIncident = type['label']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: type['label'] == 'Flood' ? 10 : 0),
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? selectedBlue : Colors.grey.shade300, width: isSelected ? 2 : 1.2),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(type['icon'] as IconData, size: 26, color: isSelected ? selectedBlue : Colors.grey),
                const SizedBox(height: 6),
                Text(type['label'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? selectedBlue : Colors.black54)),
              ]),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLocationField() {
    return TextField(
      controller: _locationController,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      decoration: InputDecoration(
        hintText: 'E.g. Brgy. 1 San Lorenzo', hintStyle: const TextStyle(color: hintColor, fontSize: 14),
        prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
        filled: true, fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: selectedBlue, width: 1.5)),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionController, maxLines: 5,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      decoration: InputDecoration(
        hintText: 'Describe the severity and landmarks nearby...', hintStyle: const TextStyle(color: hintColor, fontSize: 14),
        filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: selectedBlue, width: 1.5)),
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity, height: 120,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.camera_alt_outlined, size: 36, color: Colors.grey.shade500),
          const SizedBox(height: 8),
          Text('Tap to Upload Photo', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
        ]),
      ),
    );
  }
}