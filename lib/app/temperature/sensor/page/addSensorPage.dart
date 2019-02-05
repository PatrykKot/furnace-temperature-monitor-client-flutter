import 'package:flutter/material.dart';

class AddSensorPage extends StatefulWidget {
  AddSensorPage({Key key}) : super(key: key);

  @override
  _AddSensorPageState createState() => _AddSensorPageState();
}

class _AddSensorPageState extends State<AddSensorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Dodawanie czujników')));
  }
}
