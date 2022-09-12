class PurchasedPackageModel {
  PurchasedPackageModel({
    this.packageId,
    this.packageName,
    this.packageText,
    this.packagePrice,
    this.packageNumberOfVideos,
    this.isChat,
    this.packageStartDate,
    this.packageEndDate,
  });

  String? packageId;
  String? packageName;
  String? packageText;
  num? packagePrice;
  num? packageNumberOfVideos;
  bool? isChat;
  DateTime? packageStartDate;
  DateTime? packageEndDate;

  factory PurchasedPackageModel.fromJson(Map<String, dynamic> json) =>
      PurchasedPackageModel(
        packageId: json["packageId"] ?? '',
        packageName: json["packageName"] ?? '',
        packageText: json["packageText"] ?? '',
        packagePrice: json["packagePrice"] ?? 0,
        packageNumberOfVideos: json["packageNumberOfVideos"],
        isChat: json["isChat"],
        packageStartDate: DateTime.parse(json["packageStartDate"]),
        packageEndDate: DateTime.parse(json["packageEndDate"]),
      );
}
