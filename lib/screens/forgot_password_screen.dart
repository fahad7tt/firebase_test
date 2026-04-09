import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendReset() {
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() { _isLoading = false; _emailSent = true; });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF22273B) : Colors.white;
    final fieldBg = isDark ? const Color(0xFF2C3250) : Colors.white;
    final borderColor = isDark ? const Color(0xFF3D4466) : const Color(0xFFDDE1EE);
    final labelColor = isDark ? const Color(0xFF8B92B0) : const Color(0xFF9CA3AF);
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final headColor = isDark ? Colors.white : const Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 18, color: headColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Forgot Password!',
          style: TextStyle(color: headColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _emailSent ? _successView(bg, textColor, labelColor) : _formView(bg, fieldBg, borderColor, labelColor, textColor),
      ),
    );
  }

  Widget _formView(Color bg, Color fieldBg, Color borderColor, Color labelColor, Color textColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            'Enter the email address associated\nwith your account.',
            style: TextStyle(color: labelColor, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: textColor, fontSize: 14),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: labelColor, fontSize: 14),
              filled: true,
              fillColor: fieldBg,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
                borderSide: const BorderSide(color: Color(0xFF637DFF), width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _sendReset,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF637DFF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: _isLoading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Back to login', style: TextStyle(color: labelColor, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _successView(Color bg, Color textColor, Color labelColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF637DFF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mark_email_read_outlined, color: Color(0xFF637DFF), size: 36),
          ),
          const SizedBox(height: 24),
          Text(
            'Check your inbox',
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'We sent a reset link to\n${_emailController.text}',
            textAlign: TextAlign.center,
            style: TextStyle(color: labelColor, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF637DFF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Back to Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
