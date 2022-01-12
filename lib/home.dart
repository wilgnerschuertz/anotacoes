import 'package:anotacoes/helper/database.dart';
import 'package:anotacoes/model/model-anotacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  var _db = DatabaseHelper();

  _exibirTelaCadastro(){
    showCupertinoDialog(context: context, builder: (context){

      return CupertinoAlertDialog(
        title: Text('Nova Anotação'),
        content: Card(
          child: Column(
            children: [
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: 'Tarefa',
                  hintText: 'Digite uma TAREFA',
                  filled: true,

                ),
              ),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite uma DESCRIÇÃO',
                  filled: true,
                ),
              )
            ],
          ),
        ),
      actions: [
        CupertinoDialogAction(child: Text('Cancelar'),onPressed: () => Navigator.pop(context),),
        CupertinoDialogAction(
            child: Text('Salvar'),
            onPressed:(){

          _salvarAnotacao();
          Navigator.pop(context);
        })
          ],
        );
      }
    );

  }


  _recuperarAnotacoes(){



  }

  _salvarAnotacao() async {

    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;
    modelAnotacao anotacao = modelAnotacao(titulo, descricao, DateTime.now().toString());

    int resultado = await _db.salvarAnotacao(anotacao);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anotações'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _exibirTelaCadastro();
        },
      ),
    );
  }
}



// title: Text('Nova Anotação'),
// content: Column(
//   children: [
//     TextField(
//       controller: _tituloController,
//       autofocus: true,
//       decoration: InputDecoration(
//           labelText: 'Título',
//           hintText: 'Digite um título'
//       ),
//     ),
//     TextField(
//       controller: _descricaoController,
//       decoration: InputDecoration(
//           labelText: 'Descrição',
//           hintText: 'Digite uma descrição'
//       ),
//          )
//       ],
//     ),
//   actions: [
//     TextButton(onPressed: () => Navigator.pop(context),
//         child: Text('Cancelar')
//       ),
//     TextButton(onPressed: () => Navigator.pop(context),
//         child: Text('Salvar')
//     )
//     ],