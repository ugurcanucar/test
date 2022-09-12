import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_test.dart';
import 'package:terapizone/ui/models/test_questions_model.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewTest extends StatelessWidget {
  final int testId;
  const ViewTest({Key? key, required this.testId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerTest(testId: testId));

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.dark,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.wildSand,
        child: Obx(() => c.busy
            ? const ActivityIndicator()
            : SafeArea(
                child: Scaffold(
                    backgroundColor: UIColor.wildSand,
                    appBar: AppBar(
                      backgroundColor: UIColor.wildSand,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      title: Row(
                        children: [
                          Expanded(
                            child: TextBasic(
                              text: c.questionModel.testName ?? '...',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                Utilities.showDefaultDialogConfirmCancel(
                                    title: UIText.textSure,
                                    content: UIText.textAddTestAnswerSaveSure,
                                    onConfirm: () => c.addTestAnswer(),
                                    onCancel: () => Get.back()),
                            child: TextBasic(
                              text: UIText.save,
                              color: UIColor.azureRadiance,
                              fontSize: 17,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      leading: GetBackButton(title: UIText.back),
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                    ),
                    body: Stack(
                      children: [
                        QuestionsWidget(
                          controller: c.pageController,
                        ),
                        Positioned(
                            bottom: 32,
                            left: 32,
                            child: FloatingActionButton(
                                heroTag: 'left',
                                onPressed: () {
                                  if (c.pageController.page! > 0) {
                                    c.pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.bounceIn);
                                  }
                                },
                                backgroundColor: UIColor.azureRadiance,
                                child: const Icon(Icons.arrow_left))),
                        Positioned(
                            bottom: 32,
                            right: 32,
                            child: FloatingActionButton(
                                heroTag: 'right',
                                onPressed: () {
                                  QuestionModel q = c.questionModel.questions![
                                      c.pageController.page!.round()];
                                  bool result = false;
                                  for (var element in q.questionOptions!) {
                                    if (element.isSelected!) {
                                      result = true;
                                    }
                                  }
                                  if (result) {
                                    c.pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.bounceIn);
                                    if (c.questionModel.questions != null &&
                                        c.pageController.page!.round() ==
                                            c.questionModel.questions!.length -
                                                1) {
                                      Utilities.showToast(
                                          UIText.toastLastQuestionSaveText);
                                    }
                                  } else {
                                    Utilities.showToast(
                                        UIText.toastSelectOption);
                                  }
                                },
                                backgroundColor: UIColor.azureRadiance,
                                child: const Icon(Icons.arrow_right))),
                      ],
                    )),
              )),
      ),
    );
  }
}

class QuestionsWidget extends StatelessWidget {
  final PageController? controller;
  final ValueChanged<QuestionOptionModel>? onClickedOption;
  const QuestionsWidget({
    Key? key,
    this.controller,
    this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<ControllerTest>(
        init: ControllerTest(),
        initState: (_) {},
        builder: (c) {
          return PageView.builder(
            controller: controller,
            itemCount: c.questionModel.questions != null
                ? c.questionModel.questions!.length
                : 0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildQuestion(
                question: c.questionModel.questions![index],
                index: index,
                questionLength: c.questionModel.questions!.length,
              );
            },
          );
        },
      );

  Widget buildQuestion({
    required QuestionModel question,
    required int index,
    required int questionLength,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextBasic(
              text: '${index + 1} / $questionLength',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 32),
            Text(
              question.questionText!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GetBuilder<ControllerTest>(
                init: ControllerTest(),
                initState: (_) {},
                builder: (c) {
                  return OptionsWidget(
                    question: question,
                    onClickedOption: (QuestionOptionModel o) {
                      o.isSelected = true;
                      int questionInd =
                          c.questionModel.questions!.indexOf(question);
                      int optionInd = c.questionModel.questions![questionInd]
                          .questionOptions!
                          .indexOf(o);
                      c.selectOption(questionInd, optionInd);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
}

class OptionsWidget extends StatelessWidget {
  final QuestionModel question;
  final ValueChanged<QuestionOptionModel> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: Utils.heightBetween(
          question.questionOptions!
              .map((option) => buildOption(context, option))
              .toList(),
          height: 8,
        ),
      );

  Widget buildOption(BuildContext context, QuestionOptionModel option) {
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: option.isSelected! ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildAnswer(option),
          ],
        ),
      ),
    );
  }

  Widget buildAnswer(QuestionOptionModel option) => SizedBox(
        height: 50,
        child: Text(
          option.optionText!,
          style: const TextStyle(fontSize: 20),
        ),
      );
}

class Utils {
  static List<Widget> heightBetween(
    List<Widget> children, {
    required double height,
  }) {
    if (children.isEmpty) return <Widget>[];
    if (children.length == 1) return children;

    final list = [children.first, SizedBox(height: height)];
    for (int i = 1; i < children.length - 1; i++) {
      final child = children[i];
      list.add(child);
      list.add(SizedBox(height: height));
    }
    list.add(children.last);

    return list;
  }
}
