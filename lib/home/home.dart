
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

  List _toDoList = ["Paulo","Victor","Santos","Magalhães"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                 decoration: InputDecoration(
                     labelText: "Nova Tarefa",
                     labelStyle: TextStyle(color: Colors.lightBlueAccent)
                 ),
               )),
                RaisedButton(
                  color: Colors.lightBlueAccent,
                    child: Text("ADD"),
                    textColor: Colors.white,
                    onPressed: (){},
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: (context, index){
                  return CheckboxListTile(
                    title: Text(_toDoList[index]["title"],
                    style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                    value: _toDoList[index]["ok"],
                    secondary: CircleAvatar(
                      child: Icon(_toDoList[index]["ok"] ?
                          Icons.check : Icons.error
                      ) ,
                    ),
                  );
                  }
              )
          )
        ],
      ),
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

