class PostDeviceRegistrationModel {
  PostDeviceRegistrationModel({
    this.macAddress,
    this.fcmToken,
    this.platform,
    this.ipAddress,
    this.longitude,
    this.latitude,
    this.mobileApplicationId,
    this.version,
  });

  String? macAddress;
  String? fcmToken;
  String? platform;
  String? ipAddress;
  int? longitude;
  int? latitude;
  int? mobileApplicationId;
  String? version;

  factory PostDeviceRegistrationModel.fromJson(Map<String, dynamic> json) =>
      PostDeviceRegistrationModel(
        macAddress: json["macAddress"],
        fcmToken: json["fcmToken"],
        platform: json["platform"],
        ipAddress: json["ipAddress"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        mobileApplicationId: json["mobileApplicationId"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "macAddress": macAddress,
        "fcmToken": fcmToken,
        "platform": platform,
        "ipAddress": ipAddress,
        "longitude": longitude,
        "latitude": latitude,
        "mobileApplicationId": mobileApplicationId,
        "version": version,
      };
}
