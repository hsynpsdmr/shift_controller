import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shift_controller/theme/context_extansion.dart';

import 'list_page.dart';

class QRCodeScan extends StatefulWidget {
  const QRCodeScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCodeScanState();
}

class _QRCodeScanState extends State<QRCodeScan> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: context.pmsSize.width / 2),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    if (Platform.isAndroid) {
      await controller.resumeCamera();
    }
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      Navigator.pop(context, scanData);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ListPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.white.withOpacity(0),
      child: SizedBox(
        width: context.pmsSize.width / 2,
        height: context.pmsSize.height / 2,
        child: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
          ],
        ),
      ),
    );
  }
}
