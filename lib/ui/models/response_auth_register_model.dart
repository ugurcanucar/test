class ResponseAuthRegisterModel {
  ResponseAuthRegisterModel({
    this.token,
    this.expiration,
  });

  String? token;
  String? expiration;

  factory ResponseAuthRegisterModel.fromJson(Map<String, dynamic> json) =>
      ResponseAuthRegisterModel(
        token: json["token"],
        expiration: json["expiration"],
      );
}
