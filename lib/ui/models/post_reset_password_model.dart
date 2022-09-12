class PostResetPasswordModel {
  PostResetPasswordModel({
    this.code,
    this.newPassword,
    this.newPasswordAgain,
  });
  String? newPassword;

  String? code;
  String? newPasswordAgain;

  factory PostResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      PostResetPasswordModel(
        code: json["code"],
        newPassword: json["newPassword"],
        newPasswordAgain: json["newPasswordAgain"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "newPassword": newPassword,
        "newPasswordAgain": newPasswordAgain,
      };
}
