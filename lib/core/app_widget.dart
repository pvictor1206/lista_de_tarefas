import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/home/home.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      home: MyHomePage(title: 'Flutter Demo Home Page'), //Tela principal
    );
  }
}
