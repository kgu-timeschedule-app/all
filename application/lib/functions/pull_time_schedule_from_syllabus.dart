import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:time_schedule/functions/fetch_firestore.dart';
import 'package:time_schedule/functions/get_info.dart';
import 'package:time_schedule/functions/get_subject_data.dart';
import 'package:time_schedule/functions/read_local_strage_time_schedule.dart';

Future pullTimeSchedule(context) {
  bool isChanged = false;
  bool isChanged2 = false;
  int index = 0;
  String room = "";
  int _now =
      DateTime.now().month <= 2 ? DateTime.now().year - 1 : DateTime.now().year;
  int _term = DateTime.now().month <= 2
      ? 1
      : DateTime.now().month <= 8
          ? 0
          : 1;

  Future _showDialog(String subject, String before, String after) async {
    if (subject == "" || before == "" || after == "") return;
    var value = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(subject + 'の授業情報の変更について'),
        content: Text(
            (before ?? "未定") + "\n から \n" + after + "に変更されました。\n 時間割に反映しました。"),
        actions: <Widget>[
          SimpleDialogOption(
            child: const Text('了解'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  return readLocalstrageTimeSchedule(_term, _now).then((result) async {
    await Future.forEach(result, (value) async {
      if (value.content != null && value.content!.id != "") {
        var sbj = await getSubjectData(id: value.content!.id);
        if (value.content!.teacher != sbj["担当者"]) {
          if (context != null) {
            if (sbj["name"] != null &&
                    sbj["担当者"] != null &&
                    value.content!.teacher != "" ||
                sbj["担当者"] != "") {
              _showDialog(sbj["name"], value.content!.teacher, sbj["担当者"]);
            }
          }
          value.content!.teacher = sbj["担当者"];
          isChanged2 = true;
        }
        if (value.content!.test != getEvaluateString(list: sbj["評価"])) {
          value.content!.test = getEvaluateString(list: sbj["評価"]);
          isChanged2 = true;
        }
        String currentRoom = value.content!.room;
        String evaluatedRoom = getRoomFromData(
            getRoomString(list: sbj["評価"]), 7 * (value.period!) + value.day!);

        if (currentRoom != evaluatedRoom) {
          if (context != null && evaluatedRoom != "") {
            room = evaluatedRoom;
            if (room != "NG" &&
                currentRoom != room &&
                ((!RegExp(r'[0-9]').hasMatch(currentRoom) &&
                        currentRoom.length <= 10) ||
                    currentRoom == "未定")) {
              _showDialog(sbj["name"], currentRoom.toString(), evaluatedRoom);
              value.content!.room = room;
              print("教室変更あり。");
              isChanged2 = true;
            }
          }
        }
      }
      ;
    });
    if (isChanged2) {
      await addFirestoreAndLocalDB(
        "timeSchedule_test2" + _term.toString() + _now.toString(),
        result.map((e) => jsonEncode(e.toMap())).toList(),
      );
    }
    ;
  });
}
