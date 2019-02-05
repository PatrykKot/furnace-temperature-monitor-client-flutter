import 'package:ftm_client_flutter/app/sensor/dto/sensor.dart';

class LastTemperatureLogDto {
  int id;
  double value;
  SensorDto sensor;

  LastTemperatureLogDto(this.id, this.value, this.sensor);
}
