import 'package:anotacoes/model/model-anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {

  static final String nomeTabela = "anotacao";

  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper();
  late Database _db;

  factory AnotacaoHelper(){
    return _anotacaoHelper;
  }


  get db async {

    if( _db != null ){
      return _db;
    }else{
      _db = await inicializarDB();
      return _db;
    }

  }

  _onCreate(Database db, int version) async {

    /*

    id titulo descricao data
    01 teste  teste     02/10/2020

    * */

    String sql = "CREATE TABLE $nomeTabela ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "titulo VARCHAR, "
        "descricao TEXT, "
        "data DATETIME)";
    await db.execute(sql);

  }

  inicializarDB() async {

    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco_minhas_anotacoes.db");

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate );
    return db;

  }

  Future<int> salvarAnotacao(modelAnotacao anotacao) async {

    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, anotacao.toMap() );
    return resultado;

  }

  recuperarAnotacoes() async {

    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC ";
    List anotacoes = await bancoDados.rawQuery( sql );
    return anotacoes;

  }



}

/*

class Normal {

  Normal(){

  }

}

class Singleton {

  static final Singleton _singleton = Singleton._internal();

  	factory Singleton(){
      print("Singleton");
      return _singleton;
    }

    Singleton._internal(){
    	print("_internal");
  	}

}

void main() {

  var i1 = Singleton();
  print("***");
  var i2 = Singleton();

  print( i1 == i2 );

}


* */
























// import 'package:anotacoes/model/model-anotacao.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
//
// class DatabaseHelper {
//
//   static final DatabaseHelper _databaseHelper = DatabaseHelper();
//   late Database _bancodados;
//
//   factory DatabaseHelper(){
//     return _databaseHelper;
//   }
//
//   get bancodados async {
//     if (null != _bancodados){
//       return _bancodados;
//     }else{
//       _bancodados = await startBanco();
//       return _bancodados;
//     }
//   }
//
//   startBanco() async {
//
//     final caminhoBancoDados = await getDatabasesPath();
//     final localBancoDados = join(caminhoBancoDados, 'banco.db');
//
//     var db = await openDatabase(
//         localBancoDados,
//         version: 1,
//         onCreate: (db, dbVersaoRecente){
//           String sql = "CREATE TABLE anotacao ("
//               "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//               "titulo VARCHAR, "
//               "descricao TEXT, "
//               "data DATETIME)";
//           db.execute(sql);
//         }
//     );
//     return db;
//   }
//
//   // _onCreate(Database db, int version) async {
//   //
//   //   String sql = "CREATE TABLE $nameTable ("
//   //       "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//   //       "titulo VARCHAR, "
//   //       "descricao TEXT, "
//   //       "data DATETIME)";
//   //   await db.execute(sql);
//   //
//   // }
//   // Future<int>salvarAnotacao(modelAnotacao modelAnotacao) async {
//   //
//   //   var bancoDados = await bancodados;
//   //   int resultado = await bancoDados.insert(nameTable, modelAnotacao.toMap());
//   //   return resultado;
//   // }
//
//
//
//
// }