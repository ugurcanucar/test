class PostAddTestAnswerModel {
  PostAddTestAnswerModel({
    required this.testId,
    required this.testQuestionAnswerList,
  });

  int testId;
  List<TestQuestionAnswerListModel> testQuestionAnswerList;

  factory PostAddTestAnswerModel.fromJson(Map<String, dynamic> json) =>
      PostAddTestAnswerModel(
        testId: json["testId"],
        testQuestionAnswerList: List<TestQuestionAnswerListModel>.from(
            json["testQuestionAnswerList"]
                .map((x) => TestQuestionAnswerListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "testId": testId,
        "testQuestionAnswerList":
            List<dynamic>.from(testQuestionAnswerList.map((x) => x.toJson())),
      };
}

class TestQuestionAnswerListModel {
  TestQuestionAnswerListModel({
    this.testQuestionId,
    this.answerQuestionOptionId,
    this.puan,
  });

  int? testQuestionId;
  int? answerQuestionOptionId;
  int? puan;

  factory TestQuestionAnswerListModel.fromJson(Map<String, dynamic> json) =>
      TestQuestionAnswerListModel(
        testQuestionId: json["testQuestionId"],
        answerQuestionOptionId: json["answerQuestionOptionId"],
        puan: json["puan"],
      );

  Map<String, dynamic> toJson() => {
        "testQuestionId": testQuestionId,
        "answerQuestionOptionId": answerQuestionOptionId,
        "puan": puan,
      };
}
