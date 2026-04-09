import 'package:flutter/material.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
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
    final headColor = isDark ? Colors.white : const Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              size: 18, color: headColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create an Account',
          style: TextStyle(
            color: headColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildField(
                controller: _nameController,
                label: 'Full Name',
                fieldBg: fieldBg,
                borderColor: borderColor,
                labelColor: labelColor,
                textColor: textColor,
              ),
              const SizedBox(height: 14),
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
              _buildField(
                controller: _passwordController,
                label: 'Password',
                obscureText: _obscurePass,
                isPassword: true,
                onToggle: () =>
                    setState(() => _obscurePass = !_obscurePass),
                fieldBg: fieldBg,
                borderColor: borderColor,
                labelColor: labelColor,
                textColor: textColor,
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _confirmController,
                label: 'Confirm Password',
                obscureText: _obscureConfirm,
                isPassword: true,
                onToggle: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                fieldBg: fieldBg,
                borderColor: borderColor,
                labelColor: labelColor,
                textColor: textColor,
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          setState(() => _isLoading = true);
                          Future.delayed(const Duration(milliseconds: 800), () {
                            if (mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()),
                                (r) => false,
                              );
                            }
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF637DFF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          'Create',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: labelColor, fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 4)),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF637DFF),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
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
