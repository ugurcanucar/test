import 'match_disease_list_model.dart';

class TherapistListModel {
  TherapistListModel({
    this.therapistId,
    this.firstName,
    this.lastName,
    this.title,
    this.biography,
    this.companyName,
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
  String? videoUrl;
  String? imageUrl;
  String? education;
  List<MatchDiseaseListModel>? matchDiseaseList;
  int? maximumClients;

  factory TherapistListModel.fromJson(Map<String, dynamic> json) =>
      TherapistListModel(
        therapistId: json["therapistId"],
        firstName: json["firstName"] ?? '-',
        lastName: json["lastName"] ?? '-',
        title: json["title"],
        biography: json["biography"],
        companyName: json["companyName"],
        videoUrl: json["videoUrl"],
        imageUrl: json["imageUrl"],
        education: json["education"],
        matchDiseaseList: List<MatchDiseaseListModel>.from(
            json["matchDiseaseList"]
                .map((x) => MatchDiseaseListModel.fromJson(x))),
        maximumClients: json["maximumClients"],
      );
}
