import 'dart:async';
import 'package:terapizone/ui/controllers/controller_base.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

class ControllerFinance extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
   /*  seriesList = [
      charts.Series(
        id: "Subscribers",
        data: data,
        domainFn: (IncomeSeries series, _) => series.month,
        measureFn: (IncomeSeries series, _) => series.income,
        colorFn: (IncomeSeries series, _) => series.barColor,
       
      ),
    ]; */
  }

  //controllers

  //states
 /*  List<charts.Series<IncomeSeries, String>> seriesList = [];
  final List<IncomeSeries> data = [
    IncomeSeries(
      month: "Ocak",
      income: 10000000,
      barColor: charts.ColorUtil.fromDartColor(UIColor.azureRadiance),
    ),
    IncomeSeries(
      month: "Şubat",
      income: 11000000,
      barColor: charts.ColorUtil.fromDartColor(UIColor.azureRadiance),
    ),
    IncomeSeries(
      month: "Mart",
      income: 12000000,
      barColor: charts.ColorUtil.fromDartColor(UIColor.azureRadiance),
    ),
    IncomeSeries(
      month: "Nisan",
      income: 10000000,
      barColor: charts.ColorUtil.fromDartColor(UIColor.azureRadiance),
    ),
    IncomeSeries(
      month: "Mayıs",
      income: 8500000,
      barColor: charts.ColorUtil.fromDartColor(UIColor.azureRadiance),
    ),
    IncomeSeries(
      month: "Haziran",
      income: 7700000,
      barColor: charts.ColorUtil.fromDartColor(UIColor.azureRadiance),
    ),
    IncomeSeries(
      month: "Temmuz",
      income: 7600000,
      barColor: charts.ColorUtil.fromDartColor(UIColor.azureRadiance),
    ), 
    IncomeSeries(
      month: "Ağustos",
      income: 5500000,
      barColor: charts.ColorUtil.fromDartColor(UIColor.azureRadiance),
    ),
  ]; */
}

/* class IncomeSeries {
  final String month;
  final int income;
  final charts.Color barColor;

  IncomeSeries(
      {required this.month, required this.income, required this.barColor});
} */
