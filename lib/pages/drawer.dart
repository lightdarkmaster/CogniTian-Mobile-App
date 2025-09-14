import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final List<String> prompts;
  final VoidCallback onNewChat;
  final Function(String) onSelectPrompt;

  const AppDrawer({
    super.key,
    required this.prompts,
    required this.onNewChat,
    required this.onSelectPrompt,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1E1F23), // dark theme
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2F3339)),
            child: Image.asset(
              'assets/images/headers.png',
              width: double.infinity,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.blueAccent),
            title: const Text(
              "New Chat",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              onNewChat();
            },
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: prompts.isEmpty
                ? const Center(
                    child: Text(
                      "No prompts yet",
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    itemCount: prompts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white70,
                        ),
                        title: Text(
                          prompts[index],
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          onSelectPrompt(prompts[index]);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
