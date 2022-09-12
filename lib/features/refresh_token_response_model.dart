class RefreshTokenResponseModel {
  RefreshTokenData? data;
  bool? success;
  String? message;

  RefreshTokenResponseModel({this.data, this.success, this.message});

  RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? RefreshTokenData.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class RefreshTokenData {
  String? token;
  String? expiration;
  String? refreshToken;

  RefreshTokenData({this.token, this.expiration, this.refreshToken});

  RefreshTokenData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['expiration'] = expiration;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
