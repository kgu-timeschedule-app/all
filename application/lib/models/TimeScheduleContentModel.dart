class TimeScheduleContentModel {
  String id;
  final String? dept;
  String subject;
  String room;
  String teacher;
  int credit;
  List<List<dynamic>>? test;
  List<dynamic>? textbook;
  List<dynamic>? referencebook;

  TimeScheduleContentModel(
      {required this.id,
      required this.dept,
      required this.subject,
      required this.room,
      required this.teacher,
      required this.test,
      required this.credit,
      required this.referencebook,
      required this.textbook});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dept': dept,
      'subject': subject,
      'room': room,
      'teacher': teacher,
      'test': test,
      'credit': credit,
      'textbook': textbook,
      'referencebook': referencebook
    };
  }

  Map<String, dynamic> toHideDetail() {
    return {
      'id': id,
      'subject': subject,
      'room': room,
      'teacher': teacher,
      'credit': credit,
    };
  }

  factory TimeScheduleContentModel.fromMap(Map<String, dynamic> map) {
    List<List<dynamic>>? testListinList;
    if (map['test'] != null) {
      testListinList =
          (map['test'] as List).map((e) => e as List<dynamic>).toList();
    }
    return TimeScheduleContentModel(
      id: map['id'],
      dept: map['dept'],
      subject: map['subject'],
      room: map['room'],
      teacher: map['teacher'],
      test: testListinList,
      credit: map['credit'],
      textbook: map['textbook'],
      referencebook: map['referencebook'],
    );
  }
}
