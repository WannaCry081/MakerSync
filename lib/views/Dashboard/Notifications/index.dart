import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/models/notification_model.dart';
import 'package:frontend/providers/notification_provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/widgets/disconnected_view.dart';
import 'package:frontend/widgets/text_widget.dart';
import 'package:frontend/widgets/wrapper_widget.dart';
import 'package:provider/provider.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  late NotificationProvider _notificationProvider;
  late Future<List<NotificationModel>> _notifications;

  @override
  void initState(){
    super.initState();
    _notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    _notifications = _notificationProvider.fetchNotifications();
  }
  

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settings = Provider.of<SettingsProvider>(context);
    final _isConnect = settings.getBool("isConnect");
    final _isInitialize = settings.getBool("isInitialize");

    return Scaffold(
      body: MSWrapperWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 22.h,
          ),
          
          child: content(_isConnect, _isInitialize),
        )
      )
    );
  }


  Widget content(_isConnect, _isInitialize){
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
      
          MSTextWidget(
            "Notifications",
            fontSize: 26.sp,
            fontColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold
          ),
      
          SizedBox(height: 15.h),

          Expanded(
            child: _isConnect && _isInitialize
              ? SizedBox(
                child: FutureBuilder<List<NotificationModel>> (
                  future: _notifications,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final List<NotificationModel> notifications = snapshot.data!;

                      if(notifications.isEmpty){
                        return Center(
                          child: MSTextWidget(
                            "No notifications yet",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontColor: Theme.of(context).colorScheme.onBackground,
                          ),
                        );
                      }

                      ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index){
                          final NotificationModel notification = notifications[index];
                          return notificationCard(
                            context: context,
                            title: notification.title, 
                            content: notification.content,
                            created: notification.created
                          );
                        }
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return const CircularProgressIndicator();
                  },
                )
              )
            : const DisconnectedViewWidget()
          )
        ],
      ),
    );
  }



  Widget notificationCard({
    required BuildContext context, 
    required String title,
    required String content,
    String? created
  }) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 7.5.h,
    ),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).colorScheme.tertiary,
        ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            Theme.of(context).brightness == Brightness.dark
            ? "assets/svgs/Logo_DarkMode.svg"
            : "assets/svgs/Logo_LightMode.svg",
          ),

          SizedBox(width: 12.w),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MSTextWidget(
                  title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontColor: Theme.of(context).colorScheme.onBackground,
                  textOverflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 3.h),

                MSTextWidget(
                  content,
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.grey.shade600,
                  textOverflow: TextOverflow.ellipsis,
                  fontHeight: 1.h,
                )
              ],
            ),
          ),

          MSTextWidget(
            created ?? "",
            fontSize: 10.sp,
            fontColor: Colors.grey.shade500,
            fontHeight: 2.h,
          )
        ],
      ),
    ),
  );
}
}