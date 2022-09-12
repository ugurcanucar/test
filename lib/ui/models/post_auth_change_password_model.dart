class PostAuthChangePasswordModel {
  PostAuthChangePasswordModel({
    this.newPassword,
    this.newPasswordAgain,
  });

  String? newPassword;
  String? newPasswordAgain;

  factory PostAuthChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      PostAuthChangePasswordModel(
        newPassword: json["newPassword"],
        newPasswordAgain: json["newPasswordAgain"],
      );

  Map<String, dynamic> toJson() => {
        "newPassword": newPassword,
        "newPasswordAgain": newPasswordAgain,
      };
}
