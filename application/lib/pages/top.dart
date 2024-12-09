import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:time_schedule/pages/search.dart';
import 'package:time_schedule/pages/setting.dart';
import 'package:time_schedule/pages/share.dart';
import 'package:time_schedule/pages/timeschedule.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/link.dart';

import '../functions/read_local_strage_time_schedule.dart';

class MainPage extends StatefulWidget {
  final bool? showtutorial;

  const MainPage({this.showtutorial, Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _selectedIndex = 1;
  int _loadingNumber = 0;
  bool isLoading = true;
  bool forceCheck = false;
  late TutorialCoachMark tutorialCoachMark;
  Future<Map<String, dynamic>>? res;
  List<Widget>? _bottomNavigationWidgetOptions;
  List<TargetFocus> targets = [];
  bool showButton = false;
  late Map<String, dynamic> syllabusData;

  final GlobalKey _key = GlobalKey();
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();

  final List<String> _loadingProgress = [
    "チュートリアル情報取得中 1 / 4...",
    "シラバスデータ確認中 2 / 4...",
    "教室情報確認中 3 / 4...",
    "時間割データ確認中 4 / 4..."
  ];

  void setSyllabus(Map<String, dynamic> syllabus) {
    setState(() {
      syllabusData = syllabus;
    });
  }

  void changeLoadingProgress(int number) {
    setState(() {
      _loadingNumber = number;
    });
  }

  void missedGetData() {
    setState(() {
      isLoading = false; // エラーが発生した場合も、ローディングの状態をfalseに設定
      try {
        syllabusData.isNotEmpty;
        _bottomNavigationWidgetOptions = <Widget>[
          search(syllabusData: syllabusData),
          timeschedule(
              syllabusData: syllabusData,
              setSyllabus: (value) => setState(() => setSyllabus(value))),
          const SharePage(),
          const SettingPage(),
        ];
      } catch (e) {
        readLocalstrageSyllabus(
                force: false,
                context: context,
                progress: changeLoadingProgress,
                noNetwork: showButton)
            .then((value) {
          setState(() {
            syllabusData = value;
            isLoading = false;
          });
          changeLoadingProgress(3);
          _bottomNavigationWidgetOptions = <Widget>[
            search(syllabusData: syllabusData),
            timeschedule(
                syllabusData: syllabusData,
                setSyllabus: (value) => setState(() => setSyllabus(value))),
            const SharePage(),
            const SettingPage(),
          ];
        });
      }
    });
  }

  _checkConditionAndShowButton() {
    if (_loadingNumber >= 1 &&
        _bottomNavigationWidgetOptions == null &&
        widget.showtutorial != true) {
      setState(() {
        showButton = true;
      });
    }
  }

  @override
  void initState() {
    readLocalstrageisTutorial().then((value) {
      if (value == false && widget.showtutorial != true) {
        Navigator.pushNamed(context, '/tutorial');
      }
    });
    if (widget.showtutorial == true) {
      initTargets();
      Future.delayed(const Duration(milliseconds: 500), showTutorial);
    }
    changeLoadingProgress(1);
    _checkConditionAndShowButton();
    readLocalstrageSyllabus(
            force: false,
            context: context,
            progress: changeLoadingProgress,
            noNetwork: forceCheck)
        .then((value) {
      setState(() {
        syllabusData = value;
        isLoading = false;
      });
      changeLoadingProgress(3);
      _bottomNavigationWidgetOptions = <Widget>[
        search(syllabusData: syllabusData),
        timeschedule(
            syllabusData: syllabusData,
            setSyllabus: (value) => setState(() => setSyllabus(value))),
        const SharePage(),
        const SettingPage(),
      ];
    }).catchError((error) {
      // エラーが発生した場合の処理
      missedGetData();
      // エラーメッセージの表示などの処理を追加
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (forceCheck == true) {
      missedGetData();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: _bottomNavigationWidgetOptions != null
              ? _bottomNavigationWidgetOptions?.elementAt(_selectedIndex)
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      Text(_loadingProgress[_loadingNumber]),
                      if (showButton)
                        const Text(
                            "読み込みに時間がかかる場合はインターネット接続が不安定な場合があります。教室情報の更新情報などは取得できませんが、以下ボタンがら時間割をすぐに確認することができます。"),
                      if (showButton)
                        TextButton(
                            onPressed: () {
                              setState(() {
                                forceCheck = true;
                              });
                            },
                            child: const Text("時間割を確認する"))
                    ],
                  ),
                )),
      floatingActionButton: Link(
          uri: Uri.parse('https://issue.kgu-syllabus.com/'),
          target: LinkTarget.blank,
          builder: (BuildContext ctx, FollowLink? openLink) {
            return FloatingActionButton(
              onPressed: openLink,
              child: const Icon(Icons.feedback),
              backgroundColor: const Color(0xffFC7D3C),
            );
          }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.white,
              tabActiveBorder: Border.all(color: Colors.black, width: 0.5),
              color: Colors.grey[600],
              tabs: [
                GButton(
                  key: _key,
                  icon: LineIcons.search,
                  text: 'シラバス検索',
                ),
                GButton(
                  key: _key1,
                  icon: LineIcons.calendar,
                  text: '時間割',
                ),
                GButton(
                  key: _key2,
                  icon: LineIcons.share,
                  text: '共有',
                ),
                GButton(
                  key: _key3,
                  icon: LineIcons.cog,
                  text: '設定',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: _key,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text(
                  "ここを押すと授業の検索ができます。",
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
              align: ContentAlign.top,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text(
                    "ここを押すと時間割を登録できます",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: _key2,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text(
                    "ログインをすると友達と時間割を共有できます",
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
      identify: "Target 3",
      keyTarget: _key3,
      contents: [
        TargetContent(
            align: ContentAlign.top,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "先ほど設定した項目(学部などの情報)はこの設定マークから変更できます。",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ],
            )),
      ],
      shape: ShapeLightFocus.RRect,
      radius: 5,
    ));
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
