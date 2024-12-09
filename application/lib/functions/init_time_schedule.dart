import '../models/TimeScheduleContentModel.dart';
import '../models/TimeScheduleModel.dart';

List<TimeScheduleModel> initTimeSchedule() {
  List<TimeScheduleModel> timeSchedule = [];
  int x = 0;
  int y = 0;

  while (x < 7) {
    y = 0;
    while (y < 7) {
      timeSchedule.add(TimeScheduleModel(
          day: y,
          period: x,
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
      y += 1;
    }
    x += 1;
  }
  timeSchedule.add(TimeScheduleModel(concentrate: []));
  // print(timeSchedule.map((e) => print(e.toMap())));
  return timeSchedule;
}
