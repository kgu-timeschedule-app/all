import 'dart:async'; //非同期処理用
import 'dart:convert'; //httpレスポンスをJSON形式に変換用

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:time_schedule/functions/read_local_strage_time_schedule.dart'; //httpリクエスト用

Future<Map<String, dynamic>> getSubjectData({required String id}) async {
  final connectivityResult = await Connectivity().checkConnectivity();
  const speedResult = true;

  if (connectivityResult == ConnectivityResult.none || !speedResult) {
    return readLocalstrageSyllabus(force: false, context: null).then((value) {
      return value["data"]
          .firstWhere((element) => element['id'] == id, orElse: () => null);
    });
  } else {
    var response = await http
        .get(Uri.https('api.syllabus.tanemura.dev', 'all/' + id + '.json'))
        .timeout(const Duration(seconds: 600)); //httpリクエストを送信
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {};
    }
  }
}
