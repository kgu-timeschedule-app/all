import 'dart:async'; //非同期処理用
import 'dart:convert'; //httpレスポンスをJSON形式に変換用

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_schedule/functions/pull_time_schedule_from_syllabus.dart';
import 'package:time_schedule/functions/read_local_strage_setting.dart';

import '../models/TimeScheduleModel.dart';
import 'get_syllabus.dart';
import 'init_time_schedule.dart';

Future<List<TimeScheduleModel>> readLocalstrageTimeSchedule(
    int termIndex, int yearValue) async {
  List<TimeScheduleModel> timeSchedule = [];
  final prefs = await SharedPreferences.getInstance();
  final dbname =
      "timeSchedule_test2" + termIndex.toString() + yearValue.toString();
  // print(dbname + "to_read");
  if (prefs.getStringList(dbname) == null) {
    // print("null");
    timeSchedule = initTimeSchedule();
    return timeSchedule;
  } else {
    // print("no_null");
    final List<String>? items = prefs.getStringList(dbname);
    timeSchedule =
        items!.map((e) => TimeScheduleModel.fromMap(jsonDecode(e))).toList();

    return timeSchedule;
  }
}

Future<Map<String, dynamic>> readLocalstrageSyllabus(
    {required bool force,
    required context,
    Function? progress,
    bool? noNetwork}) async {
  final prefs = await SharedPreferences.getInstance();
  final connectivityResult = await Connectivity().checkConnectivity();
  const dbname = "syllabus";
  bool install = true;
  return readLocalstrageSettingBool("setting_anytime_install_syllabus")
      .then((value) async {
    // Added async here
    return readLocalstrageSettingBool("setting_mobile_data_install")
        .then((value2) async {
      if (value2 == false && connectivityResult == ConnectivityResult.mobile) {
        install = false;
      }
      if (connectivityResult == ConnectivityResult.none ||
          (noNetwork != null && noNetwork == true)) {
        final Map<String, dynamic> items =
            json.decode(prefs.getString(dbname)!);
        return items;
      }
      return isNeedSyllabusData().then((isneed) async {
        progress != null ? progress(2) : null;
        if (((value &&
                    install &&
                    (prefs.getString(dbname) == null ||
                        connectivityResult == ConnectivityResult.wifi ||
                        connectivityResult == ConnectivityResult.mobile)) ||
                force) &&
            (isneed || prefs.getString(dbname) == null)) {
          final value = await getSyllabusData(); // Used await here
          // タイムライン情報更新
          await pullTimeSchedule(context);
          prefs.setString(dbname, json.encode(value));
          return value;
        } else {
          await pullTimeSchedule(context); // Used await here
          final Map<String, dynamic> items =
              json.decode(prefs.getString(dbname)!);
          return items;
        }
      }).catchError((error) {
        final Map<String, dynamic> items =
            json.decode(prefs.getString(dbname)!);
        return items;
      });
    });
  });
}

Future<bool> readLocalstrageisTutorial() async {
  final prefs = await SharedPreferences.getInstance();
  const dbname = "tutorial";
  if (prefs.getBool(dbname) == null) {
    prefs.setBool(dbname, true);
    return false;
  } else {
    return true;
  }
}
