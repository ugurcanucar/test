class GenderModel {
  GenderModel({
    this.id,
    this.name,
    this.status,
    this.created,
    this.deleted,
    this.updated,
    this.createdUserId,
    this.updatedUserId,
    this.deletedUserId,
    this.check,
  });

  int? id;
  String? name;
  bool? status;
  DateTime? created;
  bool? deleted;
  bool? updated;
  String? createdUserId;
  bool? updatedUserId;
  bool? deletedUserId;
  bool? check;

  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        id: json["id"],
        name: json["name"] ?? '',
        status: json["status"],
        created: DateTime.parse(json["created"]),
        deleted: json["deleted"],
        updated: json["updated"],
        createdUserId: json["createdUserId"],
        updatedUserId: json["updatedUserId"],
        deletedUserId: json["deletedUserId"],
        check: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created": created,
        "deleted": deleted,
        "updated": updated,
        "createdUserId": createdUserId,
        "updatedUserId": updatedUserId,
        "deletedUserId": deletedUserId,
        "check": check,
      };
}
