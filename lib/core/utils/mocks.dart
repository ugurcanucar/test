import 'package:terapizone/ui/shared/uitext.dart';

class Mocks {
  //day list
  List<String> dayList = [
    UIText.monday,
    UIText.tuesday,
    UIText.wednesday,
    UIText.thursday,
    UIText.friday,
    UIText.saturday,
    UIText.sunday,
  ];

  //short day list
  List<String> shortDayList = [
    UIText.mondayShort,
    UIText.tuesdayShort,
    UIText.wednesdayShort,
    UIText.thursdayShort,
    UIText.fridayShort,
    UIText.saturdayShort,
    UIText.sundayShort,
  ];
  //example: [1,4,5] => [pzt,prş, cuma]
  static String shortDayStringFromIds(List<int>? dayNumbers) {
    String result = '';
    if (dayNumbers != null && dayNumbers.isNotEmpty) {
      for (var element in dayNumbers) {
        if (result.isNotEmpty) {
          result += ' , ';
        }
        result += Mocks().shortDayList[element-1];
      }
    }

    return result;
  }

  //time ago
  static String timeAgo(String dateString, {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} yıl önce';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 yıl önce' : 'Geçen yıl';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} ay önce';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 ay önce' : 'Geçen ay';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} hafta önce';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 hafta önce' : 'Geçen hafta';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} gün önce';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 gün önce' : 'Dün';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} saat önce';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 saat önce' : 'Bir saat önce';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} dakika önce';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 dakika önce' : 'Bir dakika önce';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} saniye önce';
    } else {
      return 'Şimdi';
    }
  }
}
