class ClientChangingTherapistModel {
  ClientChangingTherapistModel({
    this.genderId,
    this.diseaseIds,
    this.reasonId,
    this.shareData,
    this.otherText,
  });

  int? genderId;
  List<int>? diseaseIds;
  int? reasonId;
  bool? shareData;
  String? otherText;

  factory ClientChangingTherapistModel.fromJson(Map<String, dynamic> json) =>
      ClientChangingTherapistModel(
        genderId: json["genderId"],
        diseaseIds: List<int>.from(json["diseaseIds"].map((x) => x)),
        reasonId: json["reasonId"],
        shareData: json["shareData"],
        otherText: json["otherText"],
      );

  Map<String, dynamic> toJson() => {
        "genderId": genderId,
        "diseaseIds": diseaseIds != null
            ? List<dynamic>.from(diseaseIds!.map((x) => x))
            : [],
        "reasonId": reasonId,
        "shareData": shareData,
        "otherText": otherText,
      };
}
