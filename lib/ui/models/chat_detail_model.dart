import 'package:terapizone/core/enums/enum.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:terapizone/core/services/service_fcm.dart';

class ChatDetailModel {
  ChatDetailModel({
    this.notificationTypeId,
    this.text,
    this.position,
    this.nickname,
    this.type,
    this.testId,
    this.fileUrl,
    this.created,
    this.senderUserId,
    this.title,
    this.imageUrl,
    this.messageGroupId,
    this.receiverId,
    this.audioPlayer,
  });
  String? notificationTypeId;
  String? text;
  MessagePosition? position;
  String? nickname;
  MessageFileTypes? type;
  int? testId;
  String? fileUrl;
  String? created;
  String? senderUserId;
  String? title;
  String? imageUrl;
  String? messageGroupId;
  String? receiverId;

  ap.AudioPlayer? audioPlayer;

  factory ChatDetailModel.fromJson(Map<String, dynamic> json) =>
      ChatDetailModel(
        notificationTypeId: json["NotificationTypeId"] ?? notificationTypeIdMsg,
        text: json["text"] ?? '',
        position:
            json["position"] == 'R' ? MessagePosition.R : MessagePosition.L,
        nickname: json["nickname"] ?? '',
        type: json["type"] == null
            ? MessageFileTypes.text
            : json["type"] == 'Görsel' || json["type"] == 1
                ? MessageFileTypes.gorsel
                : json["type"] == 'Ses Kaydı' || json["type"] == 2
                    ? MessageFileTypes.seskaydi
                    : json["type"] == 'Video' || json["type"] == 3
                        ? MessageFileTypes.video
                        : json["type"] == 'Test' || json["type"] == 4
                            ? MessageFileTypes.test
                            : null,
        testId: json["testId"],
        fileUrl: json["fileUrl"],
        created: (json["created"]),
        senderUserId: json["senderUserId"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        messageGroupId: json["messageGroupId"],
        receiverId: json["receiverId"],
        audioPlayer: json["type"] == 'Ses Kaydı' || json["type"] == 2
            ? ap.AudioPlayer()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "NotificationTypeId": notificationTypeId,
        "text": text,
        "position": position == MessagePosition.L ? 'L' : 'R',
        "nickname": nickname,
        "type": getFileTypeText(type),
        "testId": testId,
        "fileUrl": fileUrl,
        "created": created,
        "senderUserId": senderUserId,
        "title": title,
        "imageUrl": imageUrl,
        "messageGroupId": messageGroupId,
        "receiverId": receiverId,
        "audioPlayer": audioPlayer,
      };
}
/* 

public enum MessageFileTypes
    {
        [Display(Name = "Görsel")]
        Image = 1,
        [Display(Name = "Ses Kaydı")]
        Sound = 2,
        [Display(Name = "Video")]
        Video = 3,
        [Display(Name = "Test")]
        Test = 4,
    } */