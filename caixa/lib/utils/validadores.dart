class Validadores {
  static bool isValidDate(String date) {
    bool res = true;

    int dia = int.tryParse(date.substring(0, 2)) ?? 0;
    int mes = int.tryParse(date.substring(3, 5)) ?? 0;
    int ano = int.tryParse(date.substring(6, 10)) ?? 0;
    bool anoBisexto = ((ano % 4 == 0) && (ano % 100 != 0)) || (ano % 400 == 0);

    if (dia == 0 ||
        mes == 0 ||
        ano == 0 ||
        mes > 12 ||
        dia > 31 ||
        (mes == 4 && dia > 30) ||
        (mes == 6 && dia > 30) ||
        (mes == 9 && dia > 30) ||
        (mes == 11 && dia > 30) ||
        (!anoBisexto && mes == 2 && dia > 28) ||
        (anoBisexto && mes == 2 && dia > 29)) {
      return false;
    }

    return res;
  }

  static bool dateIsAfter(String data1, String data2) {
    DateTime dt1 = DateTime.parse(dateDisplayToBanco(data1));
    DateTime dt2 = DateTime.parse(dateDisplayToBanco(data2));
    return (dt1.compareTo(dt2) <= 0);
  }


  static double StringToDouble(String value) {
    String valor = value.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(valor) ?? 0;
  }

  static int StringToInt(String value) {
    String valor = value.replaceAll('.', '');
    return int.tryParse(valor) ?? 0;
  }


  static String dateDisplayToBanco(String date) {
    return '${date.substring(6, 10)}-${date.substring(3, 5)}-${date.substring(0, 2)}';
  }

  static String dateBancoToDisplay(String date) {
    return '${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)}';
  }
}
