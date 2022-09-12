class ClientTestScoreResponseModel {
  List<ClientTestScoreResponse>? data;
  bool? success;
  String? message;

  ClientTestScoreResponseModel({this.data, this.success, this.message});

  ClientTestScoreResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ClientTestScoreResponse>[];
      json['data'].forEach((v) {
        data!.add(ClientTestScoreResponse.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class ClientTestScoreResponse {
  String? clientTestSessionId;
  bool? isCompleted;
  String? testName;
  int? testId;
  int? testType;
  int? totalQuestionCount;
  int? totalScore;
  int? overallAverage;
  List<QuestionCategories>? questionCategories;

  ClientTestScoreResponse(
      {this.clientTestSessionId,
      this.isCompleted,
      this.testName,
      this.testId,
      this.testType,
      this.totalQuestionCount,
      this.totalScore,
      this.overallAverage,
      this.questionCategories});

  ClientTestScoreResponse.fromJson(Map<String, dynamic> json) {
    clientTestSessionId = json['clientTestSessionId'];
    isCompleted = json['isCompleted'];
    testName = json['testName'];
    testId = json['testId'];
    testType = json['testType'];
    totalQuestionCount = json['totalQuestionCount'];
    totalScore = json['totalScore'];
    overallAverage = json['overallAverage'];
    if (json['questionCategories'] != null) {
      questionCategories = <QuestionCategories>[];
      json['questionCategories'].forEach((v) {
        questionCategories!.add(QuestionCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientTestSessionId'] = clientTestSessionId;
    data['isCompleted'] = isCompleted;
    data['testName'] = testName;
    data['testId'] = testId;
    data['testType'] = testType;
    data['totalQuestionCount'] = totalQuestionCount;
    data['totalScore'] = totalScore;
    data['overallAverage'] = overallAverage;
    if (questionCategories != null) {
      data['questionCategories'] = questionCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionCategories {
  String? categoryName;
  int? categoryId;
  int? score;
  String? scoreText;
  String? scoreDescription;
  int? totalMinPoint;
  int? totalMaxPoint;
  int? questionCount;

  QuestionCategories(
      {this.categoryName,
      this.categoryId,
      this.score,
      this.scoreText,
      this.scoreDescription,
      this.totalMinPoint,
      this.totalMaxPoint,
      this.questionCount});

  QuestionCategories.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    score = json['score'];
    scoreText = json['scoreText'];
    scoreDescription = json['scoreDescription'];
    totalMinPoint = json['totalMinPoint'];
    totalMaxPoint = json['totalMaxPoint'];
    questionCount = json['questionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryId'] = categoryId;
    data['score'] = score;
    data['scoreText'] = scoreText;
    data['scoreDescription'] = scoreDescription;
    data['totalMinPoint'] = totalMinPoint;
    data['totalMaxPoint'] = totalMaxPoint;
    data['questionCount'] = questionCount;
    return data;
  }
}
