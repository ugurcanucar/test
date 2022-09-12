class PostCardStorageModel {
  PostCardStorageModel({
    this.cardAlias,
    this.cardHoldername,
    this.cardNumber,
    this.expireMonth,
    this.expireYear,
  });

  String? cardAlias;
  String? cardHoldername;
  String? cardNumber;
  String? expireMonth;
  String? expireYear;

  factory PostCardStorageModel.fromJson(Map<String, dynamic> json) =>
      PostCardStorageModel(
        cardAlias: json["cardAlias"],
        cardHoldername: json["cardHoldername"],
        cardNumber: json["cardNumber"],
        expireMonth: json["expireMonth"],
        expireYear: json["expireYear"],
      );

  Map<String, dynamic> toJson() => {
        "cardAlias": cardAlias,
        "cardHoldername": cardHoldername,
        "cardNumber": cardNumber,
        "expireMonth": expireMonth,
        "expireYear": expireYear,
      };
}
