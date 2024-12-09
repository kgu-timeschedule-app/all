// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:time_schedule/models/friends.dart';
//
// import '../components/check_camera.dart';
// import '../functions/generate_qr.dart';
// import '../functions/make_link.dart';
//
// class ReadCameraFriendPage extends StatefulWidget {
//   const ReadCameraFriendPage({Key? key, required this.userId})
//       : super(key: key);
//
//   final String userId;
//
//   @override
//   State<ReadCameraFriendPage> createState() => _ReadCameraFriendPageState();
// }
//
// class _ReadCameraFriendPageState extends State<ReadCameraFriendPage> {
//   bool showQRCamera = true;
//   String url = "";
//   GlobalKey _globalKey = GlobalKey();
//   String _qrCodeResult = "QRコードの結果をここに表示します";
//
//   void _shareText(String text, String subject) async {
//     await Share.share(text, subject: subject);
//   }
//
//   @override
//   void initState() {
//     createDynamicLink(widget.userId).then((uri) {
//       // _shareText(url, "友達と共有する");
//       setState(() {
//         url = uri;
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
//
//   Future<void> _captureAndSharePng() async {
//     try {
//       RenderRepaintBoundary? boundary = _globalKey.currentContext
//           ?.findRenderObject() as RenderRepaintBoundary?;
//       if (boundary == null) {
//         return;
//       }
//       var image = await boundary.toImage();
//       ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
//       Uint8List? pngBytes = byteData?.buffer.asUint8List();
//
//       final tempDir = await getTemporaryDirectory();
//       final file = await new File('${tempDir.path}/image.png').create();
//       await file.writeAsBytes(pngBytes!);
//
//       await Share.shareXFiles([XFile('${tempDir.path}/image.png')]);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return showQRCamera
//         ? Padding(
//             padding: EdgeInsets.fromLTRB(24, 48, 24, 24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Text("QRコードをスキャンしてください。"),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
//                   child: checkQRCamera(onReadLater: (e) {
//                     // 送信処理をここに書きます
//                     print(e);
//                     FriendService()
//                         .addFriend(widget.userId, e)
//                         .then((value) => Navigator.of(context).pop());
//                   }),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       showQRCamera = false;
//                     });
//                   },
//                   child: Text('QRコードをアップロードする'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       showQRCamera = false;
//                     });
//                   },
//                   child: Text('自分のQRコードを表示する'),
//                 ),
//               ],
//             ),
//           )
//         : Padding(
//             padding: EdgeInsets.fromLTRB(24, 48, 24, 24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Text("友達にこのQRコードを読み取ってもらってください。"),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
//                   child: Container(
//                       height: 200,
//                       width: 200,
//                       child: RepaintBoundary(
//                           key: _globalKey, child: generateQR(url))),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(100, 0, 100, 40),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.photo),
//                             onPressed: _captureAndSharePng,
//                           ),
//                           Text('保存'),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.share),
//                             onPressed: () => _shareText(url, "友達と共有する"),
//                           ),
//                           Text('共有'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       showQRCamera = true;
//                     });
//                   },
//                   child: Text('QRコードをスキャンする'),
//                 ),
//               ],
//             ),
//           );
//   }
// }
// improve next version
