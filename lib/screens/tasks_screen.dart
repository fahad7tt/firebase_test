import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Today',
      'color': const Color(0xFF22C55E),
      'tasks': [
        {'title': '10 min Running', 'done': true},
        {'title': 'Coffee Time & Reading', 'done': true},
        {'title': '15 Push ups', 'done': false},
        {'title': '20 Squats', 'done': false},
        {'title': '20 sit-ups', 'done': false},
      ],
    },
    {
      'title': 'Tomorrow',
      'color': const Color(0xFF8B92B0), // or grey
      'tasks': [
        {'title': 'Lose 50 kg', 'done': false},
        {'title': 'Reach 50 Push ups', 'done': false},
        {'title': 'Reach 10 min Rope Skipping', 'done': false},
        {'title': 'Reach 100 Squats', 'done': false},
      ],
    },
    {
      'title': 'May 20, 2021',
      'color': const Color(0xFF8B92B0),
      'tasks': [
        {'title': 'Lose 50 kg', 'done': false},
        {'title': 'Reach 50 Push ups', 'done': false},
        {'title': 'Reach 10 min Rope Skipping', 'done': false},
      ],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF161929) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final iconColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final borderColor = isDark ? const Color(0xFF3D4466) : const Color(0xFFDDE1EE);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 18, color: iconColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: textColor, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  hintStyle: TextStyle(color: isDark ? const Color(0xFF8B92B0) : const Color(0xFF9CA3AF)),
                  border: InputBorder.none,
                ),
              )
            : Text('Tasks', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: iconColor,
              size: 24,
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 90),
        itemCount: _sections.length,
        itemBuilder: (context, sectionIdx) {
          final section = _sections[sectionIdx];
          final sectionTitleColor = section['color'] as Color;
          final sectionTasks = section['tasks'] as List<Map<String, dynamic>>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 16, 28, 8),
                child: Text(
                  section['title'],
                  style: TextStyle(
                    color: sectionTitleColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...sectionTasks.map((task) {
                final isDone = task['done'] as bool;
                return InkWell(
                  onTap: () {
                    setState(() => task['done'] = !isDone);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: isDone ? const Color(0xFF22C55E) : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDone ? const Color(0xFF22C55E) : borderColor,
                              width: 1.5,
                            ),
                          ),
                          child: isDone
                              ? const Icon(Icons.check, color: Colors.white, size: 14)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            task['title'],
                            style: TextStyle(
                              color: isDone ? (isDark ? const Color(0xFF8B92B0) : const Color(0xFF9CA3AF)) : textColor,
                              fontSize: 15,
                              decoration: isDone ? TextDecoration.lineThrough : null,
                              decorationColor: isDark ? const Color(0xFF8B92B0) : const Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: isDark ? Colors.white : const Color(0xFF1F2937),
        elevation: 2,
        child: Icon(
          Icons.add,
          color: isDark ? const Color(0xFF1F2937) : Colors.white,
          size: 28,
        ),
      ),
    );
  }
}

