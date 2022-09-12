import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ChronosService {
  static String getTime(String date) {
    var dateTime = DateTime.parse(date);
    initializeDateFormatting();
    var formatter = DateFormat('kk:mm', Langauge.language);

    return formatter.format(dateTime);
  }

  static String getDay(String date) {
    var dateTime = DateTime.parse(date);
    initializeDateFormatting();
    var formatter = DateFormat('EE', Langauge.language);

    return formatter.format(dateTime);
  }

  static String getDateDigit(String date) {
    var dateTime = DateTime.parse(date);
    initializeDateFormatting();

    var formatter = DateFormat('dd MMM yyyy', Langauge.language); /* , hh:mm */
    return formatter.format(dateTime);
  }

  static String getDateDayMonth(String date) {
    var dateTime = DateTime.parse(date);
    initializeDateFormatting();

    var formatter =
        DateFormat('dd MMMM, kk:mm', Langauge.language); /* , hh:mm */
    return formatter.format(dateTime);
  }

  static String getDateShort(String? date) {
    if (date != null) {
      var dateTime = DateTime.parse(date);
      initializeDateFormatting();

      var formatter =
          DateFormat('dd MMMM yyyy', Langauge.language); /* , hh:mm */
      return formatter.format(dateTime);
    } else {
      return 'null';
    }
  }

  static String getDateLong(String? date) {
    if (date != null) {
      var dateTime = DateTime.parse(date);
      initializeDateFormatting();

      var formatter =
          DateFormat('dd.MM.yyyy , EEEE ', Langauge.language); /* , hh:mm */
      return formatter.format(dateTime);
    } else {
      return 'null';
    }
  }

  static String getDateSlash(DateTime date) {
    initializeDateFormatting();

    var formatter =
        // ignore: prefer_adjacent_string_concatenation
        DateFormat('dd' + '/' + 'MM' + '/' + 'yyyy', Langauge.language);
    return formatter.format(date);
  }

  static List<String> getMonthsAndYears(int diff) {
    //wanting month - 1
    List<String> monthList = [];
    var dateTime = DateTime.now();
    initializeDateFormatting();

    // ignore: prefer_adjacent_string_concatenation
    var formatter = DateFormat(('MMM' + '\n' + 'yyyy'), Langauge.language);
    monthList.add(formatter.format(dateTime));

    for (var i = 1; i <= diff; i++) {
      var monthYear = Jiffy().subtract(months: i);
      monthList.add(formatter.format(monthYear.dateTime));
    }

    return monthList;
  }

  static String getAmountFormartter(String amount) {
    var number = num.parse(amount);
    var formattedNumber = NumberFormat().format(number);

    var formattedString = formattedNumber;
    var i = formattedString.replaceAll(',', '!');
    var j = i.replaceAll('.', ',');
    var k = j.replaceAll('!', '.');

    return k;
  }
}
