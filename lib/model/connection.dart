import 'package:mysql1/mysql1.dart';

class Connection{
  
  var conn;

  Connection(){
     final conn =  MySqlConnection.connect(
      new ConnectionSettings(
        host: 'sql10.freemysqlhosting.net', 
        port: 3306, 
        user: 'sql10281156', 
        db: 'sql10281156',
        password: '53BsyQ4avV')
        );
  }

  Future <List> getAllTeachers() async {
    List listTeachers;
    
    var results = await conn.query('SELECT nome FROM professor');
    for (var row in results) {
      //print('Id: ${row[0]}, nome: ${row[1]}');
      listTeachers.add(row[0]);
    }
    return listTeachers;
  }

  Future close() async{
    await conn.close();
  }
}