import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIModelTesting extends StatefulWidget {
  @override
  _AIModelTestingState createState() => _AIModelTestingState();
}

class _AIModelTestingState extends State<AIModelTesting> {
  XFile? _image;
  String? _analysisResult;
  bool _isLoading = false;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        _analysisResult = null;
      });
      analyzeImage();
    }
  }

  Future<void> analyzeImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("กรุณาเลือกภาพก่อน")));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      File imageFile = File(_image!.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      print("🔍 กำลังส่งภาพไปที่ Hugging Face API...");
      final response = await http.post(

        headers: {
          "Authorization": "Bearer $huggingFaceApiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"inputs": base64Image}),
      );

      print("📡 Response: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> result = jsonDecode(response.body);
        setState(() {
          _analysisResult = "📌 ผลวิเคราะห์: ${result[0]['label']} (ความแม่นยำ: ${(result[0]['score'] * 100).toStringAsFixed(2)}%)";
        });

        if (result[0]['label'].contains("person")) {
          analyzeFaceEmotion(base64Image);
        }
      } else {
        setState(() {
          _analysisResult = "❌ ไม่สามารถวิเคราะห์ภาพได้ (โค้ด ${response.statusCode})\n\n${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _analysisResult = "❌ เกิดข้อผิดพลาด: $e";
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> analyzeFaceEmotion(String base64Image) async {
    print("🔍 กำลังส่งภาพไปที่ Google Vision API...");
    final response = await http.post(
      Uri.parse("https://vision.googleapis.com/v1/images:annotate?key=$googleVisionApiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "requests": [
          {
            "image": {"content": base64Image},
            "features": [{"type": "FACE_DETECTION"}]
          }
        ]
      }),
    );

    print("📡 Response: ${response.body}");

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result["responses"][0].containsKey("faceAnnotations")) {
        var emotions = result["responses"][0]["faceAnnotations"][0];
        String emotionResult = "😊 อารมณ์ที่ตรวจพบ:\n";
        if (emotions["joyLikelihood"] == "VERY_LIKELY") emotionResult += "😀 มีความสุข\n";
        if (emotions["sorrowLikelihood"] == "VERY_LIKELY") emotionResult += "😢 เศร้า\n";
        if (emotions["angerLikelihood"] == "VERY_LIKELY") emotionResult += "😡 โกรธ\n";
        if (emotions["surpriseLikelihood"] == "VERY_LIKELY") emotionResult += "😲 ตกใจ\n";

        setState(() {
          _analysisResult = (_analysisResult ?? "") + "\n\n$emotionResult";
        });
      } else {
        setState(() {
          _analysisResult = "😐 ไม่พบใบหน้าหรืออารมณ์";
        });
      }
    } else {
      setState(() {
        _analysisResult = "❌ ไม่สามารถวิเคราะห์ใบหน้าได้ (โค้ด ${response.statusCode})\n\n${response.body}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🖼️ ทดลองโมเดล AI")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image != null
              ? Column(
                  children: [
                    Image.file(File(_image!.path), height: 200),
                    SizedBox(height: 10),
                  ],
                )
              : Icon(Icons.image, size: 100, color: Colors.blue.shade700),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: pickImage,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              backgroundColor: Colors.blue.shade600,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text("📸 เลือกรูปภาพ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),

          SizedBox(height: 20),

          _isLoading
              ? CircularProgressIndicator()
              : _analysisResult != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            _analysisResult!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : Container(),
        ],
      ),
    );
  }
}
