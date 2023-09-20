class UsuarioModel {
  final int id;
  final String nome;
  final String email;
  final String senha;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });

  set id(int id) {
    id = id;
  }
}
