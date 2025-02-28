class AIToolItem {
  int? keyID;
  String title;
  double amount;
  DateTime? date; // เปลี่ยนเป็น DateTime? เพื่อรองรับ null ได้

  AIToolItem({
    this.keyID,
    required this.title,
    required this.amount,
    this.date, // ไม่ต้องใช้ required เพราะรองรับ null ได้
  });
}
