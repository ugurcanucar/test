class DiseaseModel {
  DiseaseModel({
    this.id,
    this.name,
    this.parentId,
    this.status,
    this.isDeleted,
    this.created,
    this.deleted,
    this.updated,
    this.check,
  });

  int? id;
  String? name;
  int? parentId;
  bool? status;
  bool? isDeleted;
  String? created;
  bool? deleted;
  bool? updated;
  bool? check;

  factory DiseaseModel.fromJson(Map<String, dynamic> json) => DiseaseModel(
        id: json["id"],
        name: json["name"],
        parentId: json["parentId"],
        status: json["status"],
        isDeleted: json["isDeleted"],
        created: json["created"],
        deleted: json["deleted"],
        updated: json["updated"],
        check: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parentId": parentId,
        "status": status,
        "isDeleted": isDeleted,
        "created": created,
        "deleted": deleted,
        "updated": updated,
        "check": check,
      };
}
