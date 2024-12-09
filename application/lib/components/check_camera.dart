// import 'dart:typed_data';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// class checkQRCamera extends StatefulWidget {
//   const checkQRCamera({Key? key, required this.onReadLater}) : super(key: key);
//   final Function onReadLater;
//
//   @override
//   State<checkQRCamera> createState() => _checkQRCameraState();
// }
//
// class _checkQRCameraState extends State<checkQRCamera> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 320,
//       child: MobileScanner(
//         fit: BoxFit.contain,
//         controller: MobileScannerController(
//           facing: CameraFacing.back,
//           torchEnabled: true,
//         ),
//         onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           final Uint8List? image = capture.image;
//           for (final barcode in barcodes) {
//             widget.onReadLater(barcode.rawValue);
//           }
//         },
//       ),
//     );
//   }
// }

// improve next version
