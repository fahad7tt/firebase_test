import 'package:flutter/material.dart';
import 'tasks_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const _categories = [
    {'emoji': '🏋️', 'title': 'Sport',    'count': 8,  'color': Color(0xFFFF9B44)},
    {'emoji': '📚', 'title': 'Homework', 'count': 12, 'color': Color(0xFF637DFF)},
    {'emoji': '🧹', 'title': 'Cleaning', 'count': 5,  'color': Color(0xFF8B5CF6)},
    {'emoji': '🛍️', 'title': 'Shopping', 'count': 10, 'color': Color(0xFF14B8A6)},
    {'emoji': '🍕', 'title': 'Food',     'count': 6,  'color': Color(0xFFEF4444)},
    {'emoji': '🎨', 'title': 'Design',   'count': 9,  'color': Color(0xFFEC4899)},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg      = isDark ? const Color(0xFF1A1F35) : const Color(0xFFF4F6FA);
    final card    = isDark ? const Color(0xFF22273B) : Colors.white;
    final title   = isDark ? Colors.white            : const Color(0xFF1F2937);
    final sub     = isDark ? const Color(0xFF8B92B0) : const Color(0xFF9CA3AF);
    final border  = isDark ? const Color(0xFF2C3250) : const Color(0xFFEDEFF5);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Categories', style: TextStyle(color: title, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: title),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        child: GridView.builder(
          itemCount: _categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, i) {
            final cat = _categories[i];
            final color = cat['color'] as Color;
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TasksScreen()),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: border, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(cat['emoji'] as String,
                            style: const TextStyle(fontSize: 26)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cat['title'] as String,
                      style: TextStyle(
                        color: title,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${cat['count']} tasks',
                      style: TextStyle(color: sub, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
