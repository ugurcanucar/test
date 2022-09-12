class MatchDiseaseListModel {
  MatchDiseaseListModel({
    this.diseaseName,
    this.diseaseId,
  });

  String? diseaseName;
  int? diseaseId;

  factory MatchDiseaseListModel.fromJson(Map<String, dynamic> json) =>
      MatchDiseaseListModel(
        diseaseName: json["diseaseName"] ?? '',
        diseaseId: json["diseaseId"] ?? '',
      );
}
