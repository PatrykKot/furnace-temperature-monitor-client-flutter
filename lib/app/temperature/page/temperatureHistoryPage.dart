import 'package:flutter/material.dart';
import 'package:ftm_client_flutter/app/component/chart/chart.dart';
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

  List<ChartData> series = [
    ChartData(date: DateTime(2019, 1, 1), value: 20),
    ChartData(date: DateTime(2019, 1, 2), value: 22),
    ChartData(date: DateTime(2019, 1, 3), value: 21),
    ChartData(date: DateTime(2019, 1, 4), value: 25),
    ChartData(date: DateTime(2019, 1, 5), value: 27)
  ];

  @override
  void initState() {
    super.initState();

    // TODO create sample data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historia temperatury'),
      ),
      body: SizedBox.expand(
        child: LineChart(series),
      ),
    );
  }
}
