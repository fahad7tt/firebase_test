import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../main.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? const Color(0xFF1A1F35) : const Color(0xFFF4F6FA);
    final card = isDark ? const Color(0xFF22273B) : Colors.white;
    final title = isDark ? Colors.white : const Color(0xFF1F2937);
    final sub = isDark ? const Color(0xFF8B92B0) : const Color(0xFF9CA3AF);
    final border = isDark ? const Color(0xFF2C3250) : const Color(0xFFEDEFF5);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            color: title,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User card
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: border),
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF637DFF).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: user?.photoURL != null
                        ? ClipOval(
                            child: Image.network(
                              user!.photoURL!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Text('😊', style: TextStyle(fontSize: 28)),
                          ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? 'Fname Lname',
                          style: TextStyle(
                            color: title,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          user?.email ?? 'johndoe@email.com',
                          style: TextStyle(color: sub, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: sub),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Account section
            _sectionLabel('Account', sub),
            _buildGroup(
              [
                _tile(
                  Icons.person_outline,
                  'Edit Profile',
                  title,
                  sub,
                  card,
                  border,
                  onTap: () {},
                ),
                _divider(border),
                _tile(
                  Icons.notifications_outlined,
                  'Notifications',
                  title,
                  sub,
                  card,
                  border,
                  trailing: Switch.adaptive(
                    value: _notifications,
                    activeColor: const Color(0xFF637DFF),
                    onChanged: (v) => setState(() => _notifications = v),
                  ),
                ),
                _divider(border),
                _tile(
                  isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                  'Dark Mode',
                  title,
                  sub,
                  card,
                  border,
                  trailing: Switch.adaptive(
                    value: isDark,
                    activeColor: const Color(0xFF637DFF),
                    onChanged: (_) => MyApp.of(context)?.toggleTheme(),
                  ),
                ),
              ],
              card,
              border,
            ),
            const SizedBox(height: 16),
            // General section
            _sectionLabel('General', sub),
            _buildGroup(
              [
                _tile(
                  Icons.language_outlined,
                  'Language',
                  title,
                  sub,
                  card,
                  border,
                  trailing2: 'English',
                  onTap: () {},
                ),
                _divider(border),
                _tile(
                  Icons.help_outline,
                  'Help & FAQ',
                  title,
                  sub,
                  card,
                  border,
                  onTap: () {},
                ),
                _divider(border),
                _tile(
                  Icons.privacy_tip_outlined,
                  'Privacy Policy',
                  title,
                  sub,
                  card,
                  border,
                  onTap: () {},
                ),
              ],
              card,
              border,
            ),
            const SizedBox(height: 16),
            // Logout
            _buildGroup(
              [
                InkWell(
                  onTap: () async {
                    await _auth.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (_) => false,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFEF4444),
                          size: 20,
                        ),
                        const SizedBox(width: 14),
                        const Text(
                          'Log Out',
                          style: TextStyle(
                            color: Color(0xFFEF4444),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              card,
              border,
            ),
            const SizedBox(height: 30),
            Text('mimo v1.0.0', style: TextStyle(color: sub, fontSize: 12)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label, Color sub) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: sub,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildGroup(List<Widget> children, Color card, Color border) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Column(children: children),
    );
  }

  Widget _divider(Color border) =>
      Divider(height: 1, color: border, indent: 16, endIndent: 0);

  Widget _tile(
    IconData icon,
    String label,
    Color title,
    Color sub,
    Color card,
    Color border, {
    Widget? trailing,
    String? trailing2,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF637DFF), size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null) trailing,
            if (trailing2 != null) ...[
              Text(trailing2, style: TextStyle(color: sub, fontSize: 13)),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 12, color: sub),
            ] else if (trailing == null)
              Icon(Icons.arrow_forward_ios, size: 12, color: sub),
          ],
        ),
      ),
    );
  }
}
