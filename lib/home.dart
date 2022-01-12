import 'package:anotacoes/helper/database.dart';
import 'package:anotacoes/model/model-anotacao.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  var _db = DatabaseHelper();

  _exibirTelaCadastro(){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("Adicionar anotação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _tituloController,
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: "Título",
                    hintText: "Digite título..."
                ),
              ),
              TextField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                    labelText: "Descrição",
                    hintText: "Digite descrição..."
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar")
            ),
            TextButton(
                onPressed: (){

                  //salvar
                  _salvarAnotacao;

                  Navigator.pop(context);
                },
                child: const Text("Salvar")
            )
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
    modelAnotacao anotacao = modelAnotacao(
        titulo,
        descricao,
        DateTime.now().toString());

    // int resultado = await _db.salvarAnotacao(anotacao);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          _exibirTelaCadastro;
        },
      ),
    );
  }
}