class PostAuthRegisterModel {
  PostAuthRegisterModel({
    required this.email,
    required this.password,
    required this.nickName,
    this.birthDay,
    this.gender,
    required this.accountTypeId,
    this.phone,
  });

  String email;
  String password;
  String nickName;
  String? birthDay;
  int? gender;
  int accountTypeId;
  String? phone;

  factory PostAuthRegisterModel.fromJson(Map<String, dynamic> json) =>
      PostAuthRegisterModel(
        email: json['email'],
        password: json['password'],
        nickName: json['nickName'],
        birthDay: json['birthDay'],
        gender: json['gender'],
        accountTypeId: json['accountTypeId'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'nickName': nickName,
        'birthDay': birthDay,
        'gender': gender,
        'accountTypeId': accountTypeId,
        'phone': phone,
      };
}
