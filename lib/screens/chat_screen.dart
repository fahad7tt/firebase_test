import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String avatar;
  final bool online;

  const ChatScreen({
    super.key,
    required this.name,
    required this.avatar,
    required this.online,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hey! How are you doing?', 'isMine': false, 'time': '09:30'},
    {'text': 'I\'m doing great, thanks! Working on that new feature.', 'isMine': true, 'time': '09:31'},
    {'text': 'Awesome! Can you send me the design files when you\'re done?', 'isMine': false, 'time': '09:41'},
    {'text': 'Sure! I\'ll send them over by end of day.', 'isMine': true, 'time': '09:42'},
    {'text': 'Perfect, thanks! 🙌', 'isMine': false, 'time': '09:43'},
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'text': _messageController.text.trim(),
        'isMine': true,
        'time': '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      });
    });
    _messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF161929) : const Color(0xFFF9FAFF);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final subTextColor = isDark ? const Color(0xFF8888AA) : Colors.grey.shade600;
    final inputBg = isDark ? const Color(0xFF1E2235) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2E3250) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(widget.avatar, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                if (widget.online)
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? const Color(0xFF161929) : Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                  widget.online ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: widget.online ? const Color(0xFF22C55E) : subTextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.videocam_outlined, color: textColor), onPressed: () {}),
          IconButton(icon: Icon(Icons.call_outlined, color: textColor), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert, color: textColor), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessage(msg, textColor, subTextColor, isDark);
              },
            ),
          ),
          _buildInputBar(inputBg, textColor, subTextColor, isDark),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg, Color textColor, Color subTextColor, bool isDark) {
    final isMine = msg['isMine'] as bool;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMine) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2E3250) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(widget.avatar, style: const TextStyle(fontSize: 16))),
            ),
            const SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isMine
                      ? const LinearGradient(
                          colors: [Color(0xFF637DFF), Color(0xFF8B5CF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isMine ? null : (isDark ? const Color(0xFF1E2235) : Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isMine ? 16 : 4),
                    bottomRight: Radius.circular(isMine ? 4 : 16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  msg['text'],
                  style: TextStyle(
                    color: isMine ? Colors.white : textColor,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                msg['time'],
                style: TextStyle(color: subTextColor, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(Color inputBg, Color textColor, Color subTextColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2235) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file, color: subTextColor),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: subTextColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDark ? const Color(0xFF161929) : const Color(0xFFF4F5F9),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF637DFF), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
