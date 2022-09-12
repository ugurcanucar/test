class MyTherapistModel {
  MyTherapistModel({
    this.biography,
    this.firstName,
    this.lastName,
    this.title,
    this.companyName,
    this.therapyApproaches,
    this.imageUrl,
    this.videoUrl,
    this.education,
  });

  String? biography;
  String? firstName;
  String? lastName;
  String? title;
  String? companyName;
  String? therapyApproaches;
  String? imageUrl;
  String? videoUrl;
  String? education;

  factory MyTherapistModel.fromJson(Map<String, dynamic> json) =>
      MyTherapistModel(
        biography: json["biography"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        title: json["title"] ?? '',
        companyName: json["companyName"] ?? '',
        therapyApproaches: json["therapyApproaches"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        videoUrl: json["videoUrl"] ?? '',
        education: json["education"] ?? '',
      );
}
