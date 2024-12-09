import 'package:flutter/material.dart';
import 'package:time_schedule/pages/setting.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  Widget build(BuildContext context) {
    return const SettingPage(istutrial: true);
  }
}
