class Sensor {
  final int counter;
  final int timer;
  // final double temperature;
  final bool isInitialized;
  final bool isStart;
  final bool isStop;

  const Sensor({
    required this.counter,
    required this.timer,
    // required this.temperature,
    required this.isInitialized,
    required this.isStart,
    required this.isStop
  });

  factory Sensor.fromJson(Map <String, dynamic> json) {
    return switch (json){
      {
        "counter" : int counter,
        "timer" : int timer,
        // "temperature" : double temperature,
        "isInitialized" : bool isInitialized,
        "isStart" : bool isStart,
        "isStop" : bool isStop
      } =>
        Sensor (
          counter: counter,
          timer: timer,
          // temperature: temperature,
          isInitialized: isInitialized,
          isStart: isStart,
          isStop: isStop
        ),
        _ => throw const FormatException("Failed to load sensor.")
      
    };
  }
}