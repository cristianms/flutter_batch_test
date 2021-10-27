import 'dart:convert';

class Contato {
  int id;
  String cpf;
  String nome;
  String tipo;
  Contato({
    required this.id,
    required this.cpf,
    required this.nome,
    required this.tipo,
  });

  Contato copyWith({
    int? id,
    String? cpf,
    String? nome,
    String? tipo,
  }) {
    return Contato(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cpf': cpf,
      'nome': nome,
      'tipo': tipo,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'],
      cpf: map['cpf'],
      nome: map['nome'],
      tipo: map['tipo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contato.fromJson(String source) => Contato.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Contato(id: $id, cpf: $cpf, nome: $nome, tipo: $tipo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Contato && other.id == id && other.cpf == cpf && other.nome == nome && other.tipo == tipo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ cpf.hashCode ^ nome.hashCode ^ tipo.hashCode;
  }
}
