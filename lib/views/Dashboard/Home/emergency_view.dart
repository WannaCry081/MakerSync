import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/models/sensor_model.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/services/sensor_service.dart';
import 'package:frontend/widgets/disconnected_view.dart';
import 'package:frontend/widgets/snackbar_widget.dart';
import 'package:frontend/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {

  late Future<List<dynamic>> sensor;
  
  final SensorService _sensorService = SensorService();

  @override
  void initState() {
    super.initState();
    sensor = _sensorService.fetchSensors();
  }

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settings =  Provider.of<SettingsProvider>(context);
    final _isConnect = settings.getBool("isConnect");
    final _isInitialize = settings.getBool("isInitialize");

    return _isConnect && _isInitialize
      ? content(context: context)
      : const DisconnectedViewWidget();
  }

  Widget content({
    required BuildContext context
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children:[
            Container(
              height: 260.h, 
              width: 260.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).brightness == Brightness.dark  
                  ? Colors.grey.shade600
                  : Colors.grey.shade200
              )
            ),
            Positioned.fill(
              child: Center(
                child: ElevatedButton(
                  onPressed: () => stopSensor(context),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.symmetric(
                      vertical: 60.h,
                      horizontal: 60.w),
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                  ),
                  child: MSTextWidget(
                    "STOP",
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            )
          ]
        ),

        SizedBox(height: 40.h),

        MSTextWidget(
          "Press the button to initiate an emergency stop of the machine.",
          fontSize: 16.sp,
          textAlign: TextAlign.center,
        )
      ],
    );
  }


  void stopSensor(context) async {
    try {
      await _sensorService.updateSensor(
        counter: 0,
        timer: 0,
        temperature: 0,
        isInitialized: false,
        isStart: false,
        isStop: true
      );

      const MSSnackbarWidget(
        message: "You have stopped the machine operation.",
      ).showSnackbar(context);

    } catch (e) {
      print("Error: $e");
    }
  }
}