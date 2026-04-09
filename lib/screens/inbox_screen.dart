import 'package:flutter/material.dart';
import 'chat_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  static final List<Map<String, dynamic>> _chats = [
    {'emoji': '👩‍💼', 'name': 'Sarah Johnson',  'msg': 'Can you send me the design files?',      'time': '09:41', 'unread': 3,  'online': true},
    {'emoji': '🧑‍💻', 'name': 'Alex Chen',      'msg': 'The task is done! Just pushed it.',       'time': '08:30', 'unread': 0,  'online': true},
    {'emoji': '🎨', 'name': 'Design Team',    'msg': 'Meeting at 3pm today',                     'time': 'Yesterday', 'unread': 5,  'online': false},
    {'emoji': '👩‍🎤', 'name': 'Maria Lopez',    'msg': "Thanks! I'll check it out.",               'time': 'Yesterday', 'unread': 0,  'online': false},
    {'emoji': '⚙️', 'name': 'Dev Team',       'msg': 'Sprint planning is rescheduled',            'time': 'Mon',       'unread': 2,  'online': false},
    {'emoji': '🧑‍🎨', 'name': 'Jake Williams',  'msg': "I've updated the mockups",                 'time': 'Mon',       'unread': 0,  'online': true},
    {'emoji': '👱‍♀️', 'name': 'Anna Smith',     'msg': 'Can we reschedule today?',                 'time': 'Sun',       'unread': 1,  'online': false},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final bg      = isDark ? const Color(0xFF1A1F35) : const Color(0xFFF4F6FA);
    final card    = isDark ? const Color(0xFF22273B) : Colors.white;
    final title   = isDark ? Colors.white            : const Color(0xFF1F2937);
    final sub     = isDark ? const Color(0xFF8B92B0) : const Color(0xFF9CA3AF);
    final divider = isDark ? const Color(0xFF2C3250) : const Color(0xFFEDEFF5);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Inbox', style: TextStyle(color: title, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.search, color: title), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Active contacts row
          SizedBox(
            height: 86,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: _chats.where((c) => c['online'] == true).length + 1,
              itemBuilder: (context, idx) {
                if (idx == 0) {
                  return _buildAddAvatar(sub);
                }
                final online = _chats.where((c) => c['online'] == true).toList();
                return _buildOnlineAvatar(online[idx - 1], sub, isDark);
              },
            ),
          ),
          Divider(height: 1, color: divider),
          // Chat list
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: _chats.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, indent: 76, color: divider),
              itemBuilder: (ctx, i) =>
                  _buildChatTile(ctx, _chats[i], card, title, sub, divider, isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAvatar(Color sub) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF637DFF), width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.add, color: Color(0xFF637DFF), size: 22),
          ),
          const SizedBox(height: 4),
          Text('New', style: TextStyle(color: sub, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildOnlineAvatar(Map<String, dynamic> c, Color sub, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C3250) : const Color(0xFFEDEFF5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                    child: Text(c['emoji'], style: const TextStyle(fontSize: 24))),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? const Color(0xFF1A1F35) : Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            (c['name'] as String).split(' ').first,
            style: TextStyle(color: sub, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(BuildContext ctx, Map<String, dynamic> c, Color card, Color title, Color sub, Color divider, bool isDark) {
    final hasUnread = (c['unread'] as int) > 0;
    return InkWell(
      onTap: () => Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (_) => ChatScreen(
            name: c['name'],
            avatar: c['emoji'],
            online: c['online'],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2C3250) : const Color(0xFFEDEFF5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                      child: Text(c['emoji'], style: const TextStyle(fontSize: 24))),
                ),
                if (c['online'] == true)
                  Positioned(
                    bottom: 2, right: 2,
                    child: Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? const Color(0xFF1A1F35) : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c['name'],
                    style: TextStyle(
                      color: title,
                      fontWeight: hasUnread ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    c['msg'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: sub, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(c['time'],
                    style: TextStyle(
                      color: hasUnread ? const Color(0xFF637DFF) : sub,
                      fontSize: 11,
                    )),
                const SizedBox(height: 5),
                if (hasUnread)
                  Container(
                    width: 20, height: 20,
                    decoration: const BoxDecoration(
                        color: Color(0xFF637DFF), shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '${c['unread']}',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
