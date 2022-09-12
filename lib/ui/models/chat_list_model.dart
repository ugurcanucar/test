class ChatListModel {
  ChatListModel({
    this.title,
    this.text,
    this.messageGroupId,
    this.senderUserId,
    this.receiverId,
    this.unreadMessageCount,
  });

  String? title;
  String? text;
  String? messageGroupId;
  String? senderUserId;

  String? receiverId;
  int? unreadMessageCount;

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        title: json["title"] ?? '',
        text: json["text"] ?? '',
        messageGroupId: json["messageGroupId"] ?? '',
        senderUserId: json["senderUserId"] ?? '',
        receiverId: json["receiverId"] ?? '',
        unreadMessageCount: json["unreadMessageCount"] ?? 0,
      );
}
