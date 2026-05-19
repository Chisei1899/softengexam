import 'package:flutter/material.dart';
import 'signup_verify_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _selectedMunicipality;

  static const Color primaryRed = Color(0xFFB71C1C);
  static const Color lightGray = Color(0xFFF2F2F2);
  static const Color inputFill = Color(0xFFF0F0F0);
  static const Color hintColor = Color(0xFFAAAAAA);

  // Ilocos Region municipalities
  final List<String> _municipalities = [
    'Laoag City',
    'Batac City',
    'Vigan City',
    'Candon City',
    'San Fernando',
    'Bangui',
    'Bacarra',
    'Badoc',
    'Burgos',
    'Carasi',
    'Currimao',
    'Dingras',
    'Dumalneg',
    'Marcos',
    'Nueva Era',
    'Pagudpud',
    'Paoay',
    'Pasuquin',
    'Piddig',
    'Pinili',
    'San Nicolas',
    'Sarrat',
    'Solsona',
    'Vintar',
    'Cabugao',
    'Caoayan',
    'Galimuyod',
    'Gregorio del Pilar',
    'Lidlidda',
    'Magsingal',
    'Nagbukel',
    'Narvacan',
    'Quirino',
    'Salcedo',
    'San Emilio',
    'San Esteban',
    'San Ildefonso',
    'San Juan',
    'San Vicente',
    'Santa',
    'Santa Catalina',
    'Santa Cruz',
    'Santa Lucia',
    'Santa Maria',
    'Santiago',
    'Sigay',
    'Sinait',
    'Sugpon',
    'Suyo',
    'Tagudin',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              _buildSignUpCard(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Logo Section (same as login) ──────────────────────────────────────────
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
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // ── Sign Up Card ──────────────────────────────────────────────────────────
  Widget _buildSignUpCard() {
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

          // Email
          _buildFieldLabel('Email Address'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _emailController,
            hint: 'sample@gmail.com',
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),

          // Municipality dropdown
          _buildFieldLabel('Municipality'),
          const SizedBox(height: 6),
          _buildMunicipalityDropdown(),

          const SizedBox(height: 16),

          // Password
          _buildFieldLabel('Password'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _passwordController,
            hint: 'At least 6 characters',
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),

          const SizedBox(height: 16),

          // Confirm Password
          _buildFieldLabel('Confirm Password'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _confirmPasswordController,
            hint: 'Re-enter your password',
            obscureText: _obscureConfirm,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),

          const SizedBox(height: 24),

          // Next button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Divider(color: Color(0xFFE0E0E0), thickness: 1),

          const SizedBox(height: 16),

          // Sign In link
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(fontSize: 17, color: Colors.black87),
                ),
                GestureDetector(
                  onTap: () {
                    // Clears the entire navigation stack back to Login
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 17,
                      color: primaryRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Municipality Dropdown ─────────────────────────────────────────────────
  Widget _buildMunicipalityDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: inputFill,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedMunicipality,
        hint: const Text(
          'Enter your municipality',
          style: TextStyle(color: hintColor, fontSize: 14),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        decoration: InputDecoration(
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
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        items: _municipalities
            .map((m) => DropdownMenuItem(value: m, child: Text(m)))
            .toList(),
        onChanged: (value) => setState(() => _selectedMunicipality = value),
      ),
    );
  }

  // ── Helper Widgets ────────────────────────────────────────────────────────
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: hintColor, fontSize: 14),
        filled: true,
        fillColor: inputFill,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: suffixIcon,
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
      ),
    );
  }

  // ── Actions ───────────────────────────────────────────────────────────────
  void _onNext() {
    final email = _emailController.text.trim();
    final municipality = _selectedMunicipality;
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (email.isEmpty || municipality == null || password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters.')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    // ✅ All valid — navigate to phone verification screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpVerifyScreen(
          email: email,
          municipality: municipality,
          password: password,
        ),
      ),
    );
  }
}