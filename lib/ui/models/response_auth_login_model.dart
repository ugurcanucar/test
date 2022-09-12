class ResponseAuthLoginModel {
  ResponseAuthLoginModel({
    this.accessToken,
    this.user,
    this.isPurchasedPackage,
    this.isClientTherapist,
    this.unreadMessageCount,
  });

  ModelAccessToken? accessToken;
  ModelUser? user;
  bool? isPurchasedPackage;
  bool? isClientTherapist;
  int? unreadMessageCount;

  factory ResponseAuthLoginModel.fromJson(Map<String, dynamic> json) =>
      ResponseAuthLoginModel(
        accessToken: ModelAccessToken.fromJson(json["accessToken"]),
        user: ModelUser.fromJson(json["user"]),
        isPurchasedPackage: json["isPurchasedPackage"] ?? false,
        isClientTherapist: json["isClientTherapist"] ?? false,
        unreadMessageCount: json["unreadMessageCount"] ?? 0,
      );
}

class ModelAccessToken {
  ModelAccessToken({
    this.token,
    this.expiration,
    this.refreshToken,
  });

  String? token;
  String? refreshToken;
  String? expiration;

  factory ModelAccessToken.fromJson(Map<String, dynamic> json) =>
      ModelAccessToken(
        token: json["token"],
        refreshToken: json["refreshToken"],
        expiration: json["expiration"],
      );
}

class ModelUser {
  ModelUser({
    this.id,
    this.accountTypeId,
    this.firstName,
    this.lastName,
    this.nickName,
    this.email,
    this.gender,
    this.phone,
    this.birthDay,
    this.subscribeApp,
    this.status,
  });

  int? accountTypeId;
  String? firstName;
  String? id;
  String? lastName;
  String? nickName;
  String? email;
  int? gender;
  String? phone;
  String? birthDay;
  int? subscribeApp;
  bool? status;

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        accountTypeId: json["accountTypeId"],
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        nickName: json["nickName"],
        email: json["email"],
        gender: json["gender"],
        phone: json["phone"],
        birthDay: json["birthDay"],
        subscribeApp: json["subscribeApp"],
        status: json["status"],
      );
}
