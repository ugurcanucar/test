class ListTestScoreModel {
  ListTestScoreModel({
    this.testId,
    this.solvedDate,
    this.testName,
    this.scores,
  });

  int? testId;
  String? solvedDate;
  String? testName;
  List<ScoreModel>? scores;

  factory ListTestScoreModel.fromJson(Map<String, dynamic> json) =>
      ListTestScoreModel(
        testId: json["testId"],
        solvedDate: json["solvedDate"],
        testName: json["testName"] ?? '',
        scores: json["scores"] != null
            ? List<ScoreModel>.from(
                json["scores"].map((x) => ScoreModel.fromJson(x)))
            : [],
      );
}

class ScoreModel {
  ScoreModel({
    this.categoryId,
    this.score,
    this.categoryName,
  });

  int? categoryId;
  int? score;
  String? categoryName;

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
        categoryId: json["categoryId"],
        score: json["score"] ?? 0,
        categoryName: json["categoryName"] ?? '',
      );
}
