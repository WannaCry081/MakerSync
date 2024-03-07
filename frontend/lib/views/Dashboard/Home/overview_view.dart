import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:percent_indicator/circular_percent_indicator.dart";


class OverviewView extends StatefulWidget {
  const OverviewView({ super.key });

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  bool _isConnected = false;
  bool _isScanFail = false;
  double _progressValue = 0.4;
  String _code = "D8yxV57U";
  String _scanCodeResult = "";

  
  @override
  Widget build(BuildContext context){
    return Scaffold( 
      body : Center(
        child: _isConnected ? connectedView() : disconnectedView(),
      )
    );
  }

  Widget connectedView() {
    return  Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 120.r,
            lineWidth: 35,
            percent: _progressValue,
            progressColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            circularStrokeCap: CircularStrokeCap.round,
            center: MSTextWidget(
                "${(_progressValue * 100).toInt()}%",
                fontColor : Theme.of(context).colorScheme.onBackground,
                fontSize : 45.sp,
                fontWeight: FontWeight.w500,
              ),
          ),
      
          SizedBox(height: 20.h),
      
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svgs/Thermometer.svg"
                  ),
                  SizedBox(width: 10.w),
                  MSTextWidget(
                    "230°C",
                    fontColor: Theme.of(context).colorScheme.onBackground,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                  )
                ]
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget disconnectedView() {
    return Column(
      children: [
        SizedBox(height: 30.h),
        
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25.w),
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/svgs/Blob2.svg", 
                // ignore: deprecated_member_use
                color: Theme.of(context).brightness == Brightness.dark 
                  ? Theme.of(context).colorScheme.primary
                  : null,
              ),
              Positioned.fill(
                child: Center(
                  child: SvgPicture.asset(
                    _isScanFail ? "assets/svgs/ErrorScan.svg" : "assets/svgs/Search.svg", 
                    height: 400.h
                  ),
                ),
              ),
            ]
          ),
        ),
        
        SizedBox(height: 5.h),

        Column(
          children: [
            MSTextWidget(
              _isScanFail 
                ? "Oops! Your scanned code seems to be incorrect :>" 
                : "Oops! You are not yet connected :<",
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontColor: Theme.of(context).colorScheme.onBackground,
            ),

            SizedBox(height: 2.h),

            MSTextWidget(
              _isScanFail 
                ? "Please scan the QR code again to proceed."
                : "Please scan the QR code found in the machine to proceed.",
              fontWeight: FontWeight.w500,
              fontColor: Colors.grey.shade600,
              fontHeight: 2.h,
            ),
          ]
        ),

        const Spacer(),

        MSButtonWidget(
          btnOnTap: scanQRCode,
          btnColor: Theme.of(context).colorScheme.primary,
          child: Center(
            child: MSTextWidget(
              "Connect to Device",
              fontColor: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            )
          )
        )
      ],
    );
  }

  Future<void> scanQRCode() async {
    String scan;
    try{
      scan = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR
      );
      debugPrint(scan);
    } on PlatformException {
      scan = "Failed to get platform version";
    }

    if(!mounted) return;
    setState(() => _scanCodeResult = scan);

    if(_code == _scanCodeResult){
      setState((){
         _isConnected = true;
         _isScanFail = false;
      });
    } else {
      setState(() => _isScanFail = true);
    }
  }
}