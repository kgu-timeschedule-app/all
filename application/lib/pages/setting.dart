import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../functions/get_info.dart';
import '../functions/read_local_strage_setting.dart';

class SettingPage extends StatefulWidget {
  final bool? istutrial;

  const SettingPage({this.istutrial, Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

String getTestAdRewardedUnitId() {
  String testBannerUnitId = "";
  if (Platform.isAndroid) {
    // Android のとき
    testBannerUnitId = "ca-app-pub-7942690227296112/3092672747";
  } else if (Platform.isIOS) {
    // iOSのとき
    testBannerUnitId = "ca-app-pub-7942690227296112/7902146292";
  }
  return testBannerUnitId;
}

class _SettingPageState extends State<SettingPage> {
  int? a;
  int? b;
  bool? c;
  int? d;
  bool? j;
  bool? h;
  bool? k;
  RewardedAd? _rewardedAd;
  bool _isRewardedAdReady = false;

  List sublist = getAvailableTermAndYearStringList(DateTime.now());
  List allDept = getAllDept();

  void createRewardedAd(BuildContext context) {
    RewardedAd.load(
        adUnitId: getTestAdRewardedUnitId(),
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            _rewardedAd = ad;
            _rewardedAd!.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              createRewardedAd(context);
            });
            _rewardedAd!.show(
                onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
              ad.dispose();
              Navigator.of(context).pushNamed('/color-choicing');
            });
            _isRewardedAdReady = false;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
  }

  @override
  initState() {
    readLocalstrageSettingBool("setting_isRemove_bool").then((value) {
      setState(() {
        c = value;
      });
    });
    readLocalstrageSettingBool("setting_showSD").then((value) {
      setState(() {
        j = value;
      });
    });
    readLocalstrageSettingInt("setting_year").then((value) {
      setState(() {
        a = value;
      });
    });
    readLocalstrageSettingInt("setting_main").then((value) {
      setState(() {
        b = value;
      });
    });
    readLocalstrageSettingInt("setting_dept").then((value) {
      setState(() {
        d = value;
      });
    });
    readLocalstrageSettingBool("setting_anytime_install_syllabus")
        .then((value) {
      setState(() {
        h = value;
      });
    });
    readLocalstrageSettingBool("setting_mobile_data_install").then((value) {
      setState(() {
        k = value;
      });
    });
    if (widget.istutrial == true) {
      initTargets();
      Future.delayed(const Duration(milliseconds: 500), showTutorial);
    }
    super.initState();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  setStates(e, String dbname, int value) {
    setState(() {
      e;
    });
    setLocalstrageSettingInt(value, dbname);
  }

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  final GlobalKey _key = GlobalKey();
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();
  final GlobalKey _key5 = GlobalKey();
  final GlobalKey _key6 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
          automaticallyImplyLeading: false,
        ),
        body: a == null || b == null || d == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Expanded(
                    child: SettingsList(
                      sections: [
                        SettingsSection(
                          title: const Text('設定'),
                          tiles: <SettingsTile>[
                            FirebaseAuth.instance.currentUser != null
                                ? SettingsTile.navigation(
                                    onPressed: (BuildContext context) {
                                      Navigator.of(context)
                                          .pushNamed('/profile', arguments: {
                                        'isfirsttime': false,
                                      });
                                      return const SizedBox.shrink();
                                    },
                                    leading: const Icon(
                                        Icons.supervised_user_circle_rounded),
                                    title: const Text('ユーザー登録 / 共有設定'),
                                  )
                                : SettingsTile.navigation(
                                    enabled: false,
                                    leading: const Icon(
                                        Icons.supervised_user_circle_rounded),
                                    title: const Text('(共有ページからログインが必要)'),
                                  ),
                            SettingsTile.navigation(
                              key: _key,
                              onPressed: (BuildContext context) {
                                Navigator.of(context)
                                    .pushNamed('/choose_main', arguments: [
                                  (i) => setStates(b = i, "setting_main", i),
                                  b
                                ]);
                                return const SizedBox.shrink();
                              },
                              leading: const Icon(Icons.event),
                              title: const Text('メイン時間割'),
                              value: Text(sublist[b!]),
                            ),
                            SettingsTile.navigation(
                              key: _key1,
                              onPressed: (BuildContext context) {
                                Navigator.of(context)
                                    .pushNamed('/choose_dept', arguments: [
                                  (i) => setStates(d = i, "setting_dept", i),
                                  d
                                ]);
                                return const SizedBox.shrink();
                              },
                              leading: const Icon(Icons.event),
                              title: const Text('所属学部'),
                              value: Text(allDept[d!]),
                            ),
                            SettingsTile.navigation(
                              key: _key2,
                              onPressed: (BuildContext context) {
                                Navigator.of(context)
                                    .pushNamed('/year', arguments: [
                                  (i) => setStates(a = i, "setting_year", i),
                                  a
                                ]);
                                return const SizedBox.shrink();
                              },
                              leading: const Icon(Icons.looks_one),
                              title: const Text('学年'),
                              value: Text((a! + 1).toString() + '年'),
                            ),
                            SettingsTile.switchTile(
                              key: _key3,
                              onToggle: (value) {
                                setState(() {
                                  c = value;
                                  setLocalstrageSettingBool(
                                      value, "setting_isRemove_bool");
                                });
                              },
                              initialValue: c,
                              leading:
                                  const Icon(Icons.no_meeting_room_rounded),
                              title: const Text('履修不可授業の非表示'),
                              description:
                                  const Text('設定した「学年」では履修ができない授業を非表示にします。'),
                            ),
                            SettingsTile.navigation(
                              onPressed: (BuildContext context) {
                                createRewardedAd(context);
                              },
                              leading: const Icon(Icons.color_lens),
                              title: const Text('テーマ色変更'),
                              description: const Text('広告視聴後に変更できます。'),
                            ),
                            SettingsTile.switchTile(
                              key: _key4,
                              onToggle: (value) {
                                setState(() {
                                  h = value;
                                  setLocalstrageSettingBool(value,
                                      "setting_anytime_install_syllabus");
                                });
                              },
                              initialValue: h,
                              leading: const Icon(Icons.download),
                              title: const Text('起動時データ自動ダウンロード'),
                              description: const Text(
                                  '起動時に自動でシラバスデータがダウンロードされます。手動でダウンロードする必要がなく、常に最新の状態になります。'),
                            ),
                            SettingsTile.switchTile(
                              key: _key5,
                              onToggle: (value) {
                                setState(() {
                                  j = value;
                                  setLocalstrageSettingBool(
                                      value, "setting_showSD");
                                });
                              },
                              initialValue: j,
                              leading: const Icon(Icons.calendar_month),
                              title: const Text('土曜日の表示'),
                              description: const Text('時間割に土曜日が表示されます。'),
                            ),
                            SettingsTile.switchTile(
                              key: _key6,
                              onToggle: (value) {
                                setState(() {
                                  k = value;
                                  setLocalstrageSettingBool(
                                      value, "setting_mobile_data_install");
                                });
                              },
                              initialValue: k,
                              leading: const Icon(Icons.mobile_friendly),
                              title: const Text('モバイル通信データでの自動ダウンロード'),
                              description: const Text(
                                  'モバイル通信データを利用してシラバスのデータをダウンロードします。'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  widget.istutrial == true
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/backtomain');
                          },
                          child: const Text('設定完了'),
                        )
                      : const SizedBox.shrink(),
                ],
              ));
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: _key,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "時間割ページで表示させる時間割の年 / 学期を選択してください。",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: _key1,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "自分の所属学部を入力してください。",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: _key2,
      contents: [
        TargetContent(
            align: ContentAlign.top,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "学年を入力してください。",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ],
            )),
      ],
      shape: ShapeLightFocus.RRect,
      radius: 5,
    ));

    targets.add(TargetFocus(
        identify: "Target 3",
        keyTarget: _key3,
        // color: Colors.red,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Column(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "設定した学年より上の学年の授業は非表示になります。",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10));

    targets.add(TargetFocus(
        identify: "Target 4",
        keyTarget: _key4,
        // color: Colors.red,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Column(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "起動時にシラバスのデータ(3MB~5MB)がダウンロードされます。以下設定で「モバイル通信データでの自動ダウンロード」をしていない場合はwifi環境時のみ自動でダウンロードします。",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10));

    targets.add(TargetFocus(
        identify: "Target 5",
        keyTarget: _key5,
        // color: Colors.red,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Column(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "時間割に土曜日が表示されます。",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10));

    targets.add(TargetFocus(
        identify: "Target 6",
        keyTarget: _key6,
        // color: Colors.red,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Column(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "モバイル通信データ接続時にもシラバスデータを自動ダウンロードします。",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10));
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
    )..show(context: context);
  }
}
