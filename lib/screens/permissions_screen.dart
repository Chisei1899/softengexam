import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class PermissionsScreen extends StatefulWidget {
  final String email;
  final String municipality;
  final String password;
  final String phone;

  const PermissionsScreen({
    super.key,
    required this.email,
    required this.municipality,
    required this.password,
    required this.phone,
  });

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  static const Color primaryRed = Color(0xFFB71C1C);
  static const Color lightGray = Color(0xFFF2F2F2);

  // null = not yet chosen, true = allowed, false = denied
  Map<String, bool?> _permissionStates = {
    'Location': null,
    'Notifications': null,
    'Camera': null,
    'Microphone': null,
  };

  // Icons for each permission
  final Map<String, IconData> _permissionIcons = {
    'Location': Icons.location_on_outlined,
    'Notifications': Icons.notifications_outlined,
    'Camera': Icons.camera_alt_outlined,
    'Microphone': Icons.mic_outlined,
  };

  // Description for each permission
  final Map<String, String> _permissionDescriptions = {
    'Location': 'To send you alerts relevant to your area',
    'Notifications': 'To alert you of nearby disasters in real time',
    'Camera': 'To report incidents with photo evidence',
    'Microphone': 'To submit audio reports of emergencies',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              _buildLogoSection(),
              const SizedBox(height: 32),
              _buildPermissionsCard(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Logo Section ──────────────────────────────────────────────────────────
  Widget _buildLogoSection() {
    return Column(
      children: [
        Image.asset(
          'assets/images/ilocos_logo.png',
          width: 320,
          height: 200,
          fit: BoxFit.contain,
        ),
        const Text(
          'Disaster Warning & Reporting',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Ilocos Region, Philippines',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }

  // ── Permissions Card ──────────────────────────────────────────────────────
  Widget _buildPermissionsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          const Text(
            'App Permissions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Iloco Listo needs the following permissions to keep you safe.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          // Permission rows
          ..._permissionStates.keys.map(
                (key) => _buildPermissionRow(key),
          ),

          const SizedBox(height: 28),

          // Continue button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Single Permission Row ─────────────────────────────────────────────────
  Widget _buildPermissionRow(String permission) {
    final state = _permissionStates[permission];
    final bool isAllowed = state == true;
    final bool isDenied = state == false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Permission label + icon
          Row(
            children: [
              Icon(
                _permissionIcons[permission],
                size: 20,
                color: Colors.black87,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    permission,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    _permissionDescriptions[permission]!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Status bar (shown after a choice is made) + Allow/Deny buttons
          if (state != null) ...[
            _buildStatusBar(isAllowed),
            const SizedBox(height: 8),
          ],

          // Allow / Deny buttons
          Row(
            children: [
              // Allow button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _permissionStates[permission] = true);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 42,
                    decoration: BoxDecoration(
                      color: isAllowed
                          ? const Color(0xFF2E7D32)
                          : Colors.white,
                      border: Border.all(
                        color: isAllowed
                            ? const Color(0xFF2E7D32)
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          size: 16,
                          color: isAllowed ? Colors.white : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Allow',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isAllowed ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Deny button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _permissionStates[permission] = false);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 42,
                    decoration: BoxDecoration(
                      color: isDenied ? primaryRed : Colors.white,
                      border: Border.all(
                        color: isDenied ? primaryRed : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          size: 16,
                          color: isDenied ? Colors.white : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Deny',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDenied ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Status Bar ────────────────────────────────────────────────────────────
  Widget _buildStatusBar(bool isAllowed) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 36,
      decoration: BoxDecoration(
        color: isAllowed
            ? const Color(0xFFE8F5E9) // light green bg
            : const Color(0xFFFFEBEE), // light red bg
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAllowed
              ? const Color(0xFF2E7D32) // dark green border
              : primaryRed,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isAllowed ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isAllowed ? const Color(0xFF2E7D32) : primaryRed,
          ),
          const SizedBox(width: 6),
          Text(
            isAllowed ? 'Allowed' : 'Denied',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isAllowed ? const Color(0xFF2E7D32) : primaryRed,
            ),
          ),
        ],
      ),
    );
  }

  // ── Actions ───────────────────────────────────────────────────────────────
  void _onContinue() {
    debugPrint(
      'Account ready → '
          'email: ${widget.email}, '
          'municipality: ${widget.municipality}, '
          'phone: ${widget.phone}, '
          'permissions: $_permissionStates',
    );

    // ✅ Go directly to Home — stack fully cleared
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
    );
  }
}