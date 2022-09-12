class TestListModel {
  TestListModel({
    this.id,
    this.name,
    this.isDisplayList,
    this.status,
    this.isDeleted,
    this.created,
  });

  int? id;
  String? name;
  bool? isDisplayList;
  bool? status;
  bool? isDeleted;
  String? created;

  factory TestListModel.fromJson(Map<String, dynamic> json) => TestListModel(
        id: json["id"],
        name: json["name"]??'',
        isDisplayList: json["isDisplayList"],
        status: json["status"],
        isDeleted: json["isDeleted"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isDisplayList": isDisplayList,
        "status": status,
        "isDeleted": isDeleted,
        "created": created,
      };
}
