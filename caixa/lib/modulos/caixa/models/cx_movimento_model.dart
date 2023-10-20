// ignore_for_file: public_member_api_docs, sort_constructors_first
class CxMovimentoModel {
  final int id;
  String data;  //field
  final double valor;
  final String sinal;
  final String historico;
  final int id_centrocustos;

  set setData(String dt) {
    data = dt;
  }

  CxMovimentoModel({
    required this.id,
    required this.data,
    required this.valor,
    required this.sinal,
    required this.historico,
    required this.id_centrocustos,
    
  });


}
