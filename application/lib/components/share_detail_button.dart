import 'package:flutter/material.dart';

class ShareDetailButton extends StatefulWidget {
  const ShareDetailButton(
      {Key? key,
      required this.onClick,
      required this.icon,
      required this.title})
      : super(key: key);

  final void Function()? onClick;
  final Icon icon;
  final String title;

  @override
  State<ShareDetailButton> createState() => _ShareDetailButtonState();
}

class _ShareDetailButtonState extends State<ShareDetailButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width - 100, // ボタンを横に伸ばす
      height: 100, // ボタンの高さ
      buttonColor: Colors.black, // ボタンの色
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          maximumSize: Size(MediaQuery.of(context).size.width - 50, 200),
          backgroundColor: Colors.white,
          elevation: 0,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: widget.onClick,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.icon,
                  const SizedBox(width: 8), // アイコンとテキストの間隔
                  Text(widget.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.arrow_forward, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
