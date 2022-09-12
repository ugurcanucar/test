class PostAddClientTherapistPreferenceModel {
  PostAddClientTherapistPreferenceModel({
    required this.therapistId,
  });

  String therapistId;

  factory PostAddClientTherapistPreferenceModel.fromJson(
          Map<String, dynamic> json) =>
      PostAddClientTherapistPreferenceModel(
        therapistId: json["therapistId"],
      );

  Map<String, dynamic> toJson() => {
        "therapistId": therapistId,
      };
}
