import 'dart:async'; //非同期処理用
import 'dart:convert'; //httpレスポンスをJSON形式に変換用

import 'package:time_schedule/functions/read_local_strage_time_schedule.dart';

import '../models/TimeScheduleContentModel.dart';
import '../models/TimeScheduleModel.dart';
import 'change_schedule_data.dart';
import 'fetch_firestore.dart';
import 'get_info.dart';

Future changeTimeCell(
    Map<String, dynamic> syllabusData,
    Map<dynamic, dynamic>? replaceSubject,
    Map<dynamic, dynamic>? afterreplaceSubject,
    List<TimeScheduleModel> timeSchedule,
    Function setState,
    int termIndex,
    int yearValue,
    int? indexConcentrate,
    bool? concentrate) async {
  void setStateChange(e) {
    setState(() {
      e;
    });
  }

  if (replaceSubject != null) {
    List time = getDateList(list: replaceSubject["row"]);
    // 去年から授業曜日が変わった場合の対応
    if (concentrate == false && !time.contains(indexConcentrate)) {
      time = [];
    }
    ;

    if (replaceSubject["row"]["開講期"] == 0) {}
    if (concentrate == true && time.isEmpty ||
        time.isNotEmpty && time[0] == 50) {
      setState(timeSchedule[49].concentrate?.removeAt(indexConcentrate!));
    } else {
      if (time.isEmpty) {
        await setState(timeSchedule[indexConcentrate! - 7].content =
            TimeScheduleContentModel(
                id: "",
                subject: "",
                credit: 0,
                teacher: "",
                dept: "",
                room: "",
                test: [[]],
                textbook: [],
                referencebook: []));
      }
      for (int i = 0; i < time.length; i++) {
        await setState(
            timeSchedule[((time[i] % 7) - 1) * 7 + ((time[i] / 7).ceil())]
                    .content =
                TimeScheduleContentModel(
                    id: "",
                    subject: "",
                    credit: 0,
                    teacher: "",
                    dept: "",
                    room: "",
                    test: [[]],
                    textbook: [],
                    referencebook: []));
      }
    }
  }

  if (afterreplaceSubject != null) {
    final List time = getDateList(list: afterreplaceSubject["row"]);
    // 通年かどうか
    if (afterreplaceSubject["row"]["開講期"] == 0) {
      int tmp = afterreplaceSubject["credit"];
      afterreplaceSubject['credit'] = tmp ~/ 2;
      if (termIndex == 0) {
        List<TimeScheduleModel> timeSchedule2nd;
        timeSchedule2nd = await readLocalstrageTimeSchedule(1, yearValue);
        if (time[0] == 50) {
          // 秋の分
          await changeConcentrateSchedule(
            timeSchedule2nd,
            afterreplaceSubject,
            setStateChange,
            "timeSchedule_test21" + yearValue.toString(),
          );
        } else {
          for (int i = 0; i < time.length; i++) {
            await changeSchedule(
                ((time[i] % 7) - 1) * 7 + ((time[i] / 7).ceil()),
                timeSchedule2nd,
                afterreplaceSubject,
                setStateChange,
                "timeSchedule_test21" + yearValue.toString(),
                i == time.length - 1 ? true : false);
          }
        }
      }
    }
    if (time[0] == 50) {
      await changeConcentrateSchedule(
        timeSchedule,
        afterreplaceSubject,
        setStateChange,
        "timeSchedule_test2" + termIndex.toString() + yearValue.toString(),
      );
    } else {
      for (int i = 0; i < time.length; i++) {
        await changeSchedule(
            ((time[i] % 7) - 1) * 7 + ((time[i] / 7).ceil()),
            timeSchedule,
            afterreplaceSubject,
            setStateChange,
            "timeSchedule_test2" + termIndex.toString() + yearValue.toString(),
            i == time.length - 1 ? true : false);
      }
    }
  } else {
    // remove or  create
    await addFirestoreAndLocalDB(
      "timeSchedule_test2" + termIndex.toString() + yearValue.toString(),
      timeSchedule.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }
  return;
}

Future changeTimeContentInfromationRoom(
    int termIndex, int yearValue, List<TimeScheduleModel> timeSchedule) async {
  await addFirestoreAndLocalDB(
      "timeSchedule_test2" + termIndex.toString() + yearValue.toString(),
      timeSchedule.map((e) => jsonEncode(e.toMap())).toList());
}
