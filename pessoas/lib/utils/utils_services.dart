import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {
//R$ valor
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return numberFormat.format(price);
  }

  //DataFormatada
  String formatDateTime({
    required DateTime dateTime,
    bool hora = false,
  }) {
    initializeDateFormatting();

    DateFormat dateFormat =
        hora ? DateFormat.yMd('pt_BR').add_Hm() : DateFormat.yMd('pt_BR');

    return dateFormat.format(dateTime);
  }
}
