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
      timer: json["timer"] as int? ?? 0,    
      temperature: (json["temperature"] as num?)?.toDouble() ?? 0.0,
      isInitialized: json["isInitialized"] as bool? ?? false, 
      isStart: json["isStart"] as bool? ?? false,             
      isStop: json["isStop"] as bool? ?? false,              
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "counter": counter,
      "timer": timer,
      "temperature": temperature,
      "isInitialized": isInitialized,
      "isStart": isStart,
      "isStop": isStop,
    };
  }

}