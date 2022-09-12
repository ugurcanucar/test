class VimeoFromUrlModel {
  VimeoFromUrlModel({
    this.type,
    this.version,
    this.providerName,
    this.providerUrl,
    this.title,
    this.authorName,
    this.authorUrl,
    this.isPlus,
    this.accountType,
    this.html,
    this.width,
    this.height,
    this.duration,
    this.description,
    this.thumbnailUrl,
    this.thumbnailWidth,
    this.thumbnailHeight,
    this.thumbnailUrlWithPlayButton,
    this.uploadDate,
    this.videoId,
    this.uri,
  });

  String? type;
  String? version;
  String? providerName;
  String? providerUrl;
  String? title;
  String? authorName;
  String? authorUrl;
  String? isPlus;
  String? accountType;
  String? html;
  int? width;
  int? height;
  int? duration;
  String? description;
  String? thumbnailUrl;
  int? thumbnailWidth;
  int? thumbnailHeight;
  String? thumbnailUrlWithPlayButton;
  DateTime? uploadDate;
  int? videoId;
  String? uri;

  factory VimeoFromUrlModel.fromJson(Map<String, dynamic> json) => VimeoFromUrlModel(
        type: json["type"],
        version: json["version"],
        providerName: json["provider_name"],
        providerUrl: json["provider_url"],
        title: json["title"],
        authorName: json["author_name"],
        authorUrl: json["author_url"],
        isPlus: json["is_plus"],
        accountType: json["account_type"],
        html: json["html"],
        width: json["width"],
        height: json["height"],
        duration: json["duration"],
        description: json["description"],
        thumbnailUrl: json["thumbnail_url"],
        thumbnailWidth: json["thumbnail_width"],
        thumbnailHeight: json["thumbnail_height"],
        thumbnailUrlWithPlayButton: json["thumbnail_url_with_play_button"],
        uploadDate: DateTime.parse(json["upload_date"]),
        videoId: json["video_id"],
        uri: json["uri"],
      );
}
