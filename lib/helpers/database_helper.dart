import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Classe que representa um singleton para conexão com o banco
class DatabaseHelper {
  // Singleton
  static final DatabaseHelper _instance = DatabaseHelper._getInstance();
  /// Retorna uma instância de Database
  factory DatabaseHelper() => _instance;
  // Construtor privado para singleton
  DatabaseHelper._getInstance();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  /// Função responsável por retorna uma instância do banco de dados
  Future _initDb() async {
    // Caminho do diretório do arquivo de banco de dados
    String databasesPath = await getDatabasesPath();
    // Caminho do diretório do arquivo de banco de dados com o nome do arquivo
    // padrão (que é o nome do projeto)
    String path = join(databasesPath, 'teste.db');
    // Abre conexão, fazendo os upgrade de versão necessários, nesse caso está
    // na versão 2, o controle é feito no método "_onUpgrade"
    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    // Retorna instância
    return db;
  }

  // Método que cria o banco inicial
  void _onCreate(Database db, int newVersion) async {
    // Lê conteúdo de arquivo SQL na pasta assets
    String sqlCreate = await rootBundle.loadString('assets/sql/create.sql');
    // Separa blocos por ";"
    List<String> sqls = sqlCreate.split(';');
    // Um por um
    for (String sql in sqls) {
      if (sql.trim().isNotEmpty) {
        // Executa SQL
        await db.execute(sql);
      }
    }
  }

  // Método que controla as versões do banco e roda os upgrade necessários de
  // acordo com a versão do ap´p do usuário
  Future<FutureOr<void>> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");
    if (oldVersion == 1 && newVersion == 2) {
      await db.execute("alter table blablabla add column NOVA TEXT");
    }
  }

  // Chama para encerrar a conexão
  Future<void> close() async {
    var dbClient = await db;
    await dbClient?.close();
  }
  
}