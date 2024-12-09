import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:time_schedule/models/TimeScheduleModel.dart';

import '../components/alert_dialog.dart';
import '../components/detail_timeline.dart';
import '../components/dropdown_year_and_term.dart';
import '../components/timeline_grid.dart';
import '../functions/fetch_firestore.dart';
import '../functions/get_able_subject.dart';
import '../functions/get_info.dart';
import '../functions/read_local_strage_setting.dart';
import '../functions/read_local_strage_time_schedule.dart';

class timeschedule extends StatefulWidget {
  Map<String, dynamic> syllabusData;
  final Function setSyllabus;

  timeschedule(
      {Key? key, required this.syllabusData, required this.setSyllabus})
      : super(key: key);

  @override
  State<timeschedule> createState() => _timescheduleState();
}

class _timescheduleState extends State<timeschedule> {
  final List<String> termList = ["spring", "fall"];

  final List<int> yearList = getAvailableTermList(DateTime.now());
  List<TimeScheduleModel> timeSchedule = [];
  Map<String, dynamic> syllabusFilterData = {};
  int? termIndex;
  int? yearValue;
  int owndept = 0;
  int showSuterday = 0;
  int my_grade_year = 0;
  bool is_useFilter = true;
  String setting_time = "";
  bool now_reload = false;
  bool now_upload = false;

  void setStates(e) {
    setState(() {
      e;
    });
  }

  String alphanumericToHalfLength(String rune) {
    final regex = RegExp(r'^[Ａ-Ｚ ０-９]+$');
    final charid = rune.codeUnitAt(0);
    return regex.hasMatch(rune) ? String.fromCharCode(charid - 65248) : rune;
  }

  Map<String, dynamic> syllabusDataFilter(
      Map<String, dynamic> syllabusData, int term, int year, bool useFilter) {
    return {
      "data": syllabusData["data"]
          .where((value) {
        // ここでエラーが発生する可能性があるため、エラーチェックを行う
        try {
          bool isFiltered = (!useFilter ||
              int.parse(alphanumericToHalfLength(value["履修基準年度"][0])) <= year + 1) &&
              (term == 1
                  ? value["開講期"] == 0 ||
                  value["開講期"] == 2 ||
                  value["開講期"] == 5 ||
                  value["開講期"] == 6 ||
                  value["開講期"] == 7 ||
                  value["開講期"] == 9 ||
                  value["開講期"] == 12 ||
                  value["開講期"] == 13
                  : value["開講期"] == 0 ||
                  value["開講期"] == 1 ||
                  value["開講期"] == 3 ||
                  value["開講期"] == 4 ||
                  value["開講期"] == 7 ||
                  value["開講期"] == 8 ||
                  value["開講期"] == 10 ||
                  value["開講期"] == 11);

          return isFiltered;
        } catch (e) {
          print('Error in filtering: $e');
          return false;
        }
      }).toList()
    };
  }

  void reload_time() {
    readLocalstrageSettingString("syllabus_time").then((time) {
      setState(() {
        setting_time = time;
      });
    });
  }

  @override
  initState() {
    reload_time();
    // _createInterstitialAd();
    readLocalstrageSettingInt("setting_main").then((value) {
      readLocalstrageSettingInt("setting_year").then((grade_year) {
        readLocalstrageSettingBool("setting_isRemove_bool").then((useFilter) {
          readLocalstrageSettingInt("setting_dept").then((dept) {
            readLocalstrageSettingBool("setting_showSD").then((sd) {
              setState(() {
                termIndex = value % 2;
                showSuterday = sd ? 1 : 0;
                yearValue = 2022 + (value / 2).floor();
                owndept = dept - 1;
                my_grade_year = grade_year;
                is_useFilter = useFilter;
                syllabusFilterData = syllabusDataFilter(
                    widget.syllabusData, termIndex!, grade_year, useFilter);
              });
              readLocalstrageTimeSchedule(termIndex!, yearValue!)
                  .then((result) => setState(() {
                        timeSchedule = result;
                      }));
            });
          });
        });
      });
    });
    super.initState();
  }

  void changeSchedule(valueTerm, valueYear) {
    if (valueTerm != null) {
      setState(() {
        termIndex = valueTerm;
        syllabusFilterData = syllabusDataFilter(
            widget.syllabusData, termIndex!, my_grade_year, is_useFilter);
      });
    } else {
      setState(() {
        yearValue = valueYear;
        syllabusFilterData = syllabusDataFilter(
            widget.syllabusData, termIndex!, my_grade_year, is_useFilter);
      });
    }
    readLocalstrageTimeSchedule(termIndex!, yearValue!)
        .then((result) => setState(() {
              timeSchedule = result;
            }));
  }

  Future<Map<String, dynamic>>? res;

  int nullPass(int? value) {
    if (value == null) {
      return 0;
    } else {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: yearValue == null || termIndex == null
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          DropdownYearandTerm(
                            yearList: yearList,
                            termList: termList,
                            yearValue: yearValue!,
                            termIndex: termIndex!,
                            onChange: changeSchedule,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "シラバス取得データ",
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    setting_time,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      now_reload = true;
                                    });
                                    res = readLocalstrageSyllabus(
                                        force: true, context: context);
                                    res!.then((value) {
                                      widget.setSyllabus(value);
                                      setState(() {
                                        now_reload = false;
                                      });
                                      reload_time();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.refresh_sharp,
                                    color: now_reload
                                        ? Colors.grey[800]
                                        : Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      now_upload = true;
                                    });
                                    addFirestoreAndLocalDB(
                                      "timeSchedule_test2" +
                                          termIndex.toString() +
                                          yearValue.toString(),
                                      timeSchedule
                                          .map((e) => jsonEncode(e.toMap()))
                                          .toList(),
                                    ).then((value) {
                                      if (value != "OK") {
                                        showDialog<void>(
                                            context: context,
                                            builder: (_) {
                                              return const AlertDialogCustom(
                                                  title:
                                                      'ログインしていません もしくはインターネットに接続できません',
                                                  content:
                                                      '大学のネットワーク, 通信速度が遅いネットワークではアップロードすることができません。4G / LTE接続などに切り替えてお試しください。');
                                            });
                                      }
                                      setState(() {
                                        now_upload = false;
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.upload,
                                    color: now_upload
                                        ? Colors.grey[800]
                                        : Colors.green,
                                  )),
                            ],
                          )
                        ]),
              titleSpacing: 0,
              flexibleSpace: null,
              automaticallyImplyLeading: false,
              bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: TabBar(
                      padding: EdgeInsets.all(0),
                      indicatorColor: Colors.white,
                      tabs: [Text("時間割"), Text("時間割詳細")],
                    ),
                  ))),
          body: Padding(
            padding: showSuterday == 0
                ? const EdgeInsets.fromLTRB(12, 0, 12, 0)
                : const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TabBarView(
              children: [
                SingleChildScrollView(
                    child: yearValue == null || termIndex == null
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              TimelineGrid(
                                owndept: owndept,
                                timeSchedule: timeSchedule,
                                syllabusFilterData: syllabusFilterData,
                                termIndex: termIndex!,
                                yearValue: yearValue!,
                                setStates: setStates,
                                showSuterday: showSuterday,
                                showtime: true,
                                // inschedule: inschedule,
                              )
                            ],
                          )),
                removeDuplicate(timeSchedule)
                        .map((e) => nullPass(e.content?.credit))
                        .isNotEmpty
                    ? DetailTimeline(
                        timeSchedule: removeDuplicate(timeSchedule))
                    : const SizedBox.shrink()
              ],
            ),
          )),
    );
  }
}
