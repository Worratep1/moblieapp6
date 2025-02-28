import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIChatbotScreen extends StatefulWidget {
  @override
  _AIChatbotScreenState createState() => _AIChatbotScreenState();
}

class _AIChatbotScreenState extends State<AIChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

 
  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": message});
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(huggingFaceApiUrl),
        headers: {
          "Authorization": "Bearer $huggingFaceApiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"inputs": message}),
      );

      print("📡 Hugging Face API Response: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          _messages.add({"role": "assistant", "text": data[0]["generated_text"]});
        });
      } else {
        setState(() {
          _messages.add({
            "role": "assistant",
            "text": "❌ API ล้มเหลว (โค้ด ${response.statusCode})\n\n${response.body}"
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "assistant", "text": "❌ เกิดข้อผิดพลาด: $e"});
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("💬 AI Chatbot (Hugging Face)")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                bool isUser = message["role"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue.shade300 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(fontSize: 16, color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "พิมพ์ข้อความ...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    sendMessage(_controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
