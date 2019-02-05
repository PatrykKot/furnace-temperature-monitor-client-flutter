import 'package:flutter/material.dart';
import 'package:ftm_client_flutter/app/temperature/dto/temperature.dart';
import 'package:ftm_client_flutter/app/temperature/sensor/dto/sensor.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LastTemperatureLogDto> temperatures = [
    LastTemperatureLogDto(1, 24.5, SensorDto(1, 'Pokój')),
    LastTemperatureLogDto(2, 34.5, SensorDto(2, 'Pokój 5')),
    LastTemperatureLogDto(3, 23.5, SensorDto(3, 'Pokój 4')),
    LastTemperatureLogDto(4, 56.5, SensorDto(4, 'Pokój 23')),
  ]; // TODO fetch from server

  _goToNewSensorsView() {
    Navigator.pushNamed(context, '/addSensor');
  }

  _showModal(sensorId) {
    print(sensorId);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.history),
                title: new Text('Pokaż historię'),
                onTap: () => {},
              ),
              new ListTile(
                leading: new Icon(Icons.settings),
                title: new Text('Edytuj czujnik'),
                onTap: () => {},
              ),
              new ListTile(
                leading: new Icon(Icons.delete),
                title: new Text('Usuń czujnik'),
                onTap: () => {},
              ),
            ],
          );
        });
  }

  _generateTemperatureCard(LastTemperatureLogDto temperature) {
    return InkWell(
        onTap: () => _showModal(temperature.sensor.id),
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
