import 'dart:convert';

import '../models/TimeScheduleModel.dart';

List<Map<String, dynamic>> timescheduleToJson(List<String> timeSchedule) {
  List<TimeScheduleModel> timeScheduleJson = [];
  timeScheduleJson = timeSchedule
      .map((e) => TimeScheduleModel.fromMap(jsonDecode(e)))
      .toList();
  return timeScheduleJson.map((e) => e.toHideDetail()).toList();
}

List<String> timescheduleJsonToString(List<dynamic> timeSchedule) {
  return timeSchedule.map((e) => json.encode(e)).toList();
}
