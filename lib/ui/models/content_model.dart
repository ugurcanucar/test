class ContentModel {
  ContentModel({
    this.id,
    this.contentKey,
    this.contentTitle,
    this.contentText,
  });

  int? id;
  String? contentKey;
  String? contentTitle;
  String? contentText;

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        id: json["id"],
        contentKey: json["contentKey"] ?? '',
        contentTitle: json["contentTitle"] ?? '',
        contentText: json["contentText"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contentKey": contentKey,
        "contentTitle": contentTitle,
        "contentText": contentText,
      };
}
