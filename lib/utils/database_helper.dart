import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/model/test.dart';

// Faz a conexão com o sqflite que contém as provas salvas pelo usuário.
// Facilitar o usuário a visualizar as provas salvas no seu dispositivo.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _database;

  final String savedTestsTable = "savedTests";
  final String columnIdTest = "idTest";
  final String columnProfName = "professorName";
  final String columnTestType = "type";
  final String columnTestYear = "year";
  final String columnTestSemester = "semester";
  final String columnTestSubject = "subject";

  // cria database caso não estiver sido criado ainda
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  initDatabase() async {
    Directory document = await getApplicationDocumentsDirectory();
    String path = join(document.path, "favorite_database.db");

    var database = openDatabase(path, version: 2, onCreate: _onCreate);
    return database;
  }

  // cria a tabela de provas salvas se não tiver criado ainda
  void _onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE $savedTestsTable($columnIdTest INTEGER PRIMARY KEY, $columnProfName TEXT,"
        " $columnTestType TEXT, $columnTestYear INTEGER, $columnTestSemester INTEGER, $columnTestSubject TEXT)");
  }

  // salva uma nova prova no sqlite
  // entrada: Test que contém informações da prova salva que o usuario deseja salvar
  // saida: retorna um int 0 caso falhe ou 1 caso seja bem sucedido
  Future<int> saveTest(Test test) async {
    var databaseClient = await database;
    int result = await databaseClient.insert('$savedTestsTable', test.toMap());
    return result;
  }

  // pega todas as provas salvas
  // saida: retorna uma lista de provas salvas
  Future<List<Test>> getSavedTests() async {
    var databaseClient = await database;
    var tests = await databaseClient.rawQuery("SELECT * FROM $savedTestsTable");
    List<Test> testList = tests.map((t) => Test.fromMap(t)).toList();
    return testList;
  }

  Future<Test> getLastTest() async {
    var databaseClient = await database;
    var tests = await databaseClient.rawQuery("SELECT * FROM $savedTestsTable");
    return Test.fromMap(tests.last);
  }

  // retorna o número de provas salvas
  Future<int> getCount() async {
    var databaseClient = await database;
    return Sqflite.firstIntValue(
        await databaseClient.rawQuery("SELECT COUNT(*) FROM $savedTestsTable"));
  }

  Future<Test> getTest(int id) async {
    var databaseClient = await database;
    var tests = await databaseClient
        .rawQuery("SELECT * FROM $savedTestsTable WHERE $columnIdTest = $id");
    if (tests.length == 0) return null;
    return Test.fromMap(tests.first);
  }

  Future<int> deleteTest(int id) async {
    var databaseClient = await database;
    return await databaseClient
        .delete(savedTestsTable, where: "$columnIdTest = ?", whereArgs: [id]);
  }

  Future close() async {
    var databaseClient = await database;
    return await databaseClient.close();
  }
}
