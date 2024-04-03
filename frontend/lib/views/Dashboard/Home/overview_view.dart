import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import "package:frontend/providers/settings_provider.dart";
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
  String _code = "D8yxV57U";
  String _scanCodeResult = "";

  @override
  Widget build(BuildContext context){
    final SettingsProvider settings  = Provider.of<SettingsProvider>(context);
    final bool _isConnected = settings.getBool("isConnected");

    return Scaffold( 
      body : Center(
        child: _isConnected 
          ? InitializeView()
          : DisconnectedView(
              isScanFail: _isScanFail, 
              btnOnTap: () => scanQRCode(context, settings))
      )
    );
  }
  
  Future<void> scanQRCode(BuildContext context, SettingsProvider settings) async {
    String scan;
    try{
      scan = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR
      );

      debugPrint(scan);
      setState(() => _scanCodeResult = scan);

      if(!mounted) return;

      if(_code == _scanCodeResult){
        setState((){
          settings.setBool("isConnected", true);
        });

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