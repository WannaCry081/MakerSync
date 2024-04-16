import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/views/Dashboard/Home/emergency_view.dart';
import 'package:frontend/views/Dashboard/Home/members_view.dart';
import 'package:frontend/views/Dashboard/Home/overview_view.dart';
import 'package:frontend/widgets/text_widget.dart';
import 'package:frontend/widgets/wrapper_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late SettingsProvider _settingsProvider;
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _settingsProvider = Provider.of<SettingsProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    
    final _user = _userProvider.getUserData();

     return Scaffold(
      body: MSWrapperWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 22.h
          ),

          child: content(_user)
        ),
      )
    );
  }

  Widget content(
    UserModel? user
  ) {

    final _auth = MakerSyncAuthentication();

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
                SizedBox(height: 10.h),

                _settingsProvider.getBool("isConnect")
                ?  MSTextWidget(
                    "Hello, ${user?.name.split(' ').first ?? ""}!",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    fontColor: Theme.of(context).colorScheme.primary
                  )
                :  MSTextWidget(
                    "Hello, there!",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    fontColor: Theme.of(context).colorScheme.primary
                  ),
        
                SizedBox(height : 3.h),
      
                const MSTextWidget(
                  "Let's start tracking your progress!")
              ],
            ),
            
            CircleAvatar(
              radius: 24.r,
              backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundImage: _auth.getUserPhotoUrl == ""
                ? const Image(
                    image: AssetImage("assets/svgs/Logo_LightMode.svg"),
                  ).image
                : NetworkImage(_auth.getUserPhotoUrl)
            )
            ],
          ),
      
          SizedBox(height: 30.h),

          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            width: MediaQuery.of(context).size.width,
            child: TabBar(
              tabs: const [
                Tab(text: "Overview"),
                Tab(text: "Members"),
                Tab(text: "Emergency"),
              ],
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab, 
              indicatorPadding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 6.h
              ),
              labelColor: Colors.white,
              labelStyle: const TextStyle(
                fontFamily: "Inter",
              ),
              unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
              splashFactory: NoSplash.splashFactory,


            ),
          ),
          
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.62,
            child:  const TabBarView(
              children: [
                Center(child: OverviewView()),
                Center(child: MembersView()),
                Center(child: EmergencyView()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
