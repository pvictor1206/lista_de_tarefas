
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _toDoController = TextEditingController();

  List _toDoList = [];


  @override
  void initState() {
    super.initState();
    
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    // Atualizar o estado da tela
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text("Lista de Tarefas do Paulinho :3", style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
               Expanded(child:  TextField(
                 controller: _toDoController,
                 decoration: InputDecoration(
                     labelText: "Nova Tarefa",
                     labelStyle: TextStyle(color: Colors.deepPurple)
                 ),
               )),
                RaisedButton(
                  color: Colors.lightBlueAccent,
                    child: Text("Adicinar"),
                    textColor: Colors.black,
                    onPressed: _addToDo,
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem
              )
          )
        ],
      ),
    );
  }

  // Fazer cada um dos itens da lista
  Widget buildItem(context, index){
    // Arrasta o item para direita
    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9,0.0),
          child: Icon(Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
        direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"],
          style: TextStyle(color: Colors.black),
        ),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]["ok"] ?
          Icons.check : Icons.error
          ) ,
        ),
        onChanged: (c){
          setState(() {
            _toDoList[index]["ok"] = c;
            _saveData();
          });
        },
      )
      ,
    );

  }

  // Obter o arquivo
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  // Salvar um dado no arquivo
  Future<File> _saveData() async {
    String data = json.encode(_toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  // ler os dados no arquivo
  Future<String> _readData() async {
   try{
     final file = await _getFile();

     return file.readAsString();
   } catch (e) {
     return null;
   }
  }

}


