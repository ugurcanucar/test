class PackagesModel {
  PackagesModel({
    this.id,
    this.name,
    this.text,
    this.price,
    this.numberOfVideos,
    this.isChat,
    this.packageStartDate,
    this.packageEndDate,
    this.status,
    this.isDeleted,
    this.created,
    this.deleted,
    this.updated,
    this.createdUserId,
    this.updatedUserId,
    this.deletedUserId,
    this.weekPrice,
  });

  String? id;
  String? name;
  String? text;
  num? price;
  int? numberOfVideos;
  bool? isChat;
  DateTime? packageStartDate;
  DateTime? packageEndDate;
  bool? status;
  bool? isDeleted;
  DateTime? created;
  bool? deleted;
  bool? updated;
  String? createdUserId;
  String? updatedUserId;
  String? deletedUserId;
  num? weekPrice;

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        text: json["text"] ?? '',
        price: json["price"],
        numberOfVideos: json["numberOfVideos"],
        isChat: json["isChat"],
        packageStartDate: DateTime.parse(json["packageStartDate"]),
        packageEndDate: DateTime.parse(json["packageEndDate"]),
        status: json["status"],
        isDeleted: json["isDeleted"],
        created: DateTime.parse(json["created"]),
        deleted: json["deleted"],
        updated: json["updated"],
        createdUserId: json["createdUserId"],
        updatedUserId: json["updatedUserId"],
        deletedUserId: json["deletedUserId"],
        weekPrice: json["weekPrice"],
      );
}
