import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../functions/read_local_strage_setting.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key});

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

// const Color(0xffdcffd9)
//  Colors.green

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color currentBackgroundColor = const Color(0xffdcffd9);
  Color currentBorderColor = Colors.green;
  Color currentThemeColor = const Color(0xffFC7D3C);

  @override
  void initState() {
    readLocalstrageSettingString("currentBackgroundCellColor").then((value) {
      if (RegExp(r'^\d+$').hasMatch(value)) {
        // nullチェックと数字のチェック
        try {
          setState(() {
            currentBackgroundColor = Color(int.parse(value));
          });
        } catch (e) {
          print("Error parsing value: $e");
          setState(() {
            currentBackgroundColor = const Color(0xffdcffd9);
          });
        }
      } else {
        setState(() {
          currentBackgroundColor = const Color(0xffdcffd9);
        });
      }
    });
    readLocalstrageSettingString("currentBorderCellColor").then((value) {
      if (RegExp(r'^\d+$').hasMatch(value)) {
        // nullチェックと数字のチェック
        try {
          setState(() {
            currentBorderColor = Color(int.parse(value));
          });
        } catch (e) {
          print("Error parsing value: $e");
          setState(() {
            currentBorderColor = Colors.green;
          });
        }
      } else {
        setState(() {
          currentBorderColor = Colors.green;
        });
      }
    });
    readLocalstrageSettingString("currentThemeColor").then((value) {
      if (RegExp(r'^\d+$').hasMatch(value)) {
        // nullチェックと数字のチェック
        try {
          setState(() {
            currentThemeColor = Color(int.parse(value));
          });
        } catch (e) {
          print("Error parsing value: $e");
          setState(() {
            currentThemeColor = const Color(0xffFC7D3C);
          });
        }
      } else {
        setState(() {
          currentThemeColor = const Color(0xffFC7D3C);
        });
      }
    });
    super.initState();
  }

  void _openBackgroundColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentBackgroundColor,
              onColorChanged: (color) {
                setState(() {
                  currentBackgroundColor = color;
                });
                setLocalstrageSettingString(
                    color.value.toString(), "currentBackgroundCellColor");
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openBorderColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentBorderColor,
              onColorChanged: (color) {
                setState(() {
                  currentBorderColor = color;
                });
                setLocalstrageSettingString(
                    color.value.toString(), "currentBorderCellColor");
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openThemeColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentThemeColor,
              onColorChanged: (color) {
                setState(() {
                  currentThemeColor = color;
                });
                setLocalstrageSettingString(
                    color.value.toString(), "currentThemeColor");
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('色変更'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Text("テーマカラーの変更はアプリ再起動後に反映されます"),
              ),
              OutlinedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                        height: 50,
                        child: Text("サンプル教科", style: TextStyle(fontSize: 10))),
                    SizedBox(
                        height: 10,
                        child: Text("サンプル先生",
                            style: TextStyle(fontSize: 8),
                            overflow: TextOverflow.ellipsis)),
                    SizedBox(
                        height: 13,
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text("VI-101",
                                style: TextStyle(fontSize: 10)))),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor: currentBackgroundColor,
                  side: BorderSide(width: 2, color: currentBorderColor),
                ),
                onPressed: () => {null},
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 24),
                  OutlinedButton(
                    onPressed: _openBackgroundColorPicker,
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: currentBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(),
                    ),
                    child: const Text('背景色変更'),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton(
                      onPressed: _openBorderColorPicker,
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(width: 2, color: currentBorderColor),
                      ),
                      child: const Text('枠線の変更')),
                  const SizedBox(height: 36),
                  OutlinedButton(
                    onPressed: _openThemeColorPicker,
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: currentThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(),
                    ),
                    child: const Text('このアプリのテーマカラーの変更'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
