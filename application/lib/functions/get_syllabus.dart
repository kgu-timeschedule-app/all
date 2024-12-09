import 'dart:async'; //非同期処理用
import 'dart:convert'; //httpレスポンスをJSON形式に変換用

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:time_schedule/functions/read_local_strage_setting.dart'; //httpリクエスト用

Future<Map<String, dynamic>> getSyllabusData() async {
  var response = await http
      .get(Uri.https('api.syllabus.tanemura.dev', 'fuse.json'))
      .timeout(const Duration(seconds: 600)); //httpリクエストを送信
  var version = await http
      .get(Uri.https('api.syllabus.tanemura.dev', 'all_version.txt'))
      .timeout(const Duration(seconds: 600)); //httpリクエストを送信
  if (response.statusCode == 200) {
    setLocalstrageSettingString(
        DateFormat('MM/dd HH:mm').format(DateTime.now()), "syllabus_time");
    setLocalstrageSettingInt(int.parse(version.body), "syllabus_number");
    return json.decode(response.body);
  } else {
    throw Exception('Internet Error');
  }
}

Future<bool> isNeedSyllabusData() async {
  return readLocalstrageSettingInt("syllabus_number")
      .then((beforenumber) async {
    var response = await http
        .get(Uri.https('api.syllabus.tanemura.dev', 'all_version.txt'))
        .timeout(const Duration(seconds: 300)); //httpリクエストを送信
    if (response.statusCode == 200) {
      if (beforenumber != int.parse(response.body)) {
        return true;
      } else {
        return false; //Todo: falseにする
      }
    } else {
      return false;
    }
  });
}
