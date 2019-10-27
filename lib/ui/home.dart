import 'package:flutter/material.dart';
import 'package:fl_todoApp/ui/todo_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text("FL TODO app"),
        backgroundColor: Colors.black54,
      ),
      body: TodoScreen(),
    );
  }
}