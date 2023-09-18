import '../models/models.dart';

final List<Usuario> usuarios = [
  Usuario(id: 1, nome: 'Amilton', email: 'amilton@email', senha: '11111'),
  Usuario(id: 2, nome: 'Pedro', email: 'pedro@email', senha: '22222'),
  Usuario(id: 3, nome: 'João', email: 'joao@email', senha: '33333'),
  Usuario(id: 4, nome: 'Maria', email: 'maria@email', senha: '44444'),
];

final List<Pessoa> pessoas = [
  Pessoa(
    id: 'p01',
    tipoPessoa: 0,
    cpf: '289.205.039-15',
    nome: 'Amilton',
    cep: '88080-250',
    endereco: 'Rua Abel Capela, 380',
    complemento: 'apto 01',
    bairro: 'Coqueiros',
    municipio: 'Florianópolis',
    uf: 'SC',
    valor: 123.45,
    isento: 1,
  ),
  Pessoa(
    id: 'p02',
    tipoPessoa: 0,
    cpf: '125.369.039-15',
    nome: 'COTA Empreendimentos',
    cep: '88015-400',
    endereco: 'Rua Vitor Konder, 125',
    complemento: '11. andar',
    bairro: 'Centro',
    municipio: 'Florianópolis',
    uf: 'SC',
    valor: 3655.33,
    isento: 0,
  ),
  Pessoa(
    id: 'p03',
    tipoPessoa: 0,
    cpf: '289.205.039-15',
    nome: 'Mariana',
    cep: '88080-250',
    endereco: 'Rua Abel Capela, 40',
    complemento: 'apto 05',
    bairro: 'Coqueiros',
    municipio: 'Florianópolis',
    uf: 'SC',
    valor: 325.66,
    isento: 1,
  ),
];
