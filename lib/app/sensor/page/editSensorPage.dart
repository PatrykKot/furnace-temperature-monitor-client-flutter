import 'package:flutter/material.dart';
import 'package:ftm_client_flutter/app/sensor/dto/sensor.dart';

class EditSensorPage extends StatefulWidget {
  EditSensorPage({Key key, @required this.sensor}) : super(key: key);

  final SensorDto sensor;

  @override
  _EditSensorPageState createState() => _EditSensorPageState(sensor);
}

class _EditSensorPageState extends State<EditSensorPage> {
  _EditSensorPageState(this.sensor);

  final SensorDto sensor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Konfiguracja czujnika')),
    );
  }
}
