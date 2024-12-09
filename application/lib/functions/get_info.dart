import 'dart:core';

var campasData = [
  "すべてのキャンパス",
  "西宮上ケ原キャンパス",
  "神戸三田キャンパス",
  "大阪梅田キャンパス",
  "西宮市大学交流センター",
  "西宮聖和キャンパス",
  "オンライン",
  "東京丸の内キャンパス",
  "西宮北口キャンパス",
];
var adData = [
  "すべての部署",
  "神学部",
  "文学部",
  "社会学部",
  "法学部",
  "経済学部",
  "商学部",
  "理工学部",
  "総合政策学部",
  "人間福祉学部",
  "教育学部",
  "国際学部/International Studies",
  "理学部",
  "工学部",
  "生命環境学部",
  "建築学部",
  "使用しない（カリキュラム設定用　非正規　大学",
  "スポーツ科学・健康科学教育プログラム室",
  "共通教育センター",
  "キャリアセンター",
  "共通教育センター（情報科学科目）",
  "言語教育研究センター",
  "国際教育・協力センター（CIEC　JEASP）",
  "教職教育研究センター（資格）",
  "教職教育研究センター（教職専門）",
  "国際教育・協力センター/CIEC",
  "キリスト教と文化研究センター",
  "日本語教育センター",
  "ハンズオン・ラーニングセンター",
  "国連・外交統括センター",
  "神学研究科前期",
  "文学研究科前期",
  "社会学研究科前期",
  "法学研究科前期",
  "経済学研究科前期",
  "商学研究科前期",
  "理工学研究科前期",
  "総合政策研究科前期",
  "言語コミュニケーション前期",
  "人間福祉研究科前期",
  "教育学研究科前期",
  "理工学研究科修士",
  "国際学研究科前期",
  "大学院共通科目・認定科目前期",
  "神学研究科後期",
  "文学研究科後期",
  "社会学研究科後期",
  "法学研究科後期",
  "経済学研究科後期",
  "商学研究科後期",
  "理工学研究科後期",
  "総合政策研究科後期",
  "言語コミュニケーション後期",
  "人間福祉研究科後期",
  "教育学研究科後期",
  "経営戦略研究科後期",
  "国際学研究科後期",
  "大学院共通科目・認定科目後期",
  "司法研究科",
  "経営戦略研究科/IBA",
  "使用しない（カリキュラム設定用　非正規　大学院）",
];
var dayData = [
  "すべての曜日",
  "月１",
  "月２",
  "月３",
  "月４",
  "月５",
  "月６",
  "月７",
  "火１",
  "火２",
  "火３",
  "火４",
  "火５",
  "火６",
  "火７",
  "水１",
  "水２",
  "水３",
  "水４",
  "水５",
  "水６",
  "水７",
  "木１",
  "木２",
  "木３",
  "木４",
  "木５",
  "木６",
  "木７",
  "金１",
  "金２",
  "金３",
  "金４",
  "金５",
  "金６",
  "金７",
  "土１",
  "土２",
  "土３",
  "土４",
  "土５",
  "土６",
  "土７",
  "日１",
  "日２",
  "日３",
  "日４",
  "日５",
  "日６",
  "‐",
  "集中・その他",
];

