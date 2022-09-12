class MessageModel {
  final String id;
  final String therapistImageUrl;
  final String therapistName;
  final String message;
  final String date;
  bool isRead;

  MessageModel({
    required this.id,
    required this.therapistImageUrl,
    required this.therapistName,
    required this.message,
    required this.date,
    required this.isRead,
  });
}
