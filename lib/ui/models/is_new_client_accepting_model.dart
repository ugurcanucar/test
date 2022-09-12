class IsNewClientAcceptingModel {
  IsNewClientAcceptingModel({
    this.isNewClientAccepting,
  });

  bool? isNewClientAccepting;

  factory IsNewClientAcceptingModel.fromJson(Map<String, dynamic> json) =>
      IsNewClientAcceptingModel(
        isNewClientAccepting: json["isNewClientAccepting"],
      );

  Map<String, dynamic> toJson() => {
        "isNewClientAccepting": isNewClientAccepting,
      };
}
