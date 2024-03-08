import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:frontend/views/Dashboard/Settings/index.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";
import "package:provider/provider.dart";

class DarkModeView extends StatefulWidget {
  const DarkModeView({super.key});

  @override
  State<DarkModeView> createState() => _DarkModeViewState();
}

class _DarkModeViewState extends State<DarkModeView> {
  SwitchOptions? _option = SwitchOptions.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).colorScheme.background
        : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: Theme.of(context).brightness == Brightness.dark
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                  Theme.of(context).colorScheme.secondary
                ]
              )
            ),
        child: MSWrapperWidget(
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22.w,
                vertical: 22.h
              ),

              child: content()
          )
        )
      )
    );
  }

  Widget content(){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MSBackButtonWidget(
                btnOnTap: navigateToSettings
              ),

              SizedBox(width: 15.w),

              MSTextWidget(
                "Dark Mode",
                fontSize: 26.sp, 
                fontColor: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
      
          SizedBox(height: 30.h),

          switchOption(
            title: "On",
            value: SwitchOptions.dark
          ),
          switchOption(
            title: "Off",
            value: SwitchOptions.light
          ),
          switchOption(
            title: "Use System Settings",
            value: SwitchOptions.system
          )
        ]
      );
  }

  Widget switchOption({
    required String title,
    required SwitchOptions value,
  }){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MSTextWidget(
          title,
          fontColor: Theme.of(context).colorScheme.onBackground,
          fontSize: 16.sp,
        ),

        Radio<SwitchOptions> (
          value: value,
          groupValue: _option,
          onChanged: onChangedHandler
        ),
      ],
    );
  }

  void onChangedHandler(SwitchOptions? value){
    final SettingsProvider settings = Provider.of<SettingsProvider>(context, listen: false);

    setState(() =>  _option = value);

    if(value != null) {
      final Map<SwitchOptions, String> themeMap = {
        SwitchOptions.dark: "dark",
        SwitchOptions.light: "light",
        SwitchOptions.system: "system"
      };

      String theme = themeMap[value] ?? "system";
      settings.setString("theme", theme);
    }
  }

  void navigateToSettings(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsView()
      )
    );
  }

}

enum SwitchOptions {
  dark, 
  light, 
  system,
}