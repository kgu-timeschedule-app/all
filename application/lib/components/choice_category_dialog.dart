import 'package:flutter/material.dart';

import '../functions/get_info.dart';
import 'custom_dropdown_button.dart';

class ChoiceCategoryPage extends StatefulWidget {
  int school = 0;
  int season = 0;
  int date = 0;
  int dept = 0;
  int howto = 0;
  final List<String> campasAllData = getAllCampas();
  final List<String> seasonAllData = getAllTerm();
  final List<String> dateAllData = getAllDay();
  final List<String> deptAllData = getAllDept();
  final List<String> howtoAllData = getAllHowto();
  final Function(int) onChangedCampas;
  final Function(int) onChangedSeason;
  final Function(int) onChangedDate;
  final Function(int) onChangedDept;
  final Function(int) onChangedHowto;

  ChoiceCategoryPage(
      {Key? key,
      required this.school,
      required this.season,
      required this.date,
      required this.dept,
      required this.howto,
      required this.onChangedCampas,
      required this.onChangedSeason,
      required this.onChangedDate,
      required this.onChangedDept,
      required this.onChangedHowto})
      : super(key: key);

  @override
  State<ChoiceCategoryPage> createState() => _ChoiceCategoryPageState();
}

class _ChoiceCategoryPageState extends State<ChoiceCategoryPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('カテゴリ検索'),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Column(
          children: [
            const Text('キャンパス名'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: CustomDropDownButton(
                  contentList: widget.campasAllData,
                  value: widget.school,
                  onChanged: widget.onChangedCampas),
            ),
            const Text('学期'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: CustomDropDownButton(
                  contentList: widget.seasonAllData,
                  value: widget.season,
                  onChanged: widget.onChangedSeason),
            ),
            const Text('曜日 / 時限'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: CustomDropDownButton(
                  contentList: widget.dateAllData,
                  value: widget.date,
                  onChanged: widget.onChangedDate),
            ),
            const Text('学部 / 学科'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: CustomDropDownButton(
                  contentList: widget.deptAllData,
                  value: widget.dept,
                  onChanged: widget.onChangedDept),
            ),
            const Text('履修方法'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: CustomDropDownButton(
                  contentList: widget.howtoAllData,
                  value: widget.howto,
                  onChanged: widget.onChangedHowto),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('保存'),
        ),
      ],
    );
  }
}
