import 'package:intl/intl.dart';
import 'package:lumas/general/configs.dart';

class Helper{

  static String? formatDate(date){
    DateTime dateTime = DateTime.parse(date);
    return DateFormat(AppConfig.formatDate).format(dateTime);
  }

  static String? formatCurrency(value){
    final formatCurrency = new NumberFormat.simpleCurrency(locale: "zh_HK", name: "HK\$", decimalDigits: 0);
    return formatCurrency.format(int.parse(value));
  }
}