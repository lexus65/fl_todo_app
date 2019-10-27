import 'package:flutter/material.dart';
import 'package:fl_todoApp/ui/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'fl TODO app',
        home: new Home(),
    ); 
  }
}
