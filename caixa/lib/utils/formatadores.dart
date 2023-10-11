import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Formatadores {
  static final dataFormarter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }

  static String numberToFormatted(double price) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('pt_BR');
    

    return numberFormat.format(price);
  }

  static String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR');   //.add_Hm();
    return dateFormat.format(dateTime);
  }

  static DateTime stringToDateTime(String date) {
    return DateTime.parse(date);
  }
}
