import 'dart:convert';
import 'package:chanai_mobile/pages/const.dart';
import 'package:chanai_mobile/pages/drawer.dart';
import 'package:chanai_mobile/pages/information.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'; // ✅ for Clipboard

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final List<String> _prompts = []; // 🔹 stores user prompts
  bool _isLoading = false;

  final String apiKey = apiKEY;
  final String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  Future<void> _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": userMessage});
      _prompts.add(userMessage);
      _isLoading = true;
      _controller.clear();
    });

    try {
      final response = await http.post(
        Uri.parse("$apiUrl?key=$apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": _messages.map((msg) {
            return {
              "role": msg["role"] == "user" ? "user" : "model",
              "parts": [
                {"text": msg["text"] ?? ""},
              ],
            };
          }).toList(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // final modelReply = data["candidates"][0]["content"]["parts"][0]["text"];
        String sanitizeResponse(String text) {
          // Remove markdown bold/italic markers (*, **, _)
          return text
              .replaceAll(RegExp(r'\*\*'), '') // remove bold markers
              .replaceAll(RegExp(r'\*'), '') // remove italic markers
              .replaceAll(RegExp(r'_'), ''); // remove underscores
        }

        final rawReply = data["candidates"][0]["content"]["parts"][0]["text"];
        final modelReply = sanitizeResponse(rawReply);

        //instead of direct setState, use typing effect
        _showTypingEffect(modelReply);
      } else {
        setState(() {
          _messages.add({"role": "model", "text": "Error: ${response.body}"});
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "model", "text": "Failed to connect: $e"});
        _isLoading = false;
      });
    }
  }

  // New helper function for typing effect
  Future<void> _showTypingEffect(String fullText) async {
    setState(() {
      _messages.add({"role": "model", "text": ""}); // placeholder
      _isLoading = false;
    });

    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(
        const Duration(milliseconds: 2),
      ); // faster typing speed
      setState(() {
        _messages[_messages.length - 1]["text"] = fullText.substring(0, i + 1);
      });
    }
  }

  void _startNewChat() {
    setState(() {
      _messages.clear();
      _prompts.clear();
      _controller.clear();
    });
  }

  void _insertPrompt(String prompt) {
    setState(() {
      _controller.text = prompt; // 🔹 autofill in input
    });
  }

  Widget _buildMessage(Map<String, String> message) {
    final isUser = message["role"] == "user";
    final text = message["text"] ?? "";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          // Model avatar (optional)
          if (!isUser)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/ai_logo.png',
                width: 18,
                height: 18,
              ),
            ),

          if (!isUser) const SizedBox(width: 8),

          // Message bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.blueAccent : const Color(0xFF2F3339),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isUser
                      ? const Radius.circular(16)
                      : const Radius.circular(0),
                  bottomRight: isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  // Copy button only for model responses
                  if (!isUser)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.white70,
                          size: 18,
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Copied to clipboard"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),

          if (isUser) const SizedBox(width: 8),

          // User avatar (optional)
          if (isUser)
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 18, color: Colors.white),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1F23),
      appBar: AppBar(
        title: const Text(
          "CogniTian",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2F3339),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutApp()),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(
        prompts: _prompts,
        onNewChat: _startNewChat,
        onSelectPrompt: _insertPrompt,
      ),
      body: Stack(
        children: [
          /// Main chat UI
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) =>
                      _buildMessage(_messages[index]),
                ),
              ),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          onSubmitted: (value) => _sendMessage(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blueAccent),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// Fullscreen loader
          if (_isLoading)
            Container(
              color: Colors.black, // semi-transparent overlay
              child: Center(
                child: Image.asset(
                  'assets/images/infinityloading.gif',
                  height: 500,
                  width: 500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
