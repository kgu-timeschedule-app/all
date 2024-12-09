import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../functions/read_local_strage_setting.dart';
import '../models/friends.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  // final GlobalKey _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name;
  String? _avater;
  bool _loading = false;
  bool _loadedText = false;
  final _storageReference = FirebaseStorage.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  late final _userinfo;

  String? getDisplayName(User user) {
    try {
      return user.displayName;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    _userinfo = FirebaseAuth.instance.currentUser;
    _databaseReference.child("users/" + _userinfo.uid).once().then((event) {
      final data = event.snapshot.value != null
          ? Map<String, dynamic>.from(event.snapshot.value as Map)
          : {"name": null, "avater": null};
      FriendService()
          .addName(_userinfo.uid, getDisplayName(_userinfo) ?? "名前未設定");
      FriendService().addAvater(_userinfo.uid, _userinfo.photoURL);

      setState(() {
        _name = data["name"] != null
            ? getDisplayName(_userinfo) ?? "名前未設定"
            : "名前未設定";
        _avater = data["avater"] ?? _userinfo.photoURL;
      });
    }).catchError((error) {
      print(error);
    });
    super.initState();
  }

  Future _uploadAvatar() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .catchError((error) {
      print(error);
    });
    if (image == null) {
      setState(() {
        _loading = false;
      });
      return;
    }
    final uploadTask = await _storageReference
        .ref("avatars/${_userinfo.uid}") // usernameにする
        .putFile(File(image.path))
        .catchError((error) {
      setState(() {
        _loading = false;
      });
      print(error);
    });
    var downloadUrl = await uploadTask.ref.getDownloadURL().catchError((error) {
      setState(() {
        _loading = false;
      });
      print(error);
    });
    FriendService().addAvater(_userinfo.uid, downloadUrl).catchError((error) {
      setState(() {
        _loading = false;
      });
    });
    if (_name == null) {
      FriendService().addName(_userinfo.uid, "名前未設定").catchError((e) {});
    }
    setState(() {
      _avater = downloadUrl;
      _loading = false;
    });
  }

  Future _updateName() async {
    setState(() {
      _loadedText = true;
    });
    FriendService().addName(_userinfo.uid, _name!).catchError((e) {
    }).then((value) {
      setState(() {
        _loadedText = false;
      });
    });
  }

  void _signOut() {
    print("Signout");
    FirebaseAuth.instance.signOut().then((value) {
      print("Logout");
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/nomalmain", (Route<dynamic> route) => false);
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userinfo == null) {
      return const Scaffold(
        body: Center(
          child: Text("ログインしてください"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(48, 24, 48, 0),
          child: Column(
            children: [
              _avater == null
                  ? _loading == true
                      ? const CircularProgressIndicator(
                          color: Colors.green,
                        )
                      : CircleAvatar(
                          radius: 100,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _loading = true;
                              });
                              _uploadAvatar();
                            },
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(_avater!),
                      radius: 100,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _loading = true;
                            _avater = null;
                          });
                          _uploadAvatar();
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _name ?? "",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("名前を変更"),
                              content: TextFormField(
                                initialValue: _name,
                                onChanged: (value) {
                                  setState(() {
                                    _name = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '名前を入力してください'; // エラーメッセージ
                                  }
                                  return null;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("キャンセル"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // バリデーションのチェック
                                      Navigator.of(context).pop();
                                      _updateName();
                                    }
                                  },
                                  child: const Text("変更"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                    child: Text("時間割共有設定",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const ChangeTimelineShareSetting(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if ((ModalRoute.of(context)!.settings.arguments
                                as Map<String, bool>)["isfirst"] !=
                            null) {
                          Navigator.pushReplacementNamed(context, "/");
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("設定完了"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _signOut(),
                      child: const Text("ログアウト"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser?.delete();
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/nomalmain", (Route<dynamic> route) => false);
                  },
                  child: Text("アカウント削除")),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeTimelineShareSetting extends StatefulWidget {
  const ChangeTimelineShareSetting({Key? key}) : super(key: key);

  @override
  State<ChangeTimelineShareSetting> createState() =>
      _ChangeTimelineShareSettingState();
}

class _ChangeTimelineShareSettingState
    extends State<ChangeTimelineShareSetting> {
  bool? isSwitched;

  @override
  void initState() {
    super.initState();
    readLocalstrageSettingBool("setting_share_timeline").then((value) {
      setState(() {
        isSwitched = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSwitched == null
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CupertinoSwitch(
                value: isSwitched!,
                onChanged: (value) {
                  setLocalstrageSettingBool(value, "setting_share_timeline");
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Text(isSwitched! ? "共有する" : "共有しない"),
              ),
            ],
          );
  }
}
