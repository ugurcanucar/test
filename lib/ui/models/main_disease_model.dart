class MainDiseaseModel {
  MainDiseaseModel({this.id, this.name, this.check,});

  int? id;
  String? name;
  bool? check;

  factory MainDiseaseModel.fromJson(Map<String, dynamic> json) =>
      MainDiseaseModel(
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
