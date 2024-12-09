import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/TimeScheduleModel.dart';
import 'choicing_timeline_cell.dart';

class TimelineNoneCellComponent extends StatelessWidget {
  final int index;
  final List<TimeScheduleModel> timeSchedule;
  final Map<String, dynamic>? syllabusData;
  final Function? setStates;
  final bool? concentrate;
  final int termIndex;
  final int yearValue;
  final int owndept;
  final int showSuterday;

  const TimelineNoneCellComponent(
      {Key? key,
      required this.index,
      required this.timeSchedule,
      required this.syllabusData,
      required this.setStates,
      this.concentrate,
      required this.termIndex,
      required this.yearValue,
      required this.showSuterday,
      required this.owndept})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
        crossAxisCellCount: 4,
        mainAxisCellCount: showSuterday == 0 ? 5 : 6,
        child: OutlinedButton(
          child: const Text(''),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: Size.zero,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(width: 2, color: Colors.black),
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
                      owndept: owndept,
                      concentrate: concentrate,
                      index: index,
                      timeSchedule: timeSchedule,
                      syllabusData: syllabusData!,
                      setStates: setStates!,
                      termIndex: termIndex,
                      yearValue: yearValue);
                });
          },
        ));
  }
}
