class PostPaymentModel {
  PostPaymentModel({
    this.cardAlias,
    this.cardHoldername,
    this.cardNumber,
    this.expireMonth,
    this.expireYear,
    this.cvc,
    this.saveCard,
  });

  String? cardAlias;
  String? cardHoldername;
  String? cardNumber;
  String? expireMonth;
  String? expireYear;
  String? cvc;
  bool? saveCard;

  factory PostPaymentModel.fromJson(Map<String, dynamic> json) =>
      PostPaymentModel(
        cardAlias: json["cardAlias"],
        cardHoldername: json["cardHoldername"],
        cardNumber: json["cardNumber"],
        expireMonth: json["expireMonth"],
        expireYear: json["expireYear"],
        cvc: json["cvc"],
        saveCard: json["saveCard"],
      );

  Map<String, dynamic> toJson() => {
        "cardAlias": cardAlias,
        "cardHoldername": cardHoldername,
        "cardNumber": cardNumber,
        "expireMonth": expireMonth,
        "expireYear": expireYear,
        "cvc": cvc,
        "saveCard": saveCard,
      };
}
