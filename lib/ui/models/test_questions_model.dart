class TestQuestionsModel {
  TestQuestionsModel({
    this.testId,
    this.testName,
    this.questions,
  });

  int? testId;
  String? testName;
  List<QuestionModel>? questions;

  factory TestQuestionsModel.fromJson(Map<String, dynamic> json) =>
      TestQuestionsModel(
        testId: json["testId"],
        testName: json["testName"],
        questions: json["questions"] == null
            ? []
            : List<QuestionModel>.from(
                json["questions"].map((x) => QuestionModel.fromJson(x))),
      );
}

class QuestionModel {
  QuestionModel({
    this.questionId,
    this.orderOfAppearance,
    this.questionText,
    this.questionOptions,
  });

  int? questionId;
  int? orderOfAppearance;
  String? questionText;
  List<QuestionOptionModel>? questionOptions;
  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        questionId: json["questionId"],
        orderOfAppearance: json["orderOfAppearance"],
        questionText: json["questionText"],
        questionOptions: List<QuestionOptionModel>.from(json["questionOptions"]
            .map((x) => QuestionOptionModel.fromJson(x))),
      );
}

class QuestionOptionModel {
  QuestionOptionModel(
      {this.questionOptionId,
      this.optionOrder,
      this.optionText,
      this.puan,
      this.isSelected});

  int? questionOptionId;
  int? optionOrder;
  String? optionText;
  int? puan;
  bool? isSelected;

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) =>
      QuestionOptionModel(
          questionOptionId: json["questionOptionId"],
          optionOrder: json["optionOrder"],
          optionText: json["optionText"],
          puan: json["puan"],
          isSelected: false);
}
