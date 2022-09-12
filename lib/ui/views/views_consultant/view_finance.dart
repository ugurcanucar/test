//import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_finance.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

class ViewFinance extends StatelessWidget {
  const ViewFinance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerFinance());

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
                      centerTitle: true,
                      title: TextBasic(
                        text: UIText.cFinanceTitle,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      leading: GetBackButton(title: UIText.back),
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                    ),
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    //final ControllerFinance c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.athensGray,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              margin: const EdgeInsets.only(top: 30, bottom: 41),
              decoration: whiteDecoration(),
              child: Column(
                children: [
                  getLine(
                      title: UIText.cFinanceBalance,
                      value: '1.358 TL',
                      isDivider: true),
                  getLine(
                      title: UIText.cFinancePending,
                      value: '6.479 TL',
                      isDivider: true),
                  getLine(
                      title: UIText.cFinanceAdvanceAcoount,
                      value: '- TL',
                      isDivider: true),
                  getLine(title: UIText.cFinanceTotal, value: '73.457 TL'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 6),
              child: TextBasic(
                text: UIText.cFinanceSubtitle,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
          /*   Container(
              height: 321,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              decoration: whiteDecoration(),
              child: charts.BarChart(
                c.seriesList,
                animate: true,
                vertical: false,
                animationDuration: const Duration(seconds: 1),
                defaultRenderer: charts.BarRendererConfig(
                  cornerStrategy: const charts.ConstCornerStrategy(0),
                  maxBarWidthPx: 10,
                ),
                /*  behaviors: [
                  LinePointHighlighter(
                    symbolRenderer: IconRenderer(Icons.cloud, Size(30, 30)),
                  )
                ], */
                selectionModels: [
                  SelectionModelConfig(changedListener: (SelectionModel model) {
                    if (model.hasDatumSelection) {
                      log(model.selectedSeries[0]
                          .measureFn(model.selectedDatum[0].index)
                          .toString());
                    }
                  })
                ],
              ),
            ),
          */ ],
        ),
      ),
    );
  }

  Widget getLine({
    required String title,
    required String value,
    bool? isDivider = false,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextBasic(
              text: title,
              fontSize: 17,
            ),
            TextBasic(
              text: value,
              color: UIColor.tuna.withOpacity(.6),
              fontSize: 13,
            )
          ],
        ),
        if (isDivider!)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 22),
      ],
    );
  }
}
