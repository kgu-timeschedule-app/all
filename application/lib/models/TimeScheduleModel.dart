import 'TimeScheduleContentModel.dart';

class TimeScheduleModel {
  int? day;
  int? period;
  TimeScheduleContentModel? content;
  List<TimeScheduleContentModel>? concentrate;

  TimeScheduleModel({this.day, this.period, this.content, this.concentrate});

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'period': period,
      'content': content?.toMap(),
      'concentrate': concentrate?.map((e) => e.toMap()).toList(),
    };
  }

  Map<String, dynamic> toHideDetail() {
    return {
      'day': day,
      'period': period,
      'content': content?.toHideDetail(),
      'concentrate': concentrate?.map((e) => e.toHideDetail()).toList(),
    };
  }

  factory TimeScheduleModel.fromMap(Map<String, dynamic> inputMap) {
    List<TimeScheduleContentModel>? result = [];
    if (inputMap['concentrate'] == null) {
      result = null;
    } else {
      inputMap['concentrate']
          .forEach((e) => result?.add(TimeScheduleContentModel.fromMap(e)));
    }
    return TimeScheduleModel(
      day: inputMap['day'],
      period: inputMap['period'],
      content: inputMap['content'] == null
          ? null
          : TimeScheduleContentModel.fromMap(inputMap['content']),
      concentrate: result,
    );
  }
}
