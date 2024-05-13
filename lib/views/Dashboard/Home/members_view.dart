import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/widgets/disconnected_view.dart';
import 'package:frontend/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class MembersView extends StatefulWidget {
  const MembersView({super.key});

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  
  // final UserService _userService = UserService();
  late UserProvider _userProvider;
  late Future<List<UserModel>> _users;


  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _users = _userProvider.fetchUsers();
    // users = _userService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settings = Provider.of<SettingsProvider>(context);
    final bool _isConnect = settings.getBool("isConnect");
    final bool _isInitialize = settings.getBool("isInitialize");

    return Scaffold(
      body: Center(
        child: _isConnect && _isInitialize
          ? Container(
              padding: EdgeInsets.only(top: 15.h),
              child: FutureBuilder<List<UserModel>> (
                  future: _users,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<UserModel> users = snapshot.data!;

                      if(users.isEmpty){
                        return Center(
                          child: MSTextWidget(
                            "No connected users",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontColor: Theme.of(context).colorScheme.onBackground,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final UserModel user = users[index];
                          return memberCard(
                            context: context,
                            email: user.email,
                            name: user.username,
                          );
                        },
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
    );
  }

  

  Widget memberCard({
    required BuildContext context,
    required String name,
    required String email
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.5.h),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: Row(
          children: [
            Stack(
              children: [
               SvgPicture.asset(
                  Theme.of(context).brightness == Brightness.dark
                  ? "assets/svgs/Logo_DarkMode.svg"
                  : "assets/svgs/Logo_LightMode.svg",
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    height: 12.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade400
                    ),
                  ),
                )
              ],
            ),

            SizedBox(width: 12.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MSTextWidget(
                  name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontColor: Theme.of(context).colorScheme.onBackground,
                ),

                SizedBox(height: 3.h),

                MSTextWidget(
                  email,
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.grey.shade600,
                  fontHeight: 1.h,
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
