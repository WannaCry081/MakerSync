import "dart:async";
import "package:flutter/material.dart";
import "package:frontend/models/sensor_model.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:frontend/services/sensor_service.dart";

class SensorProvider with ChangeNotifier {
  final SensorService _sensorService = SensorService();
  final SettingsProvider _settingsProvider;

  late Timer? _timer;
  SensorModel? _sensor;

  SensorProvider(this._settingsProvider) {
    _sensor = null;
    fetchSensor().then((_) {
      notifyListeners();
    });
    // notifyListeners();
  }

  void setSensorData(SensorModel data) {
    _sensor = data;
  }

  
  Future<void> fetchSensor() async {
    setSensorData(sensor);
    notifyListeners();
  }

  Future<void> updateSensor({
    int? counter,
    int? timer,
    double? temperature,
    bool? isInitialized,
    bool? isStart,
    bool? isStop,
  }) async {

    await _sensorService.updateSensor(
      counter: counter,
      timer: timer,
      temperature: temperature,
      isInitialized: isInitialized,
      isStart: isStart,
      isStop: isStop
    );

    await fetchSensor();
  }

  Future<void> startFetchingSensorValues() async {
    _timer = Timer.periodic(const Duration(seconds: 500), (timer) async {
      await fetchSensor();
    });
  }

  SensorModel? getSensorData(){
    return _sensor;
  }


}