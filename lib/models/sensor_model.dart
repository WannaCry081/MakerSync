class SensorModel {
  final int counter;
  final int timer;
  final double temperature;
  final bool isInitialized;
  final bool isStart;
  final bool isStop;

  const SensorModel({
    required this.counter,
    required this.timer,
    required this.temperature,
    required this.isInitialized,
    required this.isStart,
    required this.isStop
  });

  factory SensorModel.fromJson(Map <String, dynamic> json) {
    return SensorModel(
      counter: json["counter"] as int? ?? 0, 
      timer: json["time"] as int? ?? 0,    
      temperature: (json["temperature"] as num?)?.toDouble() ?? 0.0,
      isInitialized: json["is_initialize"] as bool? ?? false, 
      isStart: json["is_start"] as bool? ?? false,             
      isStop: json["is_stop"] as bool? ?? false,              
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "counter": counter,
      "time": timer,
      "temperature": temperature,
      "is_initialize": isInitialized,
      "is_start": isStart,
      "is_stop": isStop,
    };
  }

}