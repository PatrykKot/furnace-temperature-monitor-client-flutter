import 'package:flutter/material.dart';
import 'package:ftm_client_flutter/app/sensor/dto/sensor.dart';

class AddSensorPage extends StatefulWidget {
  AddSensorPage({Key key}) : super(key: key);

  @override
  _AddSensorPageState createState() => _AddSensorPageState();
}

class _AddSensorPageState extends State<AddSensorPage> {
  List<SensorDto> sensors = [
    SensorDto(1, 'Pokój 5', '12234234234'),
    SensorDto(2, 'Pokój 12', '12234234234'),
    SensorDto(3, 'Pokój 23', '12234234234'),
    SensorDto(4, 'Pokój 54', '12234234234'),
    SensorDto(5, 'Pokój 6', '12234234234'),
    SensorDto(6, 'Pokój 675', '12234234234'),
  ]; // TODO fetch from server

  _addSensor(context, int id) {
    print('TODO add sensor');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Czujnik został dodany'),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dodawanie czujników')),
      body: ListView(
        children: sensors.map<Widget>((sensor) {
          return Builder(
              builder: (context) => ListTile(
                    title: Text(sensor.name),
                    subtitle: Text(sensor.address),
                    trailing: GestureDetector(
                      child: Icon(Icons.add),
                      onTap: () => _addSensor(context, sensor.id),
                    ),
                  ));
        }).toList(),
      ),
    );
  }
}