var dayDatAll = [
  "すべて",
  "月曜１時限／Monday 1",
  "火曜１時限／Tuesday 1",
  "水曜１時限／Wednesday 1",
  "木曜１時限／Thursday 1",
  "金曜１時限／Friday 1",
  "土曜１時限／Saturday 1",
  "日曜３時限／Sunday 3",
  "月曜２時限／Monday 2",
  "火曜２時限／Tuesday 2",
  "水曜２時限／Wednesday 2",
  "木曜２時限／Thursday 2",
  "金曜２時限／Friday 2",
  "土曜２時限／Saturday 2",
  "日曜４時限／Sunday 4",
  "月曜３時限／Monday 3",
  "火曜３時限／Tuesday 3",
  "水曜３時限／Wednesday 3",
  "木曜３時限／Thursday 3",
  "金曜３時限／Friday 3",
  "土曜３時限／Saturday 3",
  "日曜５時限／Sunday 5",
  "月曜４時限／Monday 4",
  "火曜４時限／Tuesday 4",
  "水曜４時限／Wednesday 4",
  "木曜４時限／Thursday 4",
  "金曜４時限／Friday 4",
  " 土曜４時限／Saturday 4",
  "日曜６時限／Sunday 6",
  "月曜５時限／Monday 5",
  "火曜５時限／Tuesday 5",
  "水曜５時限／Wednesday 5",
  "木曜５時限／Thursday 5",
  "金曜５時限／Friday 5",
  "土曜５時限／Saturday 5",
  "‐／-",
  "月曜６時限／Monday 6",
  "火曜６時限／Tuesday 6",
  "水曜６時限／Wednesday 6",
  "木曜６時限／Thursday 6",
  "金曜６時限／Friday 6",
  "土曜６時限／Saturday 6",
  "集中・その他／Concentration/Other",
  "月曜７時限／Monday 7",
  "火曜７時限／Tuesday 7",
  "水曜７時限／Wednesday 7",
  "木曜７時限／Thursday 7",
  "金曜７時限／Friday 7",
  "土曜７時限／Saturday 7",
  "すべて",
  "火曜１時限／Tuesday 1",
  "水曜１時限／Wednesday 1",
  "木曜１時限／Thursday 1",
  "金曜１時限／Friday 1",
  "土曜１時限／Saturday 1",
  "日曜１時限／Sunday 1",
  "月曜１時限／Monday 1",
  "火曜２時限／Tuesday 2",
  "水曜２時限／Wednesday 2",
  "木曜２時限／Thursday 2",
  "集中・その他／Concentration/Other"
];

var termData = [
  "すべての学期",
  "通年",
  "春学期",
  "秋学期",
  "春学期前半",
  "春学期後半",
  "秋学期前半",
  "秋学期後半",
  "通年集中",
  "春学期集中",
  "秋学期集中",
  "春学期前半集中",
  "春学期後半集中",
  "秋学期前半集中",
  "秋学期後半集中",
];
var score = [
  "定期試験",
  "定期試験に代わるリポート",
  "授業中試験",
  "平常リポート",
  "プレゼンテーション・発表",
  "授業への参加度（自発性、積極性、主体性、等）",
  "その他",
  "授業外学修課題",
  "論文",
  "実技、実験"
];

var study = [
  "対面授業",
  "同時双方向型オンライン授業",
  "オンデマンドＡ型オンライン授業(時間割あり)",
  "オンデマンドＢ型オンライン授業(時間割なし)",
  "オンライン受講不可/Online attendance is NOT permitted.",
];

final List<String> lessonStarttimeSanda = [
  " 9:00",
  "11:10",
  "13:30",
  "15:20",
  "17:05"
];
final List<String> lessonFinishtimeSanda = [
  "10:40",
  "12:50",
  "15:10",
  "17:00",
  "18:45"
];
final List<String> lessonStarttimeUegahara = [
  " 8:50",
  "11:00",
  "13:20",
  "15:10",
  "17:00"
];
final List<String> lessonFinishtimeUegahara = [
  "10:30",
  "12:40",
  "15:00",
  "16:50",
  "18:40"
];

final List<String> howtoData = [
  "すべて",
  "「本登録」を含む",
  "「予備登録」を含む",
  "「申込科目」を含む",
];

final List<String> dayforpull = [
  "すべて",
  "月曜１時限／Monday 1",
  "月曜２時限／Monday 2",
  "月曜３時限／Monday 3",
  "月曜４時限／Monday 4",
  "月曜５時限／Monday 5",
  "月曜６時限／Monday 6",
  "月曜７時限／Monday 7",
  "火曜１時限／Tuesday 1",
  "火曜２時限／Tuesday 2",
  "火曜３時限／Tuesday 3",
  "火曜４時限／Tuesday 4",
  "火曜５時限／Tuesday 5",
  "火曜６時限／Tuesday 6",
  "火曜７時限／Tuesday 7",
  "水曜１時限／Wednesday 1",
  "水曜２時限／Wednesday 2",
  "水曜３時限／Wednesday 3",
  "水曜４時限／Wednesday 4",
  "水曜５時限／Wednesday 5",
  "水曜６時限／Wednesday 6",
  "水曜７時限／Wednesday 7",
  "木曜１時限／Thursday 1",
  "木曜２時限／Thursday 2",
  "木曜３時限／Thursday 3",
  "木曜４時限／Thursday 4",
  "木曜５時限／Thursday 5",
  "木曜６時限／Thursday 6",
  "木曜７時限／Thursday 7",
  "金曜１時限／Friday 1",
  "金曜２時限／Friday 2",
  "金曜３時限／Friday 3",
  "金曜４時限／Friday 4",
  "金曜５時限／Friday 5",
  "金曜６時限／Friday 6",
  "金曜７時限／Friday 7",
  "土曜１時限／Saturday 1",
  "土曜２時限／Saturday 2",
  "土曜３時限／Saturday 3",
  " 土曜４時限／Saturday 4",
  "土曜５時限／Saturday 5",
  "土曜６時限／Saturday 6",
  "土曜７時限／Saturday 7",
  "日曜１時限／Sunday 1",
  "日曜２時限／Sunday 2",
  "日曜３時限／Sunday 3",
  "日曜４時限／Sunday 4",
  "日曜５時限／Sunday 5",
  "日曜６時限／Sunday 6",
  "‐／-",
  "集中・その他／Concentration/Other"
];

List<String> getLessonStarttime({required int i}) {
  // 1: sanda, 2: uegahara
  if ([7, 11, 12, 13, 14, 15].contains(i)) {
    return lessonStarttimeSanda;
  } else {
    return lessonStarttimeUegahara;
  }
}

List<String> getLessonEndtime({required int i}) {
  // 1: sanda, 2: uegahara
  if ([7, 11, 12, 13, 14, 15].contains(i)) {
    return lessonFinishtimeSanda;
  } else {
    return lessonFinishtimeUegahara;
  }
}

List<String> getAllCampas() {
  return campasData;
}

List<String> getAllDay() {
  return dayData;
}

List<String> getAllDept() {
  return adData;
}

List<String> getAllHowto() {
  return howtoData;
}

List<String> getAllTerm() {
  return termData;
}

String getCampas({required int keyword}) {
  return campasData[keyword];
}

String getScore({required int keyword}) {
  return score[keyword];
}

String getTermData({required int keyword}) {
  return termData[keyword];
}

String getDay({required int keyword}) {
  return dayData[keyword];
}

String getDepartment({required int keyword}) {
  return adData[keyword];
}

String getHowto({required int keyword}) {
  return howtoData[keyword];
}

List<String> getDateString({required Object? list}) {
  List<String> result = [];
  int i = 1;
  if ((list as Map)["時限1"] == null) {
    return [""];
  }
  while (list["時限" + i.toString()] != null) {
    result.add(dayData[list["時限" + i.toString()] + 1]);
    i++;
  }
  return result;
}

String getAllDateString(int i) {
  return dayDatAll[i];
}

String getAllDatePullString(int i) {
  return dayforpull[i];
}

String getRoomPullFromData(List<List<dynamic>> data, int time) {
  var result = "NG";
  for (var e in data) {
    if (e.length > 2 && e[2] == getAllDatePullString(time)) {
      result = e[4];
      break;
    }
  }
  return result;
}

String getRoomFromData(List<List<dynamic>>? data, int time) {
  var result = "";
  if (data == null || data.isEmpty || data == [[]] || data[0].isEmpty) {
    return "";
  }
  for (var e in data) {
    if (e[2] == getAllDateString(time)) {
      result = e[4];
      break;
    }
  }
  return result;
}

List<int> getDateList({required Object? list}) {
  List<int> result = [];
  int i = 1;
  if ((list as Map)["時限1"] == null) {
    return [];
  }
  while (list["時限" + i.toString()] != null) {
    result.add(list["時限" + i.toString()] + 1);
    i++;
  }
  return result;
}

List<String> getEvaluateEasyString({required Object? list}) {
  List<String> result = [];
  int i = 1;
  if ((list as Map)["評価1"] == null) {
    return [""];
  }
  while (list["評価" + i.toString()] != null) {
    result.add(score[list["評価" + i.toString()]]);
    i++;
  }
  return result;
}

