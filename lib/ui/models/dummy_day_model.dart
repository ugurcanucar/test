class DummyDayModel {
  DummyDayModel({this.id, this.name, this.check,});

  int? id;
  String? name;
  bool? check;

  factory DummyDayModel.fromJson(Map<String, dynamic> json) =>
      DummyDayModel(
        id: json["id"],
        name: json["name"],
        check: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "check":check,
      };
}
