import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import "package:frontend/providers/notification_provider.dart";
import "package:frontend/providers/sensor_provider.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:frontend/providers/user_provider.dart";
import "package:frontend/services/api_constants.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/views/Dashboard/Home/overview_views/connected_view.dart";
import "package:frontend/views/Dashboard/Home/overview_views/disconnected_view.dart";
import "package:frontend/views/Dashboard/Home/overview_views/initialize_view.dart";
import "package:frontend/widgets/snackbar_widget.dart";
import "package:provider/provider.dart";


class OverviewView extends StatefulWidget {

  const OverviewView({
    super.key
  });

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {

  bool _isScanFail = false;
  late String _email;
  late String _username;

  late SensorProvider _sensorProvider;
  late UserProvider _userProvider;
  late NotificationProvider _notificationProvider;

  @override
  void initState() {
    super.initState();
    _email = MakerSyncAuthentication().getUserEmail;
    _username = MakerSyncAuthentication().getUserDisplayName;

    _sensorProvider = Provider.of<SensorProvider>(context, listen: false);
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    
    fetchData();
  }

  void fetchData() async {
    _sensorProvider.fetchSensor();
    _sensorProvider.startFetchingSensorValues();
  }

  @override
  void dispose(){
    super.dispose();
    _sensorProvider.stopFetchingSensorValues();
  }

  @override
  Widget build(BuildContext context){
    
    _sensorProvider.fetchSensor();
    _sensorProvider.startFetchingSensorValues();
    print("REBUILD!");

    return Consumer<SettingsProvider>(
      builder: (context, _settingsProvider, _) {
        final bool _isConnect = _settingsProvider.getBool("isConnect");
        final bool _isInitialize = _settingsProvider.getBool("isInitialize");

        return Scaffold(
          body: Center(
            child: _isConnect
                ? _isInitialize
                    ? ConnectedView(
                        settingsProvider: _settingsProvider,
                      )
                    : InitializeView(
                        sensorProvider: _sensorProvider,
                        settingsProvider: _settingsProvider,
                      )
                : DisconnectedView(
                    isScanFail: _isScanFail,
                    btnOnTap: () => scanQRCode(context, _settingsProvider),
                  ),
          ),
        );
      },
    );

  }

  
  Future<void> scanQRCode(
    BuildContext context, 
    SettingsProvider _settingsProvider
  ) async {
    String scan;
    try{

      scan = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR
      );

      print(scan);
      print(SENSOR_URL);
      _settingsProvider.setString("code", scan);


      if(!mounted) return;
      
      if(await _sensorProvider.fetchSensor()){
        setState((){
          _settingsProvider.setBool("isConnect", true);
        });

        _sensorProvider.fetchSensor();
        _sensorProvider.startFetchingSensorValues();


        _userProvider.addUserCredential(
          email: _email, 
          username: _username
        );

        const MSSnackbarWidget(
          message: "Successfully connected to device!",
        ).showSnackbar(context);

      } else {
        setState(() => _isScanFail = true);
      }
    } on PlatformException catch(e) {
       debugPrint("Failed to scan barcode: $e");
    }    
  }
}