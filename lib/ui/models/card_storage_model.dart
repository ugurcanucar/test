class CardStorageModel {
  CardStorageModel({
    this.id,
    this.created,
    this.cardType,
    this.cardAssociation,
    this.cardFamily,
    this.cardBankName,
    this.cardAlias,
    this.binNumber,
  });

  String? id;
  DateTime? created;
  String? cardType;
  String? cardAssociation;
  String? cardFamily;
  String? cardBankName;
  String? cardAlias;
  String? binNumber;

  factory CardStorageModel.fromJson(Map<String, dynamic> json) =>
      CardStorageModel(
        id: json["id"] ?? '',
        created: DateTime.parse(json["created"]),
        cardType: json["cardType"] ?? '',
        cardAssociation: json["cardAssociation"] ?? '',
        cardFamily: json["cardFamily"] ?? '',
        cardBankName: json["cardBankName"] ?? '',
        cardAlias: json["cardAlias"] ?? '',
        binNumber: json["binNumber"] ?? '',
      );
}