List<List<dynamic>> getEvaluateString({required Map<String, dynamic>? list}) {
  List<List<dynamic>> result = [];
  int i = 1;
  if (list == null || list["成績評価Grading" + i.toString()] == null) {
    return [[]];
  }
  while (list["成績評価Grading" + i.toString()] != null) {
    if (list["成績評価Grading" + i.toString()] is String) {
      result.insert(result.length, [list["成績評価Grading" + i.toString()]]);
    } else {
      result.insert(result.length, list["成績評価Grading" + i.toString()]);
    }
    i++;
  }
  return result;
}

List<List<dynamic>> getRoomString({required Map<String, dynamic>? list}) {
  List<List<dynamic>> result = [];
  int i = 1;
  if (list == null || list["項番No." + i.toString()] == null) {
    return [[]];
  }
  while (list["項番No." + i.toString()] != null) {
    if (list["項番No." + i.toString()] is String) {
      result.insert(result.length, [list["項番No." + i.toString()]]);
    } else {
      result.insert(result.length, list["項番No." + i.toString()]);
      i++;
    }
  }
  return result;
}

List<dynamic> getTextbookinfo({required Map<String, dynamic>? list}) {
  List<dynamic> result = [];
  int i = 0;
  if (list == null ||
      (list["教科書/Required texts" + i.toString()] == null &&
          list["教科書Required texts" + i.toString()] == null)) {
    return [""];
  }
  if (list["教科書/Required texts" + i.toString()] != null &&
      list["教科書Required texts" + i.toString()] == null) {
    while (list["教科書/Required texts" + i.toString()] != null) {
      result.add(list["教科書/Required texts" + i.toString()]);
      i++;
    }
    return result;
  } else {
    while (list["教科書Required texts" + i.toString()] != null) {
      result.add(list["教科書Required texts" + i.toString()]);
      i++;
    }
    return result;
  }
}

List<dynamic> getReferencebookinfo({required Map<String, dynamic>? list}) {
  List<dynamic> result = [];
  int i = 0;
  if (list == null ||
      list["参考書/Reference book" + i.toString()] == null &&
          list["参考文献・資料Reference books" + i.toString()] == null) {
    return [""];
  }
  if (list["参考書/Reference book" + i.toString()] != null &&
      list["参考文献・資料Reference books" + i.toString()] == null) {
    while (list["参考書/Reference book" + i.toString()] != null) {
      result.add(list["参考書/Reference book" + i.toString()]);
      i++;
    }
    return result;
  } else {
    while (list["参考文献・資料Reference books" + i.toString()] != null) {
      result.add(list["参考文献・資料Reference books" + i.toString()]);
      i++;
    }
    return result;
  }
}

String getStudyWay({required int keyword}) {
  return study[keyword];
}

String becomeSmallname(String s) {
  return s.indexOf("／") == 0 ? s : s.split("／")[0];
}

List<int> getAvailableTermList(DateTime now) {
  // 開始を2022年秋学期にする
  // sublist = ["2022年秋学期"];
  List<int> result = [];
  int year = 2022;
  // int term = 1;
  // int i = 0;
  // List termList = ["春", "秋"];
  while (year <= now.year + 1) {
    // i = 0;
    // term = 1;
    // if (year == now.year && (now.month >= 1 && now.month <= 6)) {
    //   term = 0; // 春学期
    // }
    // while (i <= 1) {
    result.add(year);
    //   i++;
    // }
    year++;
  }
  return result;
}

List<String> getAvailableTermAndYearStringList(DateTime now) {
  // 開始を2022年秋学期にする
  List<String> result = [];
  int year = 2022;
  int term = 1;
  int i = 0;
  List termList = ["春", "秋"];
  while (year <= now.year + 1) {
    i = 0;
    term = 1;
    // if (year == now.year) {
    //   term = 0; // 春学期
    // }
    while (i <= term) {
      result.add(year.toString() + "年" + termList[i] + "学期");
      i++;
    }
    year++;
  }
  return result;
}
