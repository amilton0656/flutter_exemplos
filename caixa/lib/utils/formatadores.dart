import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Formatadores {
  static final dataFormarter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );
}
