import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'permissions_screen.dart';

class SignUpVerifyScreen extends StatefulWidget {
  final String email;
  final String municipality;
  final String password;

  const SignUpVerifyScreen({
    super.key,
    required this.email,
    required this.municipality,
    required this.password,
  });

  @override
  State<SignUpVerifyScreen> createState() => _SignUpVerifyScreenState();
}

class _SignUpVerifyScreenState extends State<SignUpVerifyScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _codeSent = false;

  static const Color primaryRed = Color(0xFFB71C1C);
  static const Color lightGray = Color(0xFFF2F2F2);
  static const Color inputFill = Color(0xFFF0F0F0);
  static const Color hintColor = Color(0xFFAAAAAA);

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

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
              _buildVerifyCard(),
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

  // ── Verify Card ───────────────────────────────────────────────────────────
  Widget _buildVerifyCard() {
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
            'Sign Up',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 20),

          // Phone Number row with Verify button
          _buildFieldLabel('Phone Number'),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phone field
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: '53+ 123 456 7890',
                    hintStyle:
                    const TextStyle(color: hintColor, fontSize: 14),
                    filled: true,
                    fillColor: inputFill,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: primaryRed, width: 1.5),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Verify button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _onVerify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryRed,
                    side: const BorderSide(color: primaryRed, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Verification Code field
          _buildFieldLabel('Verification Code'),
          const SizedBox(height: 6),
          TextField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'Enter the code sent to your number',
              hintStyle: const TextStyle(color: hintColor, fontSize: 14),
              filled: true,
              fillColor: inputFill,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: primaryRed, width: 1.5),
              ),
              // Shows a small checkmark indicator when code is entered
              suffixIcon: _codeController.text.isNotEmpty
                  ? const Icon(Icons.check_circle_outline,
                  color: primaryRed, size: 20)
                  : null,
            ),
            onChanged: (_) => setState(() {}),
          ),

          const SizedBox(height: 24),

          // Create Account button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _onCreateAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Create Account',
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

  // ── Helper ────────────────────────────────────────────────────────────────
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  // ── Actions ───────────────────────────────────────────────────────────────
  void _onVerify() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number.')),
      );
      return;
    }

    if (phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number must be exactly 10 digits.')),
      );
      return;
    }

    // TODO: Send OTP via Firebase / SMS API here
    setState(() => _codeSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification code sent to $phone'),
        backgroundColor: primaryRed,
      ),
    );
    debugPrint('OTP sent to: $phone');
  }

  void _onCreateAccount() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number.')),
      );
      return;
    }

    if (phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number must be exactly 10 digits.')),
      );
      return;
    }

    // ✅ Go straight to Permissions screen — no code check
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PermissionsScreen(
          email: widget.email,
          municipality: widget.municipality,
          password: widget.password,
          phone: phone,
        ),
      ),
    );
  }
}