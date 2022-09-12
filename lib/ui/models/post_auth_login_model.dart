class PostAuthLoginModel {
  PostAuthLoginModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory PostAuthLoginModel.fromJson(Map<String, dynamic> json) =>
      PostAuthLoginModel(
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
