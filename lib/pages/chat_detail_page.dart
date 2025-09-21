import 'package:chanai_mobile/db/database_helper.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget {
  final int chatId;
  const ChatDetailPage({super.key, required this.chatId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final msgs = await DatabaseHelper.instance.fetchMessages(widget.chatId);
    setState(() => _messages = msgs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1F23),
      appBar: AppBar(
        title: const Text("Saved Conversation",
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2F3339),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final msg = _messages[index];
          final isUser = msg["role"] == "user";
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.blueAccent : Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                msg["text"] ?? "",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
