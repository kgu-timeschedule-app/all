import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/timeline_cell_component.dart';
import '../models/TimeScheduleModel.dart';
import 'choicing_timeline_cell.dart';

List<Widget> timelineConcentrateComponent(
    List<TimeScheduleModel> timeSchedule,
    Map<String, dynamic>? syllabusData,
    Function? setStates,
    int termIndex,
    int yearValue,
    int owndept,
    Color currentBackgroundColor,
    Color currentBorderColor,
    BuildContext context) {
  List<Widget> result = [];
  for (var index = 0;
      index <
          (timeSchedule.isEmpty || timeSchedule[49].concentrate!.isEmpty
              ? syllabusData != null && setStates != null
                  ? 1
                  : 0
              : syllabusData != null && setStates != null
                  ? timeSchedule[49].concentrate!.length + 1
                  : timeSchedule[49].concentrate!.length);
      index++) {
    index ==
                (timeSchedule.isEmpty || timeSchedule[49].concentrate!.isEmpty
                    ? 0
                    : timeSchedule[49].concentrate!.length) &&
            syllabusData != null &&
            setStates != null
        ? result.add(StaggeredGridTile.count(
            crossAxisCellCount: 4,
            mainAxisCellCount: 6,
            child: OutlinedButton(
              child: const Text('授業を追加', style: TextStyle(fontSize: 10)),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                minimumSize: Size.zero,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(width: 2, color: Colors.grey[200]!),
              ),
              onPressed: () {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return ChoicingTimeLineCellPage(
                        index: index,
                        timeSchedule: timeSchedule,
                        syllabusData: syllabusData,
                        setStates: setStates,
                        termIndex: termIndex,
                        concentrate: true,
                        yearValue: yearValue,
                        owndept: owndept,
                      );
                    });
              },
            )))
        : result.add(TimelineCellComponent(
            owndept: owndept,
            timeSchedule: timeSchedule,
            syllabusData: syllabusData,
            index: index,
            concentrate: true,
            showSuterday: 1,
            setStates: setStates,
            termIndex: termIndex,
            yearValue: yearValue,
            currentBackgroundColor: currentBackgroundColor,
            currentBorderColor: currentBorderColor,
          ));
  }
  return result;
}
