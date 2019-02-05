import 'package:flutter/material.dart';
import 'package:ftm_client_flutter/app/temperature/page/homePage.dart';
import 'package:ftm_client_flutter/app/temperature/sensor/page/addSensorPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/addSensor': (context) => AddSensorPage()
      },
    );
  }
}
