import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/post_eaddtestanswer_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/models/test_questions_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ControllerTest extends BaseController {
  final int? testId;

  ControllerTest({this.testId});
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getList();
  }

  //controllers
  final PageController pageController = PageController();

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Rx<TestQuestionsModel> _questionModel = TestQuestionsModel().obs;

  TestQuestionsModel get questionModel => _questionModel.value;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  //get list of genders
  Future<void> getList() async {
    ResponseData<TestQuestionsModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.testsGetlisttestquestion(id: testId ?? 0));
    setBusy(false);

    if (response.success && response.data != null) {
      _questionModel.value = response.data;
    } else {
      Utilities.showToast(response.message!);
    }
  }

  //post/put work schedule
  Future<void> addTestAnswer() async {
    Get.back();

    List<TestQuestionAnswerListModel> testQuestionAnswerList = [];
    for (var element in _questionModel.value.questions!) {
      QuestionOptionModel selected = QuestionOptionModel();
      for (var option in element.questionOptions!) {
        if (option.isSelected!) {
          selected = option;
        }
      }

      testQuestionAnswerList.add(TestQuestionAnswerListModel(
          testQuestionId: element.questionId ?? 0,
          answerQuestionOptionId: selected.questionOptionId ?? 0,
          puan: selected.puan ?? 0));
    }
    PostAddTestAnswerModel postitem = PostAddTestAnswerModel(
        testId: _questionModel.value.testId ?? 0,
        testQuestionAnswerList: testQuestionAnswerList);
    setBusy(true);
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.post,
        endpoint: Endpoint.addtestanswer, body: postitem.toJson());
    setBusy(false);

    if (response.success) {
      Utilities.showDefaultDialogConfirm(
          title: UIText.textSuccess,
          content: UIText.textAddTestAnswerSuccess,
          onConfirm: () {
            Get.back();
            Get.back();
          });
    } else {
      Utilities.showToast(response.message ?? '');
    }
  }

  selectOption(int questionInd, int optionInd) {
    for (var element
        in questionModel.questions![questionInd].questionOptions!) {
      element.isSelected = false;
    }
    questionModel
        .questions![questionInd].questionOptions![optionInd].isSelected = true;
    update();
  }
}
