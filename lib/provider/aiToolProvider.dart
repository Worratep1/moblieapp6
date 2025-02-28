import 'package:account/model/aiToolItem.dart';
import 'package:flutter/foundation.dart';

class AIToolProvider with ChangeNotifier {
  List<AIToolItem> tools = [];

  void addAITool(AIToolItem tool) {
    tools.add(tool);
    notifyListeners();
  }

  void deleteAITool(AIToolItem tool) {
    tools.remove(tool);
    notifyListeners();
  }

  void updateAITool(AIToolItem item) {}
}
