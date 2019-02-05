import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:ftm_client_flutter/app/sensor/dto/sensor.dart';

class TemperatureHistoryPage extends StatefulWidget {
  TemperatureHistoryPage({Key key, @required this.initialDate, @required this.sensor})
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
  List<charts.Series> seriesList;

  @override
  void initState() {
    super.initState();
    seriesList = _createSampleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historia temperatury'),
      ),
      body: Container(
        child: charts.TimeSeriesChart(
          seriesList,
          animate: true,
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        ),
      ),
    );
  }

  static List<charts.Series<SimpleTimeSeries, DateTime>> _createSampleData() {
    final data = [
      new SimpleTimeSeries(new DateTime(2017, 9, 19), 5),
      new SimpleTimeSeries(new DateTime(2017, 9, 26), 25),
      new SimpleTimeSeries(new DateTime(2017, 10, 3), 100),
      new SimpleTimeSeries(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<SimpleTimeSeries, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SimpleTimeSeries sales, _) => sales.time,
        measureFn: (SimpleTimeSeries sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class SimpleTimeSeries {
  final DateTime time;
  final int sales;

  SimpleTimeSeries(this.time, this.sales);
}
