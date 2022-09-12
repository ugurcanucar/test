class PostAddUserFirstPreferenceModel {
    PostAddUserFirstPreferenceModel({
        required this.genderId,
        required this.diseaseIds,
    });

    int genderId;
    List<int> diseaseIds;

    factory PostAddUserFirstPreferenceModel.fromJson(Map<String, dynamic> json) => PostAddUserFirstPreferenceModel(
        genderId: json["genderId"],
        diseaseIds: List<int>.from(json["diseaseIds"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "genderId": genderId,
        "diseaseIds": List<dynamic>.from(diseaseIds.map((x) => x)),
    };
}
