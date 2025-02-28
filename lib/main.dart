
import 'package:account/AICoursesScreen.dart';

import 'package:account/AIQuizScreen.dart';
import "package:flutter/material.dart";
import 'package:account/provider/aiToolProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AIToolProvider())
      ],
      child: MaterialApp(
        title: 'AI Learning Tool',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.blue.shade50,
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 16),
          ),
        ),
        home: const AIToolHomePage(),
      ),
    );
  }
}

class AIToolHomePage extends StatelessWidget {
  const AIToolHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🚀 AI Learning Tool', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 5,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "📚 เรียนรู้ AI อย่างง่ายดาย 🔥",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuCard(
                    context,
                    title: "📖 หลักสูตร AI",
                    subtitle: "เรียนรู้แนวคิดพื้นฐานและขั้นสูงเกี่ยวกับ AI",
                    icon: Icons.menu_book,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AICoursesScreen())),
                  ),
                  _buildMenuCard(
                    context,
                    title: "🎯 แบบฝึกหัด AI",
                    subtitle: "ทดสอบความรู้ด้าน AI ด้วย Quiz สนุกๆ",
                    icon: Icons.quiz,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AIQuizScreen())),
                  ),
                  // _buildMenuCard(
                  //   context,
                  //   title: "🖼️ ทดลองโมเดล AI",
                  //   subtitle: "อัปโหลดภาพและให้ AI วิเคราะห์",
                  //   icon: Icons.image_search,
                  //   // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AIModelTesting())),
                  // ),
                  // _buildMenuCard(
                  //   context,
                  //   title: "💬 แชทกับ AI Tutor",
                  //   subtitle: "พูดคุยและถามคำถามเกี่ยวกับ AI",
                  //   icon: Icons.chat,
                  //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AIChatbotScreen())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }//

  Widget _buildMenuCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue.shade700, size: 30),
        ),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade700),
        onTap: onTap,
      ),
    );
  }
}
