import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';

class FriendService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> addAvater(String userId, String avaterURL) async {
    await _database
        .ref("users/$userId/avater")
        .set(avaterURL)
        .catchError((error) {
      null;
    });
  }

  Future<void> addName(String userId, String name) async {
    await _database.ref("users/$userId/name").set(name).catchError((error) {
      null;
    });
  }

  Future<void> addFriend(String userId, String friendId) async {
    await _database.ref("friends/$userId/$friendId").set("nowCheck"); // 確認まだ
    await _database.ref("friends/$friendId/$userId").set("required");
  }

  Future<void> aproveFriend(String userId, String friendId) async {
    await _database.ref("friends/$userId/$friendId").set("friend"); // 確認
    await _database.ref("friends/$friendId/$userId").set("friend");
  }

  Future<void> deleteFriend(String userId, String friendId) async {
    await _database.ref("friends/$userId/$friendId").remove();
    await _database.ref("friends/$friendId/$userId").remove();
  }

  Future<Map<String, dynamic>> getUserInfo(String userid) {
    return _database.ref("users/$userid").once().then((event) {
      final Map<String, dynamic> data;
      if (event.snapshot.value == null) {
        data = {"id": userid, "name": "名前なし"};
      } else {
        data = Map<String, dynamic>.from(
            event.snapshot.value! as Map<Object?, Object?>);
        data.addAll({"id": userid});
      }
      return data;
    }).catchError((error) {
      print(error);
    });
  }

  StreamSubscription<DatabaseEvent> getFriends(
      String userId,
      Function setStateFriend,
      Function setStateRequest,
      Function setStateWating,
      Function setStateNull) {
    DatabaseReference friendallRef = _database.ref("friends/$userId");
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        setStateNull();
      }
    });
    return friendallRef.onValue.listen((DatabaseEvent event) async {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value == null) {
        setStateNull();
        return;
      }
      Map<dynamic, dynamic> friends = snapshot.value as Map<dynamic, dynamic>;
      List<String> friendIds = [];
      List<String> requiredFriend = [];
      List<String> waitingFriend = [];
      await Future.forEach(friends.entries, (MapEntry entry) async {
        String key = entry.key;
        String value = entry.value;
        if (value == "required") {
          requiredFriend.add(key);
        } else if (value == "nowCheck") {
          waitingFriend.add(key);
        } else if (value == "friend") {
          friendIds.add(key);
        }
      });
      try {
        Future.wait(waitingFriend.map((e) => getUserInfo(e)))
            .then((List<Map<String, dynamic>> maps) {
          setStateWating(maps);
        });
        Future.wait(friendIds.map((e) => getUserInfo(e)))
            .then((List<Map<String, dynamic>> maps) {
          setStateFriend(maps);
        });
        Future.wait(requiredFriend.map((e) => getUserInfo(e)))
            .then((List<Map<String, dynamic>> maps) {
          setStateRequest(maps);
        });
      } catch (e) {
        setStateNull();
      }
    }, onError: (handleError) => {null});
  }
}
