class UpdateIsNewClientAcceptingModel {
  UpdateIsNewClientAcceptingModel({
    this.isNewClientAccepting,
  });

  bool? isNewClientAccepting;

  factory UpdateIsNewClientAcceptingModel.fromJson(Map<String, dynamic> json) =>
      UpdateIsNewClientAcceptingModel(
        isNewClientAccepting: json["isNewClientAccepting"],
      );

  Map<String, dynamic> toJson() => {
        "isNewClientAccepting": isNewClientAccepting,
      };
}
