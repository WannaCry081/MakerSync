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
    return Sensor(
      counter: json['counter'] as int? ?? 0, 
      timer: json['timer'] as int? ?? 0,    
      // temperature: json['temperature'] as double?,  
      isInitialized: json['isInitialized'] as bool? ?? false, 
      isStart: json['isStart'] as bool? ?? false,             
      isStop: json['isStop'] as bool? ?? false,              
    );
  }
}