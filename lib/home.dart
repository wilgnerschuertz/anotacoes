import 'package:anotacoes/model/model-anotacao.dart';
import 'package:flutter/material.dart';
import 'package:anotacoes/helper/database.dart.dart';
import 'package:anotacoes/model/model-anotacao.dart.dart';

import 'helper/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  var _db = AnotacaoHelper();
  List<modelAnotacao> _anotacoes = <modelAnotacao>[];

  _exibirTelaCadastro(){

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Adicionar anotação"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _tituloController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Título",
                      hintText: "Digite título..."
                  ),
                ),
                TextField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                      labelText: "Descrição",
                      hintText: "Digite descrição..."
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar")
              ),
              FlatButton(
                  onPressed: (){

                    //salvar
                    _salvarAnotacao();

                    Navigator.pop(context);
                  },
                  child: Text("Salvar")
              )
            ],
          );
        }
    );

  }

  _recuperarAnotacoes() async {

    List anotacoesRecuperadas = await _db.recuperarAnotacoes();

    List<modelAnotacao> listaTemporaria = <modelAnotacao>[];
    for( var item in anotacoesRecuperadas ){

      modelAnotacao anotacao = modelAnotacao.fromMap( item );
      listaTemporaria.add( anotacao );

    }

    setState(() {
      _anotacoes = listaTemporaria;
    });
    listaTemporaria = '' as List<modelAnotacao>;

    //print("Lista anotacoes: " + anotacoesRecuperadas.toString() );

  }

  _salvarAnotacao() async {

    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    //print("data atual: " + DateTime.now().toString() );
    modelAnotacao anotacao = modelAnotacao(titulo, descricao, DateTime.now().toString() );
    int resultado = await _db.salvarAnotacao( anotacao );
    print("salvar anotacao: " + resultado.toString() );

    _tituloController.clear();
    _descricaoController.clear();

    _recuperarAnotacoes();

  }

  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas anotações"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _anotacoes.length,
                  itemBuilder: (context, index){

                    final anotacao = _anotacoes[index];

                    return Card(
                      child: ListTile(
                        title: Text(anotacao.titulo),
                        subtitle: Text("${anotacao.data} - ${anotacao.descricao}") ,
                      ),
                    );

                  }
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
            _exibirTelaCadastro();
          }
      ),
    );
  }
}



















// import 'package:anotacoes/helper/database.dart';
// import 'package:anotacoes/model/model-anotacao.dart';
// import 'package:flutter/material.dart';
//
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//
//   //
//   final TextEditingController _tituloController = TextEditingController();
//   final TextEditingController _descricaoController = TextEditingController();
//   var _db = AnotacaoHelper();
//
//   _exibirTelaCadastro(){
//     showDialog(
//       context: context,
//       builder: (context){
//         return AlertDialog(
//           title: const Text("Adicionar anotação"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: _tituloController,
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                     labelText: "Título",
//                     hintText: "Digite título..."
//                 ),
//               ),
//               TextField(
//                 controller: _descricaoController,
//                 decoration: const InputDecoration(
//                     labelText: "Descrição",
//                     hintText: "Digite descrição..."
//                 ),
//               )
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancelar")
//             ),
//             TextButton(
//                 onPressed: (){
//
//                   //salvar
//                   _salvarAnotacao;
//
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Salvar")
//             )
//           ],
//         );
//       }
//   );
//
//   }
//
//
//   _recuperarAnotacoes(){
//
//   }
//
//   _salvarAnotacao() async {
//
//     String titulo = _tituloController.text;
//     String descricao = _descricaoController.text;
//     modelAnotacao anotacao = modelAnotacao(
//         titulo,
//         descricao,
//         DateTime.now().toString());
//
//     // int resultado = await _db.salvarAnotacao(anotacao);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Anotações'),
//       ),
//       body: Container(),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: (){
//           _exibirTelaCadastro;
//         },
//       ),
//     );
//   }
// }