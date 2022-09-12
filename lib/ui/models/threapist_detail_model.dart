import 'package:terapizone/ui/models/match_disease_list_model.dart';

class TherapistDetailModel {
  TherapistDetailModel({
    this.therapistId,
    this.firstName,
    this.lastName,
    this.title,
    this.biography,
    this.companyName,
    this.therapyApproaches,
    this.videoUrl,
    this.imageUrl,
    this.education,
    this.matchDiseaseList,
    this.maximumClients,
  });

  String? therapistId;
  String? firstName;
  String? lastName;
  String? title;
  String? biography;
  String? companyName;
  String? therapyApproaches;
  String? videoUrl;
  String? imageUrl;
  String? education;
  List<MatchDiseaseListModel>? matchDiseaseList;
  int? maximumClients;

  factory TherapistDetailModel.fromJson(Map<String, dynamic> json) =>
      TherapistDetailModel(
        therapistId: json["therapistId"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        title: json["title"] ?? '',
        biography: json["biography"] ?? '',
        companyName: json["companyName"] ?? '',
        therapyApproaches: json["therapyApproaches"] ?? '',
        videoUrl: json["videoUrl"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        education: json["education"] ?? '',
        matchDiseaseList: List<MatchDiseaseListModel>.from(
            json["matchDiseaseList"]
                .map((x) => MatchDiseaseListModel.fromJson(x))),
        maximumClients: json["maximumClients"],
      );
}
