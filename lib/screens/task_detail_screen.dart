import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final List<Map<String, dynamic>> _subtasks = [
    {'title': 'Research phase', 'done': true},
    {'title': 'Wireframing', 'done': true},
    {'title': 'Create mockups', 'done': false},
    {'title': 'User testing', 'done': false},
    {'title': 'Final delivery', 'done': false},
  ];

  final List<Map<String, dynamic>> _comments = [
    {
      'author': 'Sarah J.',
      'avatar': '👩‍💼',
      'text': 'Great progress on this! The wireframes look amazing.',
      'time': '2 hours ago',
    },
    {
      'author': 'You',
      'avatar': '😊',
      'text': 'Thanks! Working on the mockups now.',
      'time': '1 hour ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF161929) : const Color(0xFFF9FAFF);
    final cardBg = isDark ? const Color(0xFF1E2235) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final subTextColor = isDark ? const Color(0xFF8888AA) : Colors.grey.shade600;
    final taskColor = widget.task['color'] as Color;

    final completedCount = _subtasks.where((s) => s['done'] == true).length;
    final totalCount = _subtasks.length;

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // Beautiful Hero Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: taskColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [taskColor, taskColor.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(widget.task['icon'] as IconData, size: 12, color: Colors.white),
                              const SizedBox(width: 5),
                              Text(
                                widget.task['category'],
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.task['title'],
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Body content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info row
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.calendar_today,
                        label: widget.task['dueDate'],
                        color: taskColor,
                        bg: taskColor.withOpacity(0.1),
                        textColor: taskColor,
                      ),
                      const SizedBox(width: 10),
                      _buildInfoChip(
                        icon: Icons.flag_outlined,
                        label: widget.task['priority'],
                        color: _getPriorityColor(widget.task['priority']),
                        bg: _getPriorityColor(widget.task['priority']).withOpacity(0.1),
                        textColor: _getPriorityColor(widget.task['priority']),
                      ),
                      const SizedBox(width: 10),
                      _buildInfoChip(
                        icon: Icons.person_outline,
                        label: 'You',
                        color: const Color(0xFF637DFF),
                        bg: const Color(0xFF637DFF).withOpacity(0.1),
                        textColor: const Color(0xFF637DFF),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Progress
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Progress', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(
                              '$completedCount/$totalCount subtasks',
                              style: TextStyle(color: subTextColor, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: completedCount / totalCount,
                            backgroundColor: isDark ? const Color(0xFF2E3250) : Colors.grey.shade100,
                            valueColor: AlwaysStoppedAnimation(taskColor),
                            minHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${((completedCount / totalCount) * 100).round()}% complete',
                            style: TextStyle(color: taskColor, fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Subtasks
                  Text('Subtasks', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: _subtasks.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final subtask = entry.value;
                        final isDone = subtask['done'] as bool;
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => setState(() => subtask['done'] = !isDone),
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: isDone ? taskColor : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: isDone ? taskColor : (isDark ? const Color(0xFF2E3250) : Colors.grey.shade300),
                                          width: 2,
                                        ),
                                      ),
                                      child: isDone ? const Icon(Icons.check, color: Colors.white, size: 13) : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        subtask['title'],
                                        style: TextStyle(
                                          color: isDone ? subTextColor : textColor,
                                          decoration: isDone ? TextDecoration.lineThrough : null,
                                          decorationColor: subTextColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (idx < _subtasks.length - 1)
                              Divider(
                                height: 1,
                                indent: 50,
                                color: isDark ? const Color(0xFF2E3250) : Colors.grey.shade100,
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Comments
                  Text('Comments', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 12),
                  ..._comments.map((comment) => _buildComment(comment, cardBg, textColor, subTextColor, isDark)),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2235) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () => setState(() => widget.task['done'] = !(widget.task['done'] as bool)),
            icon: Icon(widget.task['done'] == true ? Icons.restart_alt : Icons.check_circle_outline, color: Colors.white),
            label: Text(
              widget.task['done'] == true ? 'Mark as Incomplete' : 'Mark as Complete',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.task['done'] == true ? Colors.grey : taskColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color(0xFFEF4444);
      case 'Medium':
        return const Color(0xFFF97316);
      default:
        return const Color(0xFF22C55E);
    }
  }

  Widget _buildInfoChip({required IconData icon, required String label, required Color color, required Color bg, required Color textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildComment(Map<String, dynamic> comment, Color cardBg, Color textColor, Color subTextColor, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2E3250) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(comment['avatar'], style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(comment['author'], style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 13)),
                    Text(comment['time'], style: TextStyle(color: subTextColor, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(comment['text'], style: TextStyle(color: subTextColor, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
