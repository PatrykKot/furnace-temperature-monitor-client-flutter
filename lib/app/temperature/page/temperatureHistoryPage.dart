import 'package:flutter/material.dart';
import 'package:ftm_client_flutter/app/sensor/dto/sensor.dart';

class TemperatureHistoryPage extends StatefulWidget {
  TemperatureHistoryPage(
      {Key key, @required this.initialDate, @required this.sensor})
      : super(key: key);

  final DateTime initialDate;

  final SensorDto sensor;

  @override
  _TemperatureHistoryPageState createState() =>
      _TemperatureHistoryPageState(initialDate, sensor);
}

class _TemperatureHistoryPageState extends State<TemperatureHistoryPage> {
  _TemperatureHistoryPageState(DateTime initialDate, SensorDto sensor)
      : sensor = sensor,
        initialDate = initialDate;

  DateTime initialDate;

  SensorDto sensor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historia temperatury'),
      ),
    );
  }
}
