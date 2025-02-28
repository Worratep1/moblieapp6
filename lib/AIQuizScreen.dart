import 'package:flutter/material.dart';

class AIQuizScreen extends StatefulWidget {
  @override
  _AIQuizScreenState createState() => _AIQuizScreenState();
}

class _AIQuizScreenState extends State<AIQuizScreen> {
  String? selectedLevel;
  int questionIndex = 0;
  int score = 0;

  final Map<String, List<Map<String, Object>>> quizLevels = {
    "Beginner": [
      {"question": "โมเดล AI ที่ใช้เรียนรู้จากข้อมูลเรียกว่าอะไร?", "options": ["Machine Learning", "Data Science", "Blockchain"], "answer": "Machine Learning"},
      {"question": "TensorFlow และ PyTorch เป็นไลบรารีสำหรับอะไร?", "options": ["AI", "Web Development", "Cybersecurity"], "answer": "AI"},
      {"question": "Supervised Learning คืออะไร?", "options": ["เรียนรู้จากข้อมูลที่มีป้ายกำกับ", "เรียนรู้จากข้อมูลที่ไม่มีป้ายกำกับ", "เรียนรู้จากรางวัล"], "answer": "เรียนรู้จากข้อมูลที่มีป้ายกำกับ"},
      {"question": "Python ใช้ทำอะไรได้?", "options": ["พัฒนา AI", "ตัดต่อวิดีโอ", "สร้าง Blockchain"], "answer": "พัฒนา AI"},
      {"question": "อัลกอริทึมที่ใช้ใน Machine Learning ได้แก่?", "options": ["Decision Tree", "Photoshop", "HTML"], "answer": "Decision Tree"},
      {"question": "NLP ย่อมาจากอะไร?", "options": ["Natural Language Processing", "Neural Learning Program", "Network Layer Protocol"], "answer": "Natural Language Processing"},
      {"question": "การเรียนรู้แบบ Reinforcement Learning คืออะไร?", "options": ["เรียนรู้จากรางวัล", "เรียนรู้จากฐานข้อมูล", "เรียนรู้จากกฎเกณฑ์"], "answer": "เรียนรู้จากรางวัล"},
      {"question": "คอมพิวเตอร์สามารถเข้าใจรูปภาพด้วยอะไร?", "options": ["Computer Vision", "Cybersecurity", "Cloud Computing"], "answer": "Computer Vision"},
      {"question": "อัลกอริทึม K-Means ใช้สำหรับอะไร?", "options": ["Clustering", "Classification", "Regression"], "answer": "Clustering"},
      {"question": "AI ย่อมาจากอะไร?", "options": ["Artificial Intelligence", "Automated Internet", "Active Innovation"], "answer": "Artificial Intelligence"},
    ],
    "Intermediate": [
      {"question": "Deep Learning เป็นส่วนหนึ่งของอะไร?", "options": ["Machine Learning", "Cybersecurity", "Quantum Computing"], "answer": "Machine Learning"},
      {"question": "Activation Function ที่นิยมใช้ใน Neural Network คือ?", "options": ["ReLU", "SMTP", "FTP"], "answer": "ReLU"},
      {"question": "CNN เหมาะสำหรับ?", "options": ["วิเคราะห์ภาพ", "วิเคราะห์เสียง", "วิเคราะห์เอกสาร"], "answer": "วิเคราะห์ภาพ"},
      {"question": "Overfitting คืออะไร?", "options": ["โมเดลเรียนรู้มากเกินไปจนทำงานกับข้อมูลใหม่ได้ไม่ดี", "โมเดลทำงานเร็วเกินไป", "โมเดลมีพารามิเตอร์น้อยเกินไป"], "answer": "โมเดลเรียนรู้มากเกินไปจนทำงานกับข้อมูลใหม่ได้ไม่ดี"},
      {"question": "การทำ Data Augmentation ใช้กับอะไร?", "options": ["เพิ่มข้อมูลให้โมเดลเรียนรู้ดีขึ้น", "ลดขนาดข้อมูล", "เพิ่มค่าให้ตัวแปร"], "answer": "เพิ่มข้อมูลให้โมเดลเรียนรู้ดีขึ้น"},
      {"question": "RNN เหมาะกับการวิเคราะห์ข้อมูลแบบใด?", "options": ["ข้อมูลลำดับเวลา", "ภาพนิ่ง", "ข้อมูลประเภทเสียง"], "answer": "ข้อมูลลำดับเวลา"},
      {"question": "Loss Function ใช้ทำอะไร?", "options": ["วัดความผิดพลาดของโมเดล", "ลดขนาดโมเดล", "เพิ่มพารามิเตอร์"], "answer": "วัดความผิดพลาดของโมเดล"},
      {"question": "Gradient Descent ใช้ทำอะไร?", "options": ["หาค่าเหมาะสมของพารามิเตอร์", "สร้างโมเดล", "วิเคราะห์ข้อมูล"], "answer": "หาค่าเหมาะสมของพารามิเตอร์"},
      {"question": "GANs ใช้ทำอะไร?", "options": ["สร้างข้อมูลใหม่", "วิเคราะห์เอกสาร", "ทำการคำนวณทางสถิติ"], "answer": "สร้างข้อมูลใหม่"},
      {"question": "Transformer Model เช่น BERT ใช้ทำอะไร?", "options": ["วิเคราะห์ข้อความ", "วิเคราะห์ภาพ", "วิเคราะห์เสียง"], "answer": "วิเคราะห์ข้อความ"},
    ],
    "Advanced": [
      {"question": "Attention Mechanism ใช้ในอะไร?", "options": ["NLP", "Computer Vision", "Blockchain"], "answer": "NLP"},
      {"question": "Self-Supervised Learning หมายถึงอะไร?", "options": ["การเรียนรู้ที่สร้างป้ายกำกับเอง", "การเรียนรู้จากรางวัล", "การเรียนรู้จากคนสอน"], "answer": "การเรียนรู้ที่สร้างป้ายกำกับเอง"},
      {"question": "Capsule Networks ถูกพัฒนามาเพื่ออะไร?", "options": ["แก้ปัญหาของ CNN", "เพิ่มความเร็วของ AI", "ทำให้ AI เข้าใจเสียง"], "answer": "แก้ปัญหาของ CNN"},
      {"question": "Quantum Machine Learning ใช้ประโยชน์จากอะไร?", "options": ["Quantum Computing", "AI Ethics", "Data Mining"], "answer": "Quantum Computing"},
      {"question": "Bayesian Neural Networks ใช้แนวคิดอะไร?", "options": ["Probability", "Statistics", "Mathematics"], "answer": "Probability"},
      {"question": "Zero-Shot Learning คืออะไร?", "options": ["โมเดลที่เรียนรู้ได้โดยไม่ต้องมีตัวอย่าง", "โมเดลที่เรียนรู้จากภาพ", "โมเดลที่เรียนรู้จากเสียง"], "answer": "โมเดลที่เรียนรู้ได้โดยไม่ต้องมีตัวอย่าง"},
      {"question": "Explainable AI (XAI) หมายถึงอะไร?", "options": ["AI ที่อธิบายการตัดสินใจของตัวเองได้", "AI ที่เร็วขึ้น", "AI ที่มีขนาดเล็ก"], "answer": "AI ที่อธิบายการตัดสินใจของตัวเองได้"},
      {"question": "Federated Learning ใช้สำหรับอะไร?", "options": ["การเรียนรู้แบบกระจาย", "การเรียนรู้แบบมีตัวแทน", "การเรียนรู้แบบรวมศูนย์"], "answer": "การเรียนรู้แบบกระจาย"},
      {"question": "โมเดล AI ที่ใช้สร้างภาพจากข้อความคือ?", "options": ["Stable Diffusion", "BERT", "GPT"], "answer": "Stable Diffusion"},
      {"question": "Reinforcement Learning ใช้วิธีใดในการเรียนรู้?", "options": ["รางวัลและการลงโทษ", "ตัวอย่างข้อมูล", "ปรับค่าพารามิเตอร์"], "answer": "รางวัลและการลงโทษ"},
    ],
  };

