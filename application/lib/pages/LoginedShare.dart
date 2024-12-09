import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../components/all_friend_show_component.dart';
import '../models/friends.dart';

class LoginedSharePage extends StatefulWidget {
  const LoginedSharePage({Key? key, required this.auth}) : super(key: key);

  final User auth;

  @override
  State<LoginedSharePage> createState() => _LoginedSharePageState();
}

class _LoginedSharePageState extends State<LoginedSharePage> {
  List<Map<String, dynamic>> friendlist = [];
  List<Map<String, dynamic>> waitingfriendlist = [];
  List<Map<String, dynamic>> requiredfriendlist = [];
  String? userId;
  String? url;
  bool _isLoading = true;
  bool _now_reload = false;

  @override
  void initState() {
    super.initState();
    userId = widget.auth.uid;
    FriendService().getFriends(
        userId!,
        (List<Map<String, dynamic>> e) => {
              setState(() {
                friendlist = e;
                _isLoading = false;
              })
            },
        (List<Map<String, dynamic>> e) => {
              setState(() {
                requiredfriendlist = e;
                _isLoading = false;
              })
            },
        (List<Map<String, dynamic>> e) => {
              setState(() {
                waitingfriendlist = e;
                _isLoading = false;
              })
            },
        () => {
              setState(() {
                _isLoading = false;
              })
            });
    // .then((value) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('友達の時間割を見る'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _isLoading
                  ? const SpinKitWave(
                      color: Colors.green,
                      size: 50.0,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Text(
                              "自分の授業を友達が確認できない場合は時間割トップの右上のアップロードマークを押してください。友達を登録できない場合は友達が名前(設定 -> ユーザー登録)を設定しているか確認してください。",
                              style: TextStyle(fontSize: 16)),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: AllFriendShowComponent(
                              humanlist: friendlist,
                              userId: userId!,
                              isShowAddButton: true,
                              approveButton: false,
                              setStates: (input) {
                                setState(() => friendlist = input);
                              },
                              setStatesFriend: (input) {
                                setState(() => friendlist.add(input));
                              },
                              showTimeline: true,
                            )),
                        requiredfriendlist.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
                                    child: Text("友達申請",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  AllFriendShowComponent(
                                    humanlist: requiredfriendlist,
                                    userId: userId!,
                                    isShowAddButton: false,
                                    approveButton: true,
                                    showTimeline: false,
                                    setStates: (input) {
                                      setState(
                                          () => requiredfriendlist = input);
                                    },
                                    setStatesFriend: (input) {
                                      setState(() => friendlist.add(input));
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        waitingfriendlist.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
                                    child: Text("友達申請中",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  AllFriendShowComponent(
                                    humanlist: waitingfriendlist,
                                    userId: userId!,
                                    isShowAddButton: false,
                                    approveButton: false,
                                    setStates: (input) {
                                      setState(() => waitingfriendlist = input);
                                    },
                                    setStatesFriend: (input) {
                                      setState(() => friendlist.add(input));
                                    },
                                    showTimeline: false,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
