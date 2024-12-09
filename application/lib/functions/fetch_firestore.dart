import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'timeschedule_to_json.dart';

Future<String?> addFirestoreAndLocalDB(dbname, input) async {
  final prefs = await SharedPreferences.getInstance();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  final connectivityResult = await Connectivity().checkConnectivity();
  // const _methodChannel = MethodChannel('io.timeschedule.kgu/schedule');
  await prefs.setStringList(dbname, input);

  if (uid != null && connectivityResult != ConnectivityResult.none) {
    var output = timescheduleToJson(input);
    return readFriendFirestore(uid).then((value) {
      if (value != null &&
          value.containsKey(dbname) &&
          compareListMap(output, value[dbname])) {
        return "OK";
      } else {
        return FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({dbname: output})
            .then((value) => "OK")
            .catchError((error) => "NG");
      }
    });
  } else {
    return null;
  }
  // try {
  //   final result =
  //       await _methodChannel.invokeMethod('setTimescheduleForWidgetKit');
  //   print(result);
  // } on PlatformException catch (e) {
  //   print('${e.message}');
  // }
}

Future<Map<String, dynamic>?> readFriendFirestore(String userId) async {
  return FirebaseFirestore.instance.collection('users').doc(userId).get().then(
    (DocumentSnapshot doc) {
      Map<String, dynamic>? data;
      if (doc.data() == null) {
        data = null;
      } else {
        data = doc.data() as Map<String, dynamic>;
      }
      return data;
    },
    onError: (e) => null,
  );
}

List<Map<String, dynamic>> sortContent(List<Map<String, dynamic>> list) {
  for (var map in list) {
    if (map['content'] == null) continue;
    final content = map['content'] as Map<String, dynamic>;
    final sortedContent = Map.fromEntries(
      content.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    map['content'] = sortedContent;
    map = {
      'day': map['day'],
      'period': map['period'],
      'concentrate': map['concentrate'],
      'content': sortedContent
    };
  }
  return list;
}

List<dynamic> sortContent2(List<dynamic> list) {
  for (var map in list) {
    if (map['content'] == null) continue;
    final content = map['content'] as Map<String, dynamic>;
    final sortedContent = Map.fromEntries(
      content.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    map['content'] = sortedContent;
    map = {
      'day': map['day'],
      'period': map['period'],
      'concentrate': map['concentrate'],
      'content': sortedContent
    };
  }
  return list;
}

bool compareListMap(List<Map<String, dynamic>> list1, List<dynamic> list2) {
// まずリストの長さを比較します
  if (list1.length != list2.length) {
    return false;
  }

// 次に、各リストをソートします
  list1 = sortContent(list1);
  list2 = sortContent2(list2);

// リスト内の各Map要素を順番に比較します
  if (!const DeepCollectionEquality.unordered().equals(list1, list2)) {
    return false;
  }
// すべての要素が一致する場合、リストは等しいと判断します
  return true;
}
