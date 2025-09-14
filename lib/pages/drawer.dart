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
            decoration: const BoxDecoration(
              color: Color(0xFF2F3339),
              image: DecorationImage(
                image: AssetImage('assets/images/headers.png'),
                fit: BoxFit.cover, // makes image cover the whole header
              ),
            ),
            child: null,
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
          Padding(
            padding: const EdgeInsets.all(10.0),
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