  void answerQuestion(String answer) {
    if (answer == quizLevels[selectedLevel]![questionIndex]["answer"]) {
      score++;
    }
    setState(() {
      if (questionIndex < quizLevels[selectedLevel]!.length - 1) {
        questionIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("🎯 ผลลัพธ์ของคุณ"),
        content: Text("คะแนนของคุณ: $score/${quizLevels[selectedLevel]!.length}\n\n"
            "${score < quizLevels[selectedLevel]!.length / 2 ? "แนะนำให้ศึกษาระดับเริ่มต้น" : "คุณมีความเข้าใจที่ดีในระดับนี้แล้ว"}"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedLevel = null;
                questionIndex = 0;
                score = 0;
              });
              Navigator.pop(context);
            },
            child: Text("🔁 ทำแบบทดสอบอีกครั้ง"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📝 แบบทดสอบ AI")),
      body: Container(
        decoration: BoxDecoration(color: Colors.blue.shade100),
        child: selectedLevel == null ? _buildLevelSelection() : _buildQuiz(),
      ),
    );
  }

  Widget _buildLevelSelection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("🔰 เลือกระดับแบบทดสอบ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade800)),
          SizedBox(height: 20),
          _buildLevelButton("Beginner", Colors.green),
          _buildLevelButton("Intermediate", Colors.orange),
          _buildLevelButton("Advanced", Colors.red),
        ],
      ),
    );
  }

  Widget _buildLevelButton(String level, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(Icons.school, color: Colors.white),
        label: Text(level, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onPressed: () {
          setState(() {
            selectedLevel = level;
          });
        },
      ),
    );
  }

  Widget _buildQuiz() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (questionIndex + 1) / quizLevels[selectedLevel]!.length,
          backgroundColor: Colors.white,
          color: Colors.green,
          minHeight: 8,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // แก้ไขให้พื้นหลังไม่ขยายตามข้อความ
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "คำถามที่ ${questionIndex + 1}/${quizLevels[selectedLevel]!.length}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    Text(
                      quizLevels[selectedLevel]![questionIndex]["question"] as String,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ..._buildOptions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildOptions() {
    return (quizLevels[selectedLevel]![questionIndex]["options"] as List<String>).map((option) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => answerQuestion(option),
          child: Text(option, style: TextStyle(fontSize: 18)),
        ),
      );
    }).toList();
  }
}
