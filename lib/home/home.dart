
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

  List _toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Container();
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

