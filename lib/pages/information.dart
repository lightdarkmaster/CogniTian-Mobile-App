import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 57, 59),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('About App', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF202020),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- CogniTian Card ---
              Card(
                elevation: 10,
                color: const Color(0xFF2F3339),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(126, 158, 158, 158),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/headers.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              'CogniTian',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'An AI-powered Conversational Assistant',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Cognitian is an innovative AI-powered conversational assistant designed to enhance the way you communicate. Leveraging cutting-edge natural language processing (NLP) technology, Cognitian generates context-aware, human-like responses to help you write faster, brainstorm ideas, or build engaging conversations with ease. Unlike a simple chatbot, Cognitian is a productivity tool that supports you in diverse tasks—whether composing professional emails, drafting documents, generating creative content, or simulating interactive dialogues.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // --- Christian Barbosa Card ---
              Card(
                elevation: 10,
                color: const Color(0xFF2F3339),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(126, 158, 158, 158),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/BARBOSA_CHRISTIAN_9543.png',
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              'Christian Barbosa',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Software Developer',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'A software developer specializing in diverse technology domains, they design and build innovative web applications, develop intelligent AI-driven solutions, craft intuitive mobile applications, and create robust APIs that connect systems seamlessly. With a focus on problem-solving and delivering efficient, scalable, and user-friendly software, they combine technical expertise across multiple platforms with creativity and adaptability to meet complex project needs and drive digital transformation.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // --- Gemini API Card ---
              Card(
                elevation: 10,
                color: const Color(0xFF2F3339),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(126, 158, 158, 158),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/GeminiAPIFeeds.jpg',
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              'Gemini API',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Gemini API - Your Gateway to Generative AI',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'The Gemini API, when integrated into a mobile app, brings powerful generative AI capabilities directly to users’ fingertips, enabling real-time conversational experiences, content generation, smart recommendations, and contextual assistance. Its support for multimodal inputs allows apps to handle text, images, and other data seamlessly, while streaming responses ensure fast, interactive chats that feel natural and responsive. With flexible endpoints for content creation, summarization, and reasoning, developers can build mobile apps that are not only intelligent but also highly personalized, delivering richer user engagement and productivity on the go.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // --- Technology Used ---
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Technology Used: ',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildHorizontalCard(
                        'assets/images/flutter_logo.png',
                        'Flutter',
                        'A UI toolkit by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/dart.png',
                        'Dart',
                        'is a client-optimized programming language for building fast, high-performance applications across various platforms.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/GeminiAPI.png',
                        'Gemini API',
                        'The Gemini API integration in a mobile app enables real-time conversational AI, content generation and more',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // --- Core Packages Used ---
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Core Packages Used: ',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildHorizontalCard(
                        'assets/images/https_gif.gif',
                        'Dart HTTPS Client',
                        'The http client in Dart (from the http package) is a lightweight library that allows you to send asynchronous HTTP and HTTPS requests.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/dart_services.gif',
                        'Dart Services',
                        'usually refer to classes or components that handle specific application logic—like networking, authentication, database access.',
                      ),
                      _buildHorizontalCard(
                        'assets/images/convert.gif',
                        'Dart Convert',
                        'library provides tools for encoding and decoding data, most commonly for working with JSON, UTF-8, and Base64.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }

  // --- Horizontal Card Builder ---
  Widget _buildHorizontalCard(
    String imagePath,
    String title,
    String description,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(right: 12),
      color: const Color(0xFF2F3339),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(126, 158, 158, 158),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 200,
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 120,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
