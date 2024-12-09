import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skeletons/skeletons.dart';

import '../components/show_subject_component.dart';
import '../functions/get_info.dart';
import '../functions/get_subject_data.dart';

String alphanumericToHalfLength(String runes) {
  final regex = RegExp(r'^[Ａ-Ｚａ-ｚ０-９]+$');
  final string = runes.runes.toList().map<String>((rune) {
    final char = String.fromCharCode(rune);
    return regex.hasMatch(char) ? String.fromCharCode(rune - 65248) : char;
  });
  return string.join();
}

class searchWebViewOlder extends StatefulWidget {
  final Map<String, dynamic> syllabusData;
  final String id;

  const searchWebViewOlder(
      {Key? key, required this.id, required this.syllabusData})
      : super(key: key);

  @override
  State<searchWebViewOlder> createState() => _searchWebViewOlderState();
}

class _searchWebViewOlderState extends State<searchWebViewOlder> {
  Map<String, dynamic> subjectData = {};

  @override
  void initState() {
    getSubjectData(id: widget.id).then((value) {
      setState(() {
        subjectData = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            subjectData == {}
                ? const SpinKitWave(
                    color: Colors.green,
                    size: 50.0,
                  )
                : Text(widget.id,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.grey[600])),
            subjectData["name"] != null
                ? Text(subjectData["name"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24))
                : SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 0,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        ))),
            NonNumberSubjectComponent(
                iconImg: const Icon(LineIcons.chalkboardTeacher, size: 24),
                content: subjectData["担当者"]),
            InNumberSubjectComponent(
                iconImg: const Icon(LineIcons.graduationCap, size: 24),
                number: subjectData["単位数"],
                content: "単位"),
            NonNumberSubjectComponent(
                iconImg: const Icon(LineIcons.tree, size: 24),
                content: subjectData["履修期"]),
            NonNumberSubjectComponent(
                iconImg: const Icon(LineIcons.school, size: 24),
                content: subjectData["campas"] != null
                    ? getCampas(keyword: subjectData["campas"] + 1)
                    : null),
            InNumberSubjectComponent(
                iconImg: const Icon(LineIcons.userClock, size: 24),
                number: subjectData["履修基準年度"] != null
                    ? int.parse(alphanumericToHalfLength(
                        subjectData["履修基準年度"].replaceAll("年", "")))
                    : null,
                content: "年"),
            // nonNumberSubjectComponent(
            //     iconImg: Icon(LineIcons.language, size: 24),
            //     content: subjectData["主な教授言語"] + " (主な教授言語)"),
            NonNumberSubjectComponent(
                iconImg: const Icon(LineIcons.globe, size: 24),
                content: subjectData["緊急授業形態"] != null
                    ? getStudyWay(keyword: subjectData["緊急授業形態"]) + " (授業形態)"
                    : null),
            // nonNumberSubjectComponent(
            //     iconImg: Icon(LineIcons.youtube, size: 24),
            //     content: getStudyWay(keyword: subjectData["オンライン授業形態"]) +
            //         " (オンライン許可者のみ)"),
            NonNumberSubjectComponent(
                iconImg: const Icon(LineIcons.campground, size: 24),
                content: subjectData["管理部署"] != null
                    ? getDepartment(keyword: subjectData["管理部署"] + 1) + " 開講科目"
                    : null),
            NonNumberSubjectComponent(
                iconImg: const Icon(LineIcons.campground, size: 24),
                content: subjectData["授業方法"]),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 100),
              child: EvaluatePageComponent(
                  iconImg: const Icon(LineIcons.globe, size: 24),
                  subjectData: subjectData["評価"]),
            ),
            // Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: List.generate(widget.timeSchedule.length, (index) {
            //       return TextbookinformationDetailTimeline(
            //           data: widget.timeSchedule[index].toMap(),
            //           context: context,
            //           contentSubject: "referencebook");
            //     }))
          ],
        ),
      ),
    );
  }
}
