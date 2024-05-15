import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/providers/sensor_provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/widgets/text_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ConnectedView extends StatelessWidget {
  final SettingsProvider settingsProvider;

  const ConnectedView({
    Key? key,
    required this.settingsProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorProvider>(
      builder: (context, sensorProvider, child) {
        final sensor = sensorProvider.getSensorData();

        if (sensor == null) {
          return const CircularProgressIndicator();
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15.h),
              CircularPercentIndicator(
                radius: 120.r,
                lineWidth: 35,
                percent: 0,
                // percent: sensor.timer.toDouble() / 100,
                progressColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                circularStrokeCap: CircularStrokeCap.round,
                center: MSTextWidget(
                  "${(sensor.timer * 100).toInt()}%",
                  fontColor: Theme.of(context).colorScheme.onBackground,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svgs/Thermometer.svg"),
                      SizedBox(width: 10.w),
                      MSTextWidget(
                        "${sensor.temperature}°C",
                        fontColor: Theme.of(context).colorScheme.onBackground,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
