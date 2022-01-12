import 'package:anotacoes/model/model-anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {

  // modelAnotacao modelanotacao = new modelAnotacao('', '', '');

  static const String nameTable = 'anotacao';
  static final DatabaseHelper _databaseHelper = DatabaseHelper();
  late Database _bancodados;

  factory DatabaseHelper(){
    return _databaseHelper;
  }


  get bancodados async {
    if (null != _bancodados){
      return _bancodados;
    }else{
      _bancodados = await startBanco();
      return _bancodados;
    }
  }


  _onCreate(Database db, int version) async {

    String sql = "CREATE TABLE $nameTable ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "titulo VARCHAR, "
        "descricao TEXT, "
        "data DATETIME)";
    await db.execute(sql);

  }

  startBanco() async {

    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, 'banco.db');

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }


  Future<int>salvarAnotacao(modelAnotacao modelAnotacao) async {

    var bancoDados = await bancodados;
    int resultado = await bancoDados.insert(nameTable, modelAnotacao.toMap());
    return resultado;
  }




}