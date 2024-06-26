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

  
  Future<bool> fetchSensor() async {
    try{
      final SensorModel sensor = await _sensorService.fetchSensor(
        settings: _settingsProvider
      );

      if(sensor.isStop == true) {
        stopFetchingSensorValues();
      }

      setSensorData(sensor);
      notifyListeners();

      return true;
    } catch (e) {
      if (e is Exception && e.toString().contains("Sensor not found.")) {
        print("Provider: Sensor not found!");
        return false;
      } else {
        return false;
      }
    }
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await fetchSensor();
    });
  }

  Future<void> updateTime({
    required int maxTimer
  }) async {
    int currentValue = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (currentValue <= maxTimer) {
        await _sensorService.updateSensor(
          counter: currentValue,
        );
        currentValue++;
      } else {
        _timer?.cancel();
      }
    });
  }

  SensorModel? getSensorData(){
    return _sensor;
  }

  void stopFetchingSensorValues() async {
    _timer?.cancel();
  }


}