import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../functions/get_info.dart';
import 'test_information_detail_timeline.dart';

class NonNumberSubjectComponent extends StatelessWidget {
  final dynamic iconImg;
  final String? content;

  const NonNumberSubjectComponent(
      {Key? key, required this.iconImg, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: iconImg,
            ),
            Expanded(
                child: content != null
                    ? Text(content!.replaceAll("<BR/>", "\n"),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12))
                    : SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 0,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 2,
                            )))),
          ],
        ),
      ),
    );
  }
}

class InNumberSubjectComponent extends StatelessWidget {
  final Icon iconImg;
  final String? content;
  final int? number;

  const InNumberSubjectComponent(
      {Key? key,
      required this.iconImg,
      required this.number,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: iconImg,
            ),
            Row(
              children: [
                number != null
                    ? Text(number.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 6, 0, 0),
                  child: content != null
                      ? Text(content!.replaceAll("<BR/>", "\n"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12))
                      : SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                              lines: 1,
                              spacing: 0,
                              lineStyle: SkeletonLineStyle(
                                randomLength: true,
                                height: 10,
                                borderRadius: BorderRadius.circular(8),
                                minLength:
                                    MediaQuery.of(context).size.width / 2,
                              ))),
                ),
              ],
            ),
          ],
        ));
  }
}

class EvaluatePageComponent extends StatelessWidget {
  final Map<String, dynamic>? subjectData;
  final Icon iconImg;

  const EvaluatePageComponent(
      {Key? key, required this.iconImg, required this.subjectData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subjectData == null) {
      return SkeletonParagraph(
          style: SkeletonParagraphStyle(
              lines: 1,
              spacing: 0,
              lineStyle: SkeletonLineStyle(
                randomLength: true,
                height: 10,
                borderRadius: BorderRadius.circular(8),
                minLength: MediaQuery.of(context).size.width / 2,
              )));
    }
    final evaluateList = getEvaluateString(list: subjectData!);
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: iconImg,
            ),
            Expanded(
                child: TestinformationDetailTimeline(data: {
              "content": {"test": evaluateList}
            }, context: context, showname: false, issyllabus: true)),
          ],
        ),
      ),
    );
  }
}
