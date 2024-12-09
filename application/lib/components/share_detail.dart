import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../pages/AddIDFriendPage.dart';
import 'share_detail_button.dart';

class ShareDetailPage extends StatefulWidget {
  const ShareDetailPage({Key? key, required this.userId}) : super(key: key);

  final String? userId;

  @override
  State<ShareDetailPage> createState() => _ShareDetailPageState();
}

class _ShareDetailPageState extends State<ShareDetailPage> {
  void _shareText(String text, String subject) async {
    await Share.share(text, subject: subject);
  }

  bool isinputId = false;
  bool useCamera = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isinputId ? 600 : 330,
      child: isinputId == false
          ? Column(
              children: [
                // Padding(
                //     padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                //     child: ShareDetailButton(
                //         icon: Icon(Icons.qr_code, color: Colors.black),
                //         title: "URL / QRコードで登録",
                //         onClick: () => setState(() {
                //               isinputId = true;
                //               useCamera = true;
                //             }))),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                //   child: ShareDetailButton(
                //       icon: const Icon(Icons.link, color: Colors.black),
                //       title: "リンクを共有(",
                //       onClick: () {
                //         if (widget.userId != null) {
                //           createDynamicLink(widget.userId!).then((uri) {
                //             _shareText(uri, "友達と共有する");
                //           }).catchError((e) {
                //             // print(e);
                //           });
                //         }
                //       }),
                // ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: ShareDetailButton(
                        icon: const Icon(Icons.perm_identity,
                            color: Colors.black),
                        title: "IDを入力 / 確認する",
                        onClick: () => setState(() {
                              isinputId = true;
                            }))),
              ],
            )
          : useCamera
              ? const SizedBox
                  .shrink() // ReadCameraFriendPage(userId: widget.userId!)
              : Column(
                  children: [
                    AddIdFriend(userId: widget.userId!),
                    Text("あなたのIDは\n" + widget.userId! + "です"),
                    ClipboardCopyButton(textToCopy: widget.userId!),
                  ],
                ),
    );
  }
}

class ClipboardCopyButton extends StatefulWidget {
  const ClipboardCopyButton({Key? key, required this.textToCopy})
      : super(key: key);
  final String textToCopy;

  @override
  State<ClipboardCopyButton> createState() => _ClipboardCopyButtonState();
}

class _ClipboardCopyButtonState extends State<ClipboardCopyButton> {
  bool iscopyed = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: widget.textToCopy));
        setState(() {
          iscopyed = true;
        });
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            iscopyed = false;
          });
        });
      },
      icon: iscopyed ? const Icon(Icons.check) : const Icon(Icons.copy),
    );
  }
}
