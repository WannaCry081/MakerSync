import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/providers/notification_provider.dart";
import "package:frontend/providers/sensor_provider.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:frontend/providers/user_provider.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:provider/provider.dart";

class InitializeView extends StatefulWidget {
  final SensorProvider sensorProvider;
  final SettingsProvider settingsProvider;

  const InitializeView({
    required this.sensorProvider,
    required this.settingsProvider,
    super.key
  });

  @override
  State<InitializeView> createState() => _InitializeViewState();
}

class _InitializeViewState extends State<InitializeView> {
  bool _isLoading = false;

  late UserProvider _userProvider;
  late NotificationProvider _notificationProvider;  

  int currentValue = 0;
  Timer? _timer;
  

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
  }
  
  int _clickedOption = -1;
  final _options = [
    {
      "type" : "Default Option",
      "time" : "Selecting this option will not initiate a timer, and therefore, no notifications will be sent upon completion of the filament process.",
      "image" : "",
      "timer" : 0
    },
    {
      "type" : "500 ml",
      "time" : "Approx. 20 minutes",
      "image" : "assets/svgs/Bottle_500ml.svg",
      "timer" : 1200 // 1200 seconds
    },
    {
      "type" : "1000 ml",
      "time" : "Approx. 40 minutes",
      "image" : "assets/svgs/Bottle_1000ml.svg",
      "timer" : 2400 //seconds
    },
    {
      "type" : "1500 ml",
      "time" : "1 Hour 10 mins",
      "image" : "assets/svgs/Bottle_1500ml.svg",
      "timer" : 4200 //seconds
    },
    {
      "type" : "2000 ml",
      "time" : "1 Hour 30 mins",
      "image" : "assets/svgs/Bottle_2000ml.svg",
      "timer" : 5700 //seconds
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height : 20.h),

        MSTextWidget(
          "Choose a bottle to start",
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          fontColor: Theme.of(context).colorScheme.primary
        ),

        SizedBox(height : 3.h),

        const MSTextWidget(
          "Selecting a bottle will allow the system to estimate the required time for completion and notify you once it is finished.",
          textAlign: TextAlign.center,
        ),

        Expanded(
          child: ListView.builder(
            itemCount: _options.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  setState(() {
                    _clickedOption = index;
                  });
                },
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                
                    bottleOption(
                      title: _options[index]["type"].toString(),
                      time: _options[index]["time"].toString(),
                      image: _options[index]["image"].toString(),
                      index: index
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        
        MSButtonWidget(
          btnOnTap: () async {
            int timer = _options[_clickedOption]["timer"] as int;

            await initializeMachine();
            setState(() {
              int maxTimer = _options[_clickedOption]["timer"] as int;
              if (maxTimer > 0) {
                _startTimer(maxTimer);
              }
              });
          },
          btnIsLoading: _isLoading,
          btnColor: Theme.of(context).colorScheme.primary,
          child: Center(
            child: MSTextWidget(
              "Submit",
              fontColor: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            )
          )
        )
      ],
    );
  }

  Widget bottleOption({
  required String title,
  required String image,
  required String time,
  required int index,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 7.w),
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 280,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: (_clickedOption == index) 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
              width: (_clickedOption == index) 
                ? 2.0
                : 1.0
            )
          ),
        ),

        if (index != 0)
          Positioned(
            top: -50,
            child: SvgPicture.asset(
              image,
              height: 200.h,
            ),
          ),

        Positioned(
          bottom: (index == 0) ? 80 : 15,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45 - 16.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MSTextWidget(
                  title,
                  textAlign: TextAlign.center,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontColor: Theme.of(context).colorScheme.primary,
                ),
                
                if(index == 0)
                SizedBox(height: 10.h),

                MSTextWidget(
                  time,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  fontColor: Theme.of(context).colorScheme.onBackground,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


 void _startTimer(int maxTimer) {

  final isStop = widget.settingsProvider.getBool("isStop");

  _timer?.cancel(); 
  currentValue = 0;

  _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (currentValue <= maxTimer) {
      int percent = ((currentValue / maxTimer) * 100).toInt();
      print("Current Value: $currentValue, Max Timer: $maxTimer, Percent: $percent");

      if (!isStop) {
        
        print("--------UPDATED COUNTER!-----------");

        if(currentValue == 100) {
          timer.cancel();
          
          _notificationProvider.createNotification(
            title: "Petamentor has finished.",
            content: "Petamentor has successfully completed the process.",
          );
          
        }

        await widget.sensorProvider.updateSensor(
          counter: percent,
        );

      }
      currentValue++;
    } else {
      timer.cancel();
      print("Timer Cancelled");
    }
  });
}

Future<void> initializeMachine() async {
    try {
      final _user = _userProvider.getUserData();
      final isStop = widget.settingsProvider.getBool("isStop");

      int maxTimer = _options[_clickedOption]["timer"] as int;

      setState(() => _isLoading = true);

      await widget.sensorProvider.updateSensor(
        isInitialized: true,
        isStart: true,
        isStop: false,
        timer: maxTimer,
      );

      widget.settingsProvider.setBool("isConnect", true);
      widget.settingsProvider.setBool("isInitialize", true);
      widget.settingsProvider.setInt("timer", maxTimer);

      _notificationProvider.createNotification(
        title: "Petamentor has started.",
        content: "${_user?.username.split(' ').first ?? ""} has initialized the machine. Petamentor is starting.",
      );

      Future.delayed(
        const Duration(seconds: 2),
          () {
            if (mounted) setState(() => _isLoading = false);
          },
      );

    } catch (e) {
      print("Error updating sensor: $e");
    }
  }

}