import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'create_account_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-in canceled')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF22273B) : Colors.white;
    final fieldBg = isDark ? const Color(0xFF2C3250) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF3D4466) : const Color(0xFFDDE1EE);
    final labelColor =
        isDark ? const Color(0xFF8B92B0) : const Color(0xFF9CA3AF);
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 70),
              // mimo logo
              Text(
                'mimo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: isDark
                      ? const Color(0xFF4ADE80)
                      : const Color(0xFF1A6B3C),
                  letterSpacing: -2.0,
                ),
              ),
              const SizedBox(height: 48),
              // Email field
              _buildField(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                fieldBg: fieldBg,
                borderColor: borderColor,
                labelColor: labelColor,
                textColor: textColor,
              ),
              const SizedBox(height: 14),
              // Password field
              _buildField(
                controller: _passwordController,
                label: 'Password',
                obscureText: _obscurePassword,
                isPassword: true,
                onToggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                fieldBg: fieldBg,
                borderColor: borderColor,
                labelColor: labelColor,
                textColor: textColor,
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: const Color(0xFF637DFF),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // Login button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF637DFF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              // OR divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: borderColor, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text('OR',
                        style: TextStyle(color: labelColor, fontSize: 13)),
                  ),
                  Expanded(
                    child: Divider(color: borderColor, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              // Google sign-in
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _handleGoogleSignIn,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: fieldBg,
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                              height: 20,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.login, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 36),
              // Sign Up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: labelColor, fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CreateAccountScreen()),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 4),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF637DFF),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool isPassword = false,
    VoidCallback? onToggle,
    required Color fieldBg,
    required Color borderColor,
    required Color labelColor,
    required Color textColor,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(color: textColor, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labelColor, fontSize: 14),
        filled: true,
        fillColor: fieldBg,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Color(0xFF637DFF), width: 1.5),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: labelColor,
                  size: 20,
                ),
                onPressed: onToggle,
              )
            : null,
      ),
    );
  }
}
