import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/friends.dart';

void addFriendFromLink(BuildContext context, String friendId) {
  final _userinfo = FirebaseAuth.instance.currentUser;
  if (_userinfo == null) {
    Navigator.pushNamed(context, "/profile");
    return;
  }
  FriendService()
      .addFriend(_userinfo.uid, friendId)
      .then((value) => Navigator.pushNamed(context, "/profile"));
  return;
}
