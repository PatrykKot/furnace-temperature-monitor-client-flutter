import 'package:flutter/material.dart';
import 'package:ftm_client_flutter/app/sensor/dto/sensor.dart';
import 'package:ftm_client_flutter/app/sensor/page/addSensorPage.dart';
import 'package:ftm_client_flutter/app/sensor/page/editSensorPage.dart';
import 'package:ftm_client_flutter/app/temperature/dto/temperature.dart';
import 'package:ftm_client_flutter/app/temperature/page/temperatureHistoryPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LastTemperatureLogDto> temperatures = [
    LastTemperatureLogDto(1, 24.5, SensorDto(1, 'Pokój', 'sdfsd')),
    LastTemperatureLogDto(2, 34.5, SensorDto(2, 'Pokój 5', 'sdfsd')),
    LastTemperatureLogDto(3, 23.5, SensorDto(3, 'Pokój 4', 'sdfsd')),
    LastTemperatureLogDto(4, 56.5, SensorDto(4, 'Pokój 23', 'sdfsd')),
  ]; // TODO fetch from server

  _goToNewSensorsView() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddSensorPage()));
  }

  _showModal(SensorDto sensor) {
    showModalBottomSheet(
        context: context,
        builder: (context) =>
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.history),
                  title: new Text('Pokaż historię'),
                  onTap: () {
                    showSensorHistoryCalendar(sensor, context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.settings),
                  title: new Text('Edytuj czujnik'),
                  onTap: () {
                    goToEditSensorPage(sensor, context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text('Usuń czujnik'),
                  onTap: () => {},
                ),
              ],
            ));
  }

  void goToEditSensorPage(SensorDto sensor, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditSensorPage(sensor: sensor)));
  }

  void showSensorHistoryCalendar(SensorDto sensor, BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TemperatureHistoryPage(
                    sensor: sensor, initialDate: pickedDate)));
  }

  _generateTemperatureCard(LastTemperatureLogDto temperature) {
    return GestureDetector(
        onTap: () => _showModal(temperature.sensor),
        child: Card(
            child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  temperature.sensor.name,
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  temperature.value.toString(),
                  style: Theme.of(context).textTheme.display3,
                ),
              ],
            )
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperatury'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: _goToNewSensorsView)
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: temperatures.map<Widget>((temperature) {
          return _generateTemperatureCard(temperature);
        }).toList(),
      ),
    );
  }
}
