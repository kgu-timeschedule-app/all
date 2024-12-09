import 'package:time_schedule/functions/search_subject.dart';
import 'package:time_schedule/models/TimeScheduleModel.dart';

import '../models/TimeScheduleContentModel.dart';
import 'get_info.dart';

List<Map> getAbleSubject(
    {required Map<String, dynamic> syllabusData,
    required int index,
    bool? concentrate,
    required List<TimeScheduleModel> timeSchedule}) {
  List<Map<String, dynamic>> ableSubjectData = [];

  ableSubjectData = searchConditionalList(
      concentrate != null && concentrate == true
          ? 50
          : ((index % 7) - 1) * 7 + ((index / 7).ceil() - 1),
      syllabusData["data"].cast<Map<String, dynamic>>());

  List<Map> row = List.generate(
    ableSubjectData.length,
    (index) => {
      'id': index,
      'row': ableSubjectData[index],
      'check': false,
      'subject': ableSubjectData[index]["name"].split('／')[0] ??
          ableSubjectData[index]["name"],
      //チェック中かどうか
      // 'teacher': ableSubjectData[index]["担当者"].split('（')[0] ?? ableSubjectData[index]["担当者"], //チェック中かどうか
      'credit': ableSubjectData[index]["単位数"],
      'date': getDateString(list: ableSubjectData[index])
          .map<String>((String value) => value)
          .join(' / '),
      'evaluate': getEvaluateEasyString(list: ableSubjectData[index])
          .map<String>((String value) => value)
          .join(' / '),
    },
  );
  return row;
}

List<TimeScheduleModel> removeDuplicate(List<TimeScheduleModel> timeSchedule) {
  List<String?> idList =
      timeSchedule.map((e) => e.content?.id).toSet().toList();
  if (timeSchedule.length == 50) {
    idList +=
        timeSchedule[49].concentrate?.map((e) => e.id).toSet().toList() ?? [];
  }
  idList.removeWhere((item) => item == null || item == "");
  List<TimeScheduleModel?> resultConcentrate = [];
  List<TimeScheduleModel?> result = timeSchedule.map((e) {
    if (idList.contains(e.content?.id)) {
      idList.remove(e.content?.id);
      return e;
    }
  }).toList();
  if (timeSchedule.length == 50) {
    if (timeSchedule[49].concentrate != null) {
      resultConcentrate = timeSchedule[49].concentrate!.map((e) {
        if (idList.contains(e.id)) {
          idList.remove(e.id);
          return TimeScheduleModel(day: 50, period: 0, content: e);
        }
      }).toList();
    }
  }
  result += resultConcentrate;

  result.removeWhere((item) => item == null || item == "");
  if (result == [null]) {
    result = [];
    result.add(TimeScheduleModel(
        day: 0,
        period: 0,
        content: TimeScheduleContentModel(
            id: '',
            dept: "",
            subject: "",
            room: '',
            credit: 0,
            teacher: '',
            test: [[]],
            textbook: [],
            referencebook: [])));
  }
  return result.cast<TimeScheduleModel>();
}
