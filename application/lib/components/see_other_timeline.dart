import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions/fetch_firestore.dart';
import '../functions/timeschedule_to_json.dart';
import '../models/TimeScheduleModel.dart';
import 'dropdown_year_and_term.dart';
import 'timeline_grid.dart';

class SeeOtherTimeLine extends StatefulWidget {
  const SeeOtherTimeLine({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<SeeOtherTimeLine> createState() => _SeeOtherTimeLineState();
}

class _SeeOtherTimeLineState extends State<SeeOtherTimeLine> {
  bool isinputId = false;
  int ownDept = 0;
  int showSaturday = 0;
  int termIndex = 0;
  int yearValue = 0;

  // Todo: 格納されているデータによって数値変える。とくに年度
  List<String> termList = ["spring", "fall"];
  List<int> yearList = [];
  Map<String, dynamic> friendData = {};
  List<TimeScheduleModel>? timeSchedule;

  @override
  void initState() {
    super.initState();
    Future(() async {
      return await readFriendFirestore(widget.userId);
    }).then((value) {
      final timeList = value!.keys;
      setState(() {
        // Todo: 次タスクここ
        friendData = value;
        yearList =
            timeList.map((e) => int.parse(e.substring(e.length - 4))).toList();
        timeSchedule = changeTimeSchedule(0, yearList[0]); // 最初は強制で春学期の情報になる
      });
    }).catchError((e) {
      // print(e);
    });
  }

  List<TimeScheduleModel>? changeTimeSchedule(int term, int year) {
    if (friendData["timeSchedule_test2" + term.toString() + year.toString()] ==
        null) {
      if (term == 0) {
        term = 1;
        setState(() {
          termList = ["fall"];
        });
      }
    }
    return timescheduleJsonToString(friendData[
            "timeSchedule_test2" + term.toString() + year.toString()]!)
        .map((e) => TimeScheduleModel.fromMap(jsonDecode(e)))
        .toList();
  }

  void changeSchedule(valueTerm, valueYear) {
    if (valueTerm != null) {
      setState(() {
        termIndex = valueTerm;
        timeSchedule = changeTimeSchedule(termIndex, 2023);
      });
    } else {
      setState(() {
        yearValue = yearList.indexOf(valueYear);
        timeSchedule = changeTimeSchedule(termIndex, yearValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        child: timeSchedule == null
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                child: Column(
                children: [
                  DropdownYearandTerm(
                    termList: termList,
                    yearList: yearList,
                    termIndex: termIndex,
                    yearValue: yearList[yearValue],
                    onChange: changeSchedule,
                  ),
                  TimelineGrid(
                    owndept: 0,
                    timeSchedule: timeSchedule!,
                    syllabusFilterData: null,
                    termIndex: termIndex,
                    yearValue: yearList[yearValue],
                    setStates: null,
                    showSuterday: showSaturday,
                    showtime: false,
                  ),
                ],
              )));
  }
}
