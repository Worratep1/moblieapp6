import 'package:flutter/material.dart';
import 'AICourseDetailScreen.dart';

class AICoursesScreen extends StatefulWidget {
  @override
  _AICoursesScreenState createState() => _AICoursesScreenState();
}

class _AICoursesScreenState extends State<AICoursesScreen> {
  Map<String, List<Map<String, String>>> courses = {
    "Beginner": [
      {
        "title": "พื้นฐาน Machine Learning",
        "content": "Machine Learning คือเทคนิคที่ช่วยให้คอมพิวเตอร์เรียนรู้จากข้อมูลโดยอัตโนมัติ...\n\n📌 หัวข้อที่สำคัญ:\n- Supervised Learning\n- Unsupervised Learning\n- Reinforcement Learning\n- การใช้ Scikit-Learn ใน Python"
      },
    ],
    "Intermediate": [
      {
        "title": "Deep Learning และ Neural Networks",
        "content": "Deep Learning เป็นเทคนิคที่ใช้ Neural Networks ในการเรียนรู้ข้อมูลที่ซับซ้อน...\n\n📌 หัวข้อที่สำคัญ:\n- Artificial Neural Networks (ANN)\n- Convolutional Neural Networks (CNN)\n- Recurrent Neural Networks (RNN)\n- การใช้ TensorFlow และ PyTorch"
      },
    ],
    "Advanced": [
      {
        "title": "Natural Language Processing (NLP)",
        "content": "NLP เป็นการใช้ AI เพื่อทำความเข้าใจและประมวลผลภาษาธรรมชาติ...\n\n📌 หัวข้อที่สำคัญ:\n- Tokenization และ Lemmatization\n- Sentiment Analysis\n- Named Entity Recognition (NER)\n- Transformer Models เช่น BERT และ GPT"
      },
    ]
  };

  void _addOrEditCourse({String? level, int? index}) {
    String selectedLevel = level ?? "Beginner";
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    if (index != null) {
      titleController.text = courses[selectedLevel]![index]["title"]!;
      contentController.text = courses[selectedLevel]![index]["content"]!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? "📌 เพิ่มหลักสูตรใหม่" : "✏️ แก้ไขหลักสูตร"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedLevel,
                items: ["Beginner", "Intermediate", "Advanced"]
                    .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLevel = value!;
                  });
                },
              ),
              TextField(controller: titleController, decoration: InputDecoration(labelText: "📖 ชื่อหลักสูตร")),
              TextField(controller: contentController, decoration: InputDecoration(labelText: "📜 รายละเอียดหลักสูตร"), maxLines: 5),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("❌ ยกเลิก")),
            TextButton(
              onPressed: () {
                setState(() {
                  if (index == null) {
                    courses[selectedLevel]!.add({
                      "title": titleController.text,
                      "content": contentController.text,
                    });
                  } else {
                    courses[selectedLevel]![index] = {
                      "title": titleController.text,
                      "content": contentController.text,
                    };
                  }
                });
                Navigator.pop(context);
              },
              child: Text("✅ บันทึก"),
            ),
          ],
        );
      },
    );
  }

  void _deleteCourse(String level, int index) {
    setState(() {
      courses[level]!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("📖 หลักสูตร AI"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addOrEditCourse(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: courses.keys.map((level) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 10),
              child: ExpansionTile(
                leading: Icon(Icons.school, color: _getLevelColor(level)),
                title: Text(
                  "ระดับ: $level",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _getLevelColor(level)),
                ),
                children: courses[level]!.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> course = entry.value;
                  return ListTile(
                    leading: Icon(Icons.book, color: Colors.blueAccent),
                    title: Text(course["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _addOrEditCourse(level: level, index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteCourse(level, index),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AICourseDetailScreen(
                            title: course["title"]!,
                            content: course["content"]!,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Beginner":
        return Colors.green;
      case "Intermediate":
        return Colors.orange;
      case "Advanced":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
