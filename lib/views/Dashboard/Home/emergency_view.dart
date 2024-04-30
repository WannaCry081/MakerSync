import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/models/sensor_model.dart';
import 'package:frontend/providers/sensor_provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/widgets/dialog_widget.dart';
import 'package:frontend/widgets/disconnected_view.dart';
import 'package:frontend/widgets/snackbar_widget.dart';
import 'package:frontend/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class EmergencyView extends StatefulWidget {
  final VoidCallback? navigateToOverview;

  const EmergencyView({
    Key? key, 
    this.navigateToOverview
  }) : super(key:key);

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {

  late SensorProvider _sensorProvider;

  @override
  void initState() {
    super.initState();
    _sensorProvider = Provider.of<SensorProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settings =  Provider.of<SettingsProvider>(context);
    final _isConnect = settings.getBool("isConnect");
    final _isInitialize = settings.getBool("isInitialize");

    final SensorModel? sensor = _sensorProvider.getSensorData();

    return _isConnect && _isInitialize
      ? content(sensor)
      : const DisconnectedViewWidget();
  }

  Widget content(SensorModel? sensor) {
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
                  // onPressed: sensor == null ? null : () => stopSensor(),
                  onPressed: ()  {
                    // if (widget.navigateToOverview != null) {
                    //   widget.navigateToOverview!(); 
                    // }

                    stopMachine();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context){
                        return MSDialogWidget(
                          dialogTitle: "Would you like to continue the progress?", 
                          dialogSubtitle: "Please choose between re-intializing the machine or continuing the current progress.",
                          dialogOption1: "Continue the progress.", 
                          dialogOption2: "Re-initialize the machine.",
                          dialogOption1Ontap: continueProgress,
                          dialogOption2Ontap: resetMachine,
                        );
                      }
                    );
                  },
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

  void stopMachine() async {
    await _sensorProvider.updateSensor(
      isStart: false,
      isStop: true
    );

    const MSSnackbarWidget(
      message: "You have stopped the machine operation.",
    ).showSnackbar(context);
  }

   void resetMachine() async { 
    print("reset machine!");
    await _sensorProvider.updateSensor(
      counter: 0,
      timer: 0,
      temperature: 0,
      isInitialized: false,
    );
  }

  void continueProgress() async { 
    print("continue progress!");
    await _sensorProvider.updateSensor(
      isInitialized: true,
    );
  }
  
}