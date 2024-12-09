import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uuid/uuid.dart';

import '../functions/change_timecell.dart';
import '../functions/get_able_subject.dart';
import '../models/TimeScheduleContentModel.dart';
import '../models/TimeScheduleModel.dart';
import '../pages/searchWebView.dart';
import 'change_timeline_cell_value.dart';
import 'choicing_timeline_cell_accordion_component.dart';
import 'test_information_detail_timeline.dart';

class ChoicingTimeLineCellPage extends StatefulWidget {
  final int index;
  List<TimeScheduleModel> timeSchedule;
  final Map<String, dynamic> syllabusData;
  final Function setStates;
  final int termIndex;
  final int yearValue;
  final int owndept;
  final bool? concentrate;

  ChoicingTimeLineCellPage(
      {Key? key,
      required this.index,
      required this.timeSchedule,
      required this.syllabusData,
      required this.setStates,
      required this.termIndex,
      required this.yearValue,
      required this.owndept,
      required this.concentrate})
      : super(key: key);

  @override
  State<ChoicingTimeLineCellPage> createState() =>
      _ChoicingTimeLineCellPageState();
}

class _ChoicingTimeLineCellPageState extends State<ChoicingTimeLineCellPage> {
  List<String> dayOfWeek = ["月", "火", "水", "木", "金", "土", "日"];
  bool selectedSubject = false;
  List<Map> _rows = [];
  int checked = -1;
  bool roomchanged = false;
  String id = "";
  String subject = "";
  String teacher = "";
  String room = "";
  String credit = "";
  bool _loading = false;

  void setStatesInChocingChecked(e) {
    setState(() {
      checked = e;
    });
  }

  @override
  initState() {
    setState(() {
      _rows = getAbleSubject(
          syllabusData: widget.syllabusData,
          index: widget.index,
          concentrate: widget.concentrate,
          timeSchedule: widget.timeSchedule);
      if (widget.concentrate == false || widget.concentrate == null) {
        id = widget.timeSchedule[widget.index - 7].content!.id;
        subject = widget.timeSchedule[widget.index - 7].content!.subject;
        teacher = widget.timeSchedule[widget.index - 7].content!.teacher;
        room = widget.timeSchedule[widget.index - 7].content!.room;
        credit =
            widget.timeSchedule[widget.index - 7].content!.credit.toString();
      } else if (widget.timeSchedule[49].concentrate!.length > widget.index) {
        id = widget.timeSchedule[49].concentrate![widget.index].id;
        subject = widget.timeSchedule[49].concentrate![widget.index].subject;
        teacher = widget.timeSchedule[49].concentrate![widget.index].teacher;
        room = widget.timeSchedule[49].concentrate![widget.index].room;
        credit = widget.timeSchedule[49].concentrate![widget.index].credit
            .toString();
      } else {
        id = "";
        subject = "";
        teacher = "";
        room = "";
        credit = "";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(0),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
            margin: const EdgeInsets.only(top: 0.0, right: 0.0),
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12, right: 12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffD26919)),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: ListView(children: [
                        widget.concentrate != null
                            ? const Text("集中科目", style: TextStyle(fontSize: 24))
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                    Text(dayOfWeek[(widget.index % 7) - 1],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    const Text("曜日",
                                        style: TextStyle(fontSize: 15)),
                                    Text(
                                        ((widget.index / 7).ceil() - 1)
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    const Text("限目",
                                        style: TextStyle(fontSize: 15))
                                  ]),
                        (widget.timeSchedule[49].concentrate!.length >
                                        widget.index &&
                                    widget.concentrate == true) ||
                                (widget.concentrate == null &&
                                    widget.timeSchedule[widget.index - 7]
                                            .content!.subject !=
                                        "")
                            ? Column(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16, 0, 12),
                                  child: Text(
                                      widget.concentrate != null &&
                                              widget.concentrate == true
                                          ? widget
                                              .timeSchedule[49]
                                              .concentrate![widget.index]
                                              .subject
                                          : widget
                                              .timeSchedule[widget.index - 7]
                                              .content!
                                              .subject,
                                      style: const TextStyle(fontSize: 24)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 12),
                                  child: Text(
                                      widget.concentrate != null &&
                                              widget.concentrate == true
                                          ? widget
                                              .timeSchedule[49]
                                              .concentrate![widget.index]
                                              .teacher
                                          : widget
                                              .timeSchedule[widget.index - 7]
                                              .content!
                                              .teacher,
                                      style: const TextStyle(fontSize: 12)),
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 12),
                                    child: Text(
                                        widget.concentrate != null &&
                                                widget.concentrate == true
                                            ? widget
                                                    .timeSchedule[49]
                                                    .concentrate![widget.index]
                                                    .credit
                                                    .toString() +
                                                "単位"
                                            : widget
                                                    .timeSchedule[
                                                        widget.index - 7]
                                                    .content!
                                                    .credit
                                                    .toString() +
                                                "単位",
                                        style: const TextStyle(fontSize: 16))),
                                TextButton(
                                  onPressed: () {
                                    String id;
                                    if (!(widget.concentrate != null &&
                                        widget.concentrate == true)) {
                                      id = widget.timeSchedule[widget.index - 7]
                                          .content!.id;
                                    } else {
                                      id = widget.timeSchedule[49]
                                          .concentrate![widget.index].id;
                                    }
                                    _showWebViewDialog(context, id);
                                  },
                                  child: const Text(
                                    'シラバス詳細を表示',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                                widget.concentrate != null &&
                                        widget.concentrate == true
                                    ? const SizedBox.shrink()
                                    : TestinformationDetailTimeline(
                                        data: widget
                                            .timeSchedule[widget.index - 7]
                                            .toMap(),
                                        showname: false,
                                        issyllabus: false,
                                        context: context),
                              ])
                            : (const SizedBox.shrink()),
                        ExpansionTile(
                            title: const Text('手動編集',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            children: [
                              ChangeTimelineCellValue(
                                  title: "科目名　",
                                  defaultValue: subject,
                                  onChanged: (value) {
                                    setState(() {
                                      roomchanged = true;
                                      subject = value;
                                    });
                                  }),
                              ChangeTimelineCellValue(
                                  title: "担当者名",
                                  defaultValue: teacher,
                                  onChanged: (value) {
                                    setState(() {
                                      roomchanged = true;
                                      teacher = value;
                                    });
                                  }),
                              ChangeTimelineCellValue(
                                  title: "単位数　",
                                  isInt: true,
                                  defaultValue: credit.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      roomchanged = true;
                                      credit = value;
                                    });
                                  }),
                              ChangeTimelineCellValue(
                                  title: "教室(半角)",
                                  defaultValue: room,
                                  onChanged: (value) {
                                    setState(() {
                                      roomchanged = true;
                                      room = value;
                                    });
                                  }),
                            ]),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 30, 0, 10),
                          child: Text(
                              (widget.timeSchedule[49].concentrate!.length >=
                                              widget.index &&
                                          widget.concentrate == true) ||
                                      widget.timeSchedule[widget.index - 7]
                                              .content!.subject ==
                                          ""
                                  ? "追加する授業の選択"
                                  : "変更先授業の選択",
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xff3c3ffc))),
                        ),
                        ExpansionTile(title: const Text('指定学部'), children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                            child: ChocingTimelineCellAccordion(
                              rows: _rows
                                  .where((element) =>
                                      element["row"]["管理部署"] == widget.owndept)
                                  .toList(),
                              checked: checked,
                              setStatesInChocing: setStatesInChocingChecked,
                              // setStates: widget.setStates,
                            ),
                          ),
                        ]),
                        ExpansionTile(
                            title: const Text('他学部 / 全学科目'),
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                                child: ChocingTimelineCellAccordion(
                                  rows: _rows
                                      .where((element) =>
                                          element["row"]["管理部署"] !=
                                          widget.owndept)
                                      .toList(),
                                  checked: checked,
                                  setStatesInChocing: setStatesInChocingChecked,
                                ),
                              ),
                            ]),
                      ]),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widget.timeSchedule[49].concentrate != null ||
                                    widget.timeSchedule[widget.index - 7]
                                            .content !=
                                        null
                                ? widget.concentrate != null
                                    ? TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            _loading = true;
                                          });
                                          await changeTimeCell(
                                                  widget.syllabusData,
                                                  {
                                                    "row": widget.syllabusData["data"]
                                                                .where((element) =>
                                                                    element["id"] ==
                                                                    widget
                                                                        .timeSchedule[
                                                                            49]
                                                                        .concentrate?[widget
                                                                            .index]
                                                                        .id)
                                                                .toList()
                                                                .length >
                                                            0
                                                        ? widget.syllabusData[
                                                                "data"]
                                                            .where((element) =>
                                                                element["id"] ==
                                                                widget
                                                                    .timeSchedule[
                                                                        49]
                                                                    .concentrate?[widget
                                                                        .index]
                                                                    .id)
                                                            .toList()[0]
                                                        : widget
                                                            .timeSchedule[49]
                                                            .concentrate?[
                                                                widget.index]
                                                            .toMap()
                                                  },
                                                  null,
                                                  widget.timeSchedule,
                                                  widget.setStates,
                                                  widget.termIndex,
                                                  widget.yearValue,
                                                  widget.index,
                                                  true)
                                              .then((value) {
                                            setState(() {
                                              _loading = false;
                                            });
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: _loading == true
                                            ? const SpinKitWave(
                                                color: Colors.green,
                                                size: 50.0,
                                              )
                                            : Text('授業を削除',
                                                style: TextStyle(
                                                    color: checked == -1
                                                        ? Colors.red
                                                        : const Color(
                                                            0xffc9c9c9b0),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      )
                                    : (widget.timeSchedule[49].concentrate!
                                                        .length <=
                                                    widget.index &&
                                                widget.concentrate == true) ||
                                            widget
                                                    .timeSchedule[
                                                        widget.index - 7]
                                                    .content!
                                                    .subject ==
                                                ""
                                        ? const SizedBox.shrink()
                                        : TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                _loading = true;
                                              });
                                              await changeTimeCell(
                                                      widget.syllabusData,
                                                      widget.concentrate == true
                                                          ? widget
                                                                      .timeSchedule[
                                                                          49]
                                                                      .concentrate!
                                                                      .length <
                                                                  widget.index
                                                              ? {
                                                                  "row": widget
                                                                      .syllabusData[
                                                                          "data"]
                                                                      .where((element) =>
                                                                          element[
                                                                              "id"] ==
                                                                          widget
                                                                              .timeSchedule[49]
                                                                              .concentrate![widget.index]
                                                                              .id)
                                                                      .toList()[0]
                                                                }
                                                              : null
                                                          : widget.syllabusData[
                                                                          "data"]
                                                                      .where((element) =>
                                                                          element[
                                                                              "id"] ==
                                                                          widget
                                                                              .timeSchedule[widget.index -
                                                                                  7]
                                                                              .content!
                                                                              .id)
                                                                      .toList()
                                                                      .length >
                                                                  0
                                                              ? {
                                                                  "row": widget
                                                                      .syllabusData[
                                                                          "data"]
                                                                      .where((element) =>
                                                                          element[
                                                                              "id"] ==
                                                                          widget
                                                                              .timeSchedule[widget.index - 7]
                                                                              .content!
                                                                              .id)
                                                                      .toList()[0]
                                                                }
                                                              : {
                                                                  "row": widget
                                                                      .timeSchedule[
                                                                          widget.index -
                                                                              7]
                                                                      .content!
                                                                      .toMap()
                                                                },
                                                      null,
                                                      widget.timeSchedule,
                                                      widget.setStates,
                                                      widget.termIndex,
                                                      widget.yearValue,
                                                      widget.index,
                                                      false)
                                                  .then((value) {
                                                setState(() {
                                                  _loading = false;
                                                });
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: _loading == true
                                                ? const SpinKitWave(
                                                    color: Colors.green,
                                                    size: 50.0,
                                                  )
                                                : Text('授業を削除',
                                                    style: TextStyle(
                                                        color: checked == -1
                                                            ? Colors.red
                                                            : const Color(
                                                                0xffc9c9c9b0),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                          )
                                : const SizedBox.shrink(),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextButton(
                                onPressed: () async {
                                  // print("C");
                                  setState(() {
                                    _loading = true;
                                  });
                                  if (checked != -1) {
                                    // print("CC");
                                    await changeTimeCell(
                                            widget.syllabusData,
                                            widget.concentrate == true
                                                ? widget
                                                            .timeSchedule[49]
                                                            .concentrate!
                                                            .length <
                                                        widget.index
                                                    ? {
                                                        "row": widget
                                                            .syllabusData[
                                                                "data"]
                                                            .where((element) =>
                                                                element["id"] ==
                                                                widget
                                                                    .timeSchedule[
                                                                        49]
                                                                    .concentrate![
                                                                        widget
                                                                            .index]
                                                                    .id)
                                                            .toList()[0]
                                                      }
                                                    : null
                                                : widget
                                                                .timeSchedule[
                                                                    widget.index -
                                                                        7]
                                                                .content!
                                                                .id ==
                                                            "" &&
                                                        widget.syllabusData[
                                                                    "data"]
                                                                .where((element) =>
                                                                    element[
                                                                        "id"] ==
                                                                    widget
                                                                        .timeSchedule[
                                                                            widget.index -
                                                                                7]
                                                                        .content!
                                                                        .id)
                                                                .toList() !=
                                                            []
                                                    ? null
                                                    : {
                                                        "row": widget
                                                            .syllabusData[
                                                                "data"]
                                                            .where((element) =>
                                                                element["id"] ==
                                                                widget
                                                                    .timeSchedule[
                                                                        widget.index -
                                                                            7]
                                                                    .content!
                                                                    .id)
                                                            .toList()[0]
                                                      },
                                            _rows[checked],
                                            widget.timeSchedule,
                                            widget.setStates,
                                            widget.termIndex,
                                            widget.yearValue,
                                            widget.index,
                                            false)
                                        .then((value) {
                                      setState(() {
                                        _loading = false;
                                      });
                                      Navigator.pop(context);
                                    });
                                  } else if (roomchanged) {
                                    // print("CCA");
                                    // print(widget.concentrate);
                                    if (widget.concentrate == null ||
                                        widget.concentrate == false) {
                                      if (widget.timeSchedule[widget.index - 7]
                                              .content!.id ==
                                          "") {
                                        var uuid = const Uuid();
                                        widget.setStates(widget
                                            .timeSchedule[widget.index - 7]
                                            .content!
                                            .id = uuid.v4());
                                      }
                                      widget.setStates(widget
                                          .timeSchedule[widget.index - 7]
                                          .content!
                                          .room = room);
                                      widget.setStates(widget
                                          .timeSchedule[widget.index - 7]
                                          .content!
                                          .teacher = teacher);
                                      widget.setStates(widget
                                              .timeSchedule[widget.index - 7]
                                              .content!
                                              .credit =
                                          credit == "" ? 0 : int.parse(credit));
                                      widget.setStates(widget
                                          .timeSchedule[widget.index - 7]
                                          .content!
                                          .subject = subject);
                                    } else {
                                      // 集中
                                      if (widget.timeSchedule[49].concentrate!
                                              .length <=
                                          widget.index) {
                                        // 登録なし
                                        // print("CCBA");
                                        var uuid = const Uuid();
                                        widget.setStates(widget
                                            .timeSchedule[49].concentrate!
                                            .add(TimeScheduleContentModel(
                                                id: uuid.v4(),
                                                subject: subject,
                                                credit: credit == ""
                                                    ? 0
                                                    : int.parse(credit),
                                                teacher: teacher,
                                                dept: "",
                                                room: room,
                                                test: [[]],
                                                textbook: [],
                                                referencebook: [])));
                                      } else {
                                        widget.setStates(widget
                                            .timeSchedule[49]
                                            .concentrate![widget.index]
                                            .room = room);
                                        widget.setStates(widget
                                            .timeSchedule[49]
                                            .concentrate![widget.index]
                                            .teacher = teacher);
                                        widget.setStates(widget
                                                .timeSchedule[49]
                                                .concentrate![widget.index]
                                                .credit =
                                            credit == ""
                                                ? 0
                                                : int.parse(credit));
                                        widget.setStates(widget
                                            .timeSchedule[49]
                                            .concentrate![widget.index]
                                            .subject = subject);
                                      }
                                    }
                                    await changeTimeContentInfromationRoom(
                                      widget.termIndex,
                                      widget.yearValue,
                                      widget.timeSchedule,
                                    ).then((value) {
                                      setState(() {
                                        _loading = false;
                                      });
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    null;
                                  }
                                },
                                child: _loading == true
                                    ? const SpinKitWave(
                                        color: Colors.green,
                                        size: 50.0,
                                      )
                                    : Text('保存',
                                        style: TextStyle(
                                            color: checked != -1 || roomchanged
                                                ? Colors.blue
                                                : const Color(0xffC9C9C9B0),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ]),
                    ),
                  ]),
                ),
              ),
              Positioned(
                right: 0.0,
                top: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 18.0,
                      backgroundColor: Color(0xffD26919),
                      child: Icon(Icons.close, color: Colors.white, size: 24.0),
                    ),
                  ),
                ),
              ),
            ])));
  }
}

void _showWebViewDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(0),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 12.0, right: 12.0),
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 2.0, color: const Color(0xff5dbbed)),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    searchWebView(id: id),
                  ],
                )),
            Positioned(
              right: 0.0,
              top: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 18.0,
                    backgroundColor: Color(0xff5dbbed),
                    child: Icon(Icons.close, color: Colors.white, size: 24.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
