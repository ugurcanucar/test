class GetChangingReasonModel {
  GetChangingReasonModel({
    this.reasonChangingDtos,
  });

  List<ReasonChangingDtoModel>? reasonChangingDtos;
  dynamic genderDto;
  List<dynamic>? diseaseDto;

  factory GetChangingReasonModel.fromJson(Map<String, dynamic> json) =>
      GetChangingReasonModel(
        reasonChangingDtos: List<ReasonChangingDtoModel>.from(
            json["reasonChangingDtos"]
                .map((x) => ReasonChangingDtoModel.fromJson(x))),
      );
}

class ReasonChangingDtoModel {
  ReasonChangingDtoModel({this.id, this.reasonText, this.check});

  int? id;
  String? reasonText;
  bool? check;

  factory ReasonChangingDtoModel.fromJson(Map<String, dynamic> json) =>
      ReasonChangingDtoModel(
        id: json["id"],
        reasonText: json["reasonText"],
        check: false,
      );
}
