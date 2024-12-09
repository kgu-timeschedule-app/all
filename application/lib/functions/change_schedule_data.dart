import 'dart:convert';

import '../models/TimeScheduleContentModel.dart';
import '../models/TimeScheduleModel.dart';
import 'fetch_firestore.dart';
import 'get_info.dart';
import 'get_subject_data.dart';

Future changeSchedule(time, List<TimeScheduleModel> timeSchedule,
    replaceSubject, setStateChange, dbname, bool isfinal) async {
  await getSubjectData(id: replaceSubject["row"]["id"])
      .then((Map<String, dynamic> value) async {
    setStateChange(timeSchedule[time].content = TimeScheduleContentModel(
      id: replaceSubject["row"]["id"].toString(),
      subject: replaceSubject["subject"].toString(),
      credit: replaceSubject["credit"] ?? 0,
      teacher: replaceSubject["row"]["担当者"].toString(),
      dept: replaceSubject["row"]["管理部署"].toString(),
      room: getRoomFromData(
          getRoomString(list: value.containsKey("評価") ? value["評価"] : null),
          time),
      test:
          getEvaluateString(list: value.containsKey("評価") ? value["評価"] : null),
      textbook:
          getTextbookinfo(list: value.containsKey("評価") ? value["評価"] : null),
      referencebook: getReferencebookinfo(
          list: value.containsKey("評価") ? value["評価"] : null),
    ));
    if (isfinal) {
      await addFirestoreAndLocalDB(
        dbname,
        timeSchedule.map((e) => jsonEncode(e.toMap())).toList(),
      );
    }
  });
  return Future.value();
}

Future changeConcentrateSchedule(
    timeSchedule, replaceSubject, setStateChange, dbname) async {
  await getSubjectData(id: replaceSubject["row"]["id"])
      .then((Map<String, dynamic> value) async {
    await setStateChange(
        timeSchedule[49].concentrate?.add(TimeScheduleContentModel(
              id: replaceSubject["row"]["id"].toString(),
              subject: replaceSubject["subject"].toString(),
              credit: replaceSubject["credit"] ?? 0,
              teacher: replaceSubject["row"]["担当者"].toString(),
              dept: replaceSubject["row"]["管理部署"].toString(),
              room: value.containsKey("評価")
                  ? getRoomString(list: value["評価"])[0][4]
                  : "",
              // concentrateならたぶんOK.
              test: getEvaluateString(
                  list: value.containsKey("評価") ? value["評価"] : null),
              textbook: getTextbookinfo(
                  list: value.containsKey("評価") ? value["評価"] : null),
              referencebook: getReferencebookinfo(
                  list: value.containsKey("評価") ? value["評価"] : null),
            )));
    List<String> a = timeSchedule
        .asMap()
        .entries
        .map((e) {
          if (e.key != 49) {
            return jsonEncode(e.value.toMap());
          } else {
            Map<String, dynamic> resultFormat = {
              "day": null,
              "period": null,
              "content": null,
              "concentrate": e.value.concentrate?.map((e) => e.toMap()).toList()
            };
            return jsonEncode(resultFormat);
          }
        })
        .toList()
        .cast<String>() as List<String>;
    await addFirestoreAndLocalDB(dbname, a);
  });
  return Future.value();
}
