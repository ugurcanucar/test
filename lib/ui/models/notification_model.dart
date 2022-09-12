class NotificationModel {
  NotificationModel({
    this.id,
    this.createDate,
    this.readDate,
    this.message,
    this.isRead,
    this.actionType,
  });

  String? id;
  String? createDate;
  String? readDate;
  String? message;
  bool? isRead;
  String? actionType;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        createDate: json["createDate"] ?? '',
        readDate: json["readDate"],
        message: json["message"] ?? '',
        isRead: json["isRead"] ?? false,
        actionType: json["actionType"],
      );
}
