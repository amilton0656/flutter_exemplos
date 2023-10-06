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
        (anoBisexto && mes == 2 && dia > 29)
        ) {
      return false;
    }


    return res;
  }
}
