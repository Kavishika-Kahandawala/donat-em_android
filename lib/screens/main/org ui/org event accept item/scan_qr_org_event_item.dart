
import 'dart:developer';
import 'dart:io';

import 'package:donatem/screens/main/org%20ui/org%20event%20accept%20item/scan_qr_org_event_receive_match_item.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class OrgEventAcceptItemQrRead extends StatefulWidget {
  const OrgEventAcceptItemQrRead({super.key});

  @override
  State<OrgEventAcceptItemQrRead> createState() =>
      _OrgEventAcceptItemQrReadState();
}

class _OrgEventAcceptItemQrReadState extends State<OrgEventAcceptItemQrRead> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Scan QR Code to accept Item',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    'Scanning QR code will simplify the acceptance way.',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: InputButton1(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const QRScannerView(),
                          ));
                        },
                        text: 'Scan QR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QRScannerView extends StatefulWidget {
  const QRScannerView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isCameraPaused = false; // Track camera paused state
  bool isFlashOn = false; // Track flash state

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildFlashIcon(), // Flash icon

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isCameraPaused) {
                                controller?.resumeCamera();
                              } else {
                                controller?.pauseCamera();
                              }
                              isCameraPaused = !isCameraPaused;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              isCameraPaused ? 'Resume' : 'Pause',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ), // Camera facing icon
                        _buildCameraFacingIcon(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build Flash icon with GestureDetector
  Widget _buildFlashIcon() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isFlashOn = !isFlashOn;
          controller?.toggleFlash();
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          isFlashOn ? Icons.flash_on : Icons.flash_off,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  // Build Camera facing icon with GestureDetector
  Widget _buildCameraFacingIcon() {
    return GestureDetector(
      onTap: () async {
        await controller?.flipCamera();
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FutureBuilder<CameraFacing>(
          future: controller?.getCameraInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Icon(
                snapshot.data == CameraFacing.front
                    ? LineIcons.syncIcon
                    : LineIcons.syncIcon,
                // ? Icons.camera_front
                // : Icons.camera_rear,
                size: 30,
                color: Colors.white,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.deepPurple,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      // Check if a QR code was successfully scanned
      if (scanData.code != null && scanData.code!.isNotEmpty) {
        // Navigate to a new page with the scanned data

        {
          Get.to(() => const ScanQROrgEventViewReceiveMatchedItem(), arguments: [
            scanData.code.toString(),
          ]);
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
