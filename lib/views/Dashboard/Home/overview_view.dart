import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import "package:frontend/models/sensor_model.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:frontend/providers/user_provider.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/services/sensor_service.dart";
import "package:frontend/views/Dashboard/Home/overview_views/connected_view.dart";
import "package:frontend/views/Dashboard/Home/overview_views/disconnected_view.dart";
import "package:frontend/views/Dashboard/Home/overview_views/initialize_view.dart";
import "package:frontend/widgets/snackbar_widget.dart";
import "package:provider/provider.dart";


class OverviewView extends StatefulWidget {
  const OverviewView({ super.key });

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {

  bool _isScanFail = false;
  double _progressValue = 0.4;

  late final SensorService _sensorService;
  late Future<SensorModel> sensor;

  late String _email;
  late String _name;

  @override
  void initState() {
    super.initState();
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    _sensorService = SensorService();
    _sensorService.setSensorValues(settings: settings);
    sensor = _sensorService.fetchSensor();
    _email = MakerSyncAuthentication().getUserEmail;
    _name = MakerSyncAuthentication().getUserDisplayName;
  }

  @override
  Widget build(BuildContext context){
    sensor = _sensorService.fetchSensor();

    final SettingsProvider settings  = Provider.of<SettingsProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    final bool _isConnect = settings.getBool("isConnect");
    final bool _isInitialize = settings.getBool("isInitialize");

    print("----------------");
    print("Is connected : $_isConnect");
    print("Is intialized : $_isInitialize");
    print("----------------");

    return Scaffold( 
      body : Center(
        child: _isConnect 
        ? _isInitialize
          ? const ConnectedView(
            progressValue: 0,
          )
          : const InitializeView()
        : DisconnectedView(
              isScanFail: _isScanFail, 
              btnOnTap: () => scanQRCode(
                context, settings, userProvider
              )) 
      )
    );
  }
  
  Future<void> scanQRCode(
    BuildContext context, 
    SettingsProvider settings,
    UserProvider userProvider
  ) async {
    String scan;
    try{

      scan = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR
      );

      settings.setString("code", scan);

      if(!mounted) return;
      
      if(await _sensorService.isSensorExist(settings: settings)){
        setState((){
          settings.setBool("isConnect", true);
        });

        _sensorService.startFetchingSensor(settings: settings);

        userProvider.addUserCredential(
          email: _email, 
          name: _name
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