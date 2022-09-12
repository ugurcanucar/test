class MyProfileModel {
  MyProfileModel({
    this.nickName,
    this.email,
    this.phoneNo,
    this.birthDay,
    this.gender,
  });

  String? nickName;
  String? email;
  dynamic phoneNo;
  DateTime? birthDay;
  String? gender;

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
        nickName: json["nickName"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        birthDay: DateTime.parse(json["birthDay"]),
        gender: json["gender"],
      );
}
