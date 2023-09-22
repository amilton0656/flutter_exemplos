
class UsuarioModel {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final String imagem;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.imagem,
  });

  set id(int id) {
    id = id;
  }
}
