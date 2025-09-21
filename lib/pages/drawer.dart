import 'package:flutter/material.dart';
import 'chat_detail_page.dart';

class AppDrawer extends StatelessWidget {
  final List<String> prompts;
  final List<Map<String, dynamic>> savedChats;
  final VoidCallback onNewChat;
  final Function(String) onSelectPrompt;

  const AppDrawer({
    super.key,
    required this.prompts,
    required this.savedChats,
    required this.onNewChat,
    required this.onSelectPrompt,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1E1F23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF2F3339),
              image: DecorationImage(
                image: AssetImage('assets/images/headers.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.blueAccent),
            title: const Text("New Chat",
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              onNewChat();
            },
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: ListView(
              children: [
                if (prompts.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text("Current Chat",
                        style: TextStyle(color: Colors.white70,
                            fontWeight: FontWeight.bold)),
                  ),
                  ...prompts.map((p) => ListTile(
                        leading: const Icon(Icons.chat_bubble_outline,
                            color: Colors.white70),
                        title: Text(p,
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        onTap: () {
                          Navigator.pop(context);
                          onSelectPrompt(p);
                        },
                      )),
                  const Divider(color: Colors.grey),
                ],
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text("Saved Chats",
                      style: TextStyle(color: Colors.white70,
                          fontWeight: FontWeight.bold)),
                ),
                if (savedChats.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text("No saved chats",
                          style: TextStyle(color: Colors.white54)),
                    ),
                  )
                else
                  ...savedChats.map((chat) => ListTile(
                        leading: const Icon(Icons.history,
                            color: Colors.white70),
                        title: Text(chat['title'] ?? 'Untitled',
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ChatDetailPage(chatId: chat['id'] as int),
                            ),
                          );
                        },
                      )),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "ChanAI Mobile v1.0.0 \nDeveloped by: Christian Barbosa",
                style: TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
