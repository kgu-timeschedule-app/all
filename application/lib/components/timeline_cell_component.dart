import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/TimeScheduleModel.dart';
import 'choicing_timeline_cell.dart';

String removeSubjectNumber(String subject) {
  return subject.replaceFirst(RegExp(r'【[0-9]{1,3}】'), '');
}

String removeTeacher(String subject) {
  return subject.replaceFirst(RegExp(r'（.+?）'), '').replaceAll("　", "");
}

class TimelineCellComponent extends StatelessWidget {
  final int index;
  final List<TimeScheduleModel> timeSchedule;
  final Map<String, dynamic>? syllabusData;
  final Function? setStates;
  final bool? concentrate;
  final int termIndex;
  final int yearValue;
  final int owndept;
  final int showSuterday;

  final Color currentBackgroundColor;
  final Color currentBorderColor;

  const TimelineCellComponent(
      {Key? key,
      required this.index,
      required this.timeSchedule,
      required this.syllabusData,
      required this.setStates,
      this.concentrate,
      required this.termIndex,
      required this.owndept,
      required this.showSuterday,
      required this.yearValue,
      required this.currentBackgroundColor,
      required this.currentBorderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
        crossAxisCellCount: 4,
        mainAxisCellCount: showSuterday == 0 ? 5 : 6,
        child: OutlinedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 50,
                  child: Text(
                      concentrate != null
                          ? removeSubjectNumber(
                                  timeSchedule[49].concentrate![index].subject)
                              .replaceAll("　", "")
                          : removeSubjectNumber(
                                  timeSchedule[index - 7].content!.subject)
                              .replaceAll("　", ""),
                      style: const TextStyle(fontSize: 10))),
              SizedBox(
                  height: 10,
                  child: Text(
                      concentrate != null
                          ? removeTeacher(
                              timeSchedule[49].concentrate![index].teacher)
                          : removeTeacher(
                              timeSchedule[index - 7].content!.teacher),
                      style: const TextStyle(fontSize: 8),
                      overflow: TextOverflow.ellipsis)),
              SizedBox(
                  height: 13,
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                          concentrate != null
                              ? timeSchedule[49].concentrate![index].room == ""
                                  ? "未定"
                                  : timeSchedule[49].concentrate![index].room
                              : timeSchedule[index - 7].content!.room == ""
                                  ? "未定"
                                  : timeSchedule[index - 7].content!.room,
                          style: const TextStyle(fontSize: 10)))),
            ],
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: Size.zero,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            backgroundColor: currentBackgroundColor,
            side: BorderSide(width: 2, color: currentBorderColor),
          ),
          onPressed: () {
            if (syllabusData == null || setStates == null) {
              return;
            }
            showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return ChoicingTimeLineCellPage(
                    concentrate: concentrate,
                    index: index,
                    timeSchedule: timeSchedule,
                    syllabusData: syllabusData!,
                    setStates: setStates!,
                    termIndex: termIndex,
                    owndept: owndept,
                    yearValue: yearValue,
                  );
                });
          },
        ));
  }
}
