class TherapistGetDiseasesModel {
  TherapistGetDiseasesModel({
    this.parentId,
    this.parentName,
    this.userChosenDiseaseListDtos,
  });

  int? parentId;
  String? parentName;
  List<UserChosenDiseaseListDtoModel>? userChosenDiseaseListDtos;

  factory TherapistGetDiseasesModel.fromJson(Map<String, dynamic> json) =>
      TherapistGetDiseasesModel(
        parentId: json["parentId"],
        parentName: json["parentName"],
        userChosenDiseaseListDtos: List<UserChosenDiseaseListDtoModel>.from(
            json["userChosenDiseaseListDtos"]
                .map((x) => UserChosenDiseaseListDtoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parentId": parentId,
        "parentName": parentName,
        "userChosenDiseaseListDtos": userChosenDiseaseListDtos != null
            ? List<dynamic>.from(
                userChosenDiseaseListDtos!.map((x) => x.toJson()))
            : [],
      };
}

class UserChosenDiseaseListDtoModel {
  UserChosenDiseaseListDtoModel({
    this.diseaseId,
    this.diseaseName,
    this.parentId,
  });

  int? diseaseId;
  String? diseaseName;
  int? parentId;

  factory UserChosenDiseaseListDtoModel.fromJson(Map<String, dynamic> json) =>
      UserChosenDiseaseListDtoModel(
        diseaseId: json["diseaseId"],
        diseaseName: json["diseaseName"],
        parentId: json["parentId"],
      );

  Map<String, dynamic> toJson() => {
        "diseaseId": diseaseId,
        "diseaseName": diseaseName,
        "parentId": parentId,
      };
}
