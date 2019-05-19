import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/model/exam.dart';

// Faz a conexão com o sqflite que contém as provas salvas pelo usuário.
// Facilitar o usuário a visualizar as provas salvas no seu dispositivo.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _database;

  final String savedExamsTable = "savedExams";
  final String columnIdExam = "idExam";
  final String columnProfName = "professorName";
  final String columnExamType = "type";
  final String columnExamYear = "year";
  final String columnExamSemester = "semester";
  final String columnExamSubject = "subject";

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
        "CREATE TABLE $savedExamsTable($columnIdExam INTEGER PRIMARY KEY, $columnProfName TEXT,"
        " $columnExamType TEXT, $columnExamYear INTEGER, $columnExamSemester INTEGER, $columnExamSubject TEXT)");
  }

  // salva uma nova prova no sqlite
  // entrada: Exam que contém informações da prova salva que o usuario deseja salvar
  // saida: retorna um int -> 0 caso falhe ou 1 caso seja bem sucedido
  Future<bool> saveExam(Exam exam) async {
    var databaseClient = await database;
    try {
      await databaseClient.insert('$savedExamsTable', exam.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // pega todas as provas salvas
  // saida: retorna uma lista de provas salvas
  Future<List<Exam>> getSavedExams() async {
    var databaseClient = await database;
    var exams = await databaseClient.rawQuery("SELECT * FROM $savedExamsTable");
    List<Exam> examList = exams.map((e) => Exam.fromMap(e)).toList();
    return examList;
  }

  // pega o ultimo id de prova por ordem crescente, ou seja, maior id
  Future<Exam> getLastExam() async {
    var databaseClient = await database;
    var exams = await databaseClient.rawQuery("SELECT * FROM $savedExamsTable");
    return Exam.fromMap(exams.last);
  }

  // retorna o número de provas salvas
  Future<int> getCount() async {
    var databaseClient = await database;
    return Sqflite.firstIntValue(
        await databaseClient.rawQuery("SELECT COUNT(*) FROM $savedExamsTable"));
  }

  // pega as informações da prova pelo seu id
  // entrada: id da prova
  // saida: o primeiro valor que possui id igual ao do id da entrada
  Future<Exam> getExam(int id) async {
    var databaseClient = await database;
    var exams = await databaseClient.rawQuery(
        "SELECT $columnIdExam, $columnProfName, $columnExamType, $columnExamYear, $columnExamSemester, $columnExamSubject FROM $savedExamsTable WHERE $columnIdExam = $id");

    if (exams.length == 0) return null;
    return Exam.fromMap(exams.first);
  }

  // remove uma prova da database pelo seu id
  // entrada: id da prova (de acordo com o id do prova da api)
  // saida: retorna um int -> 0 caso falhe, 1 caso bem sucedido
  Future<int> deleteExam(int id) async {
    var databaseClient = await database;
    return await databaseClient
        .delete(savedExamsTable, where: "$columnIdExam = ?", whereArgs: [id]);
  }

  // fecha a conexão com o sqlite
  Future close() async {
    var databaseClient = await database;
    return await databaseClient.close();
  }
}
