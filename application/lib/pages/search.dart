import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:line_icons/line_icons.dart';
import 'package:time_schedule/functions/search_subject.dart';
import 'package:time_schedule/pages/searchWebView.dart';
import 'package:time_schedule/pages/searchWebView_outdated.dart';

import '../components/choice_category_dialog.dart';
import '../functions/get_info.dart';
import '../functions/read_local_strage_setting.dart';

class search extends StatefulWidget {
  final Map<String, dynamic> syllabusData;

  const search({Key? key, required this.syllabusData}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  String id = "";
  bool isSearching = false;
  List<Object?> result = [];
  late Fuzzy fuse;
  String searchtextinput = "";
  int school = 0;
  int season = 0;
  int date = 0;
  int dept = 0;
  int howto = 0;
  ConnectivityResult? _connectivityResult;
  bool speed_result = true;

  static final AdRequest request = AdRequest();

  final BannerAd myBanner = Platform.isAndroid
      ? BannerAd(
          adUnitId: 'ca-app-pub-7942690227296112/4076218405',
          size: AdSize.mediumRectangle,
          request: request,
          listener: const BannerAdListener(),
        )
      : BannerAd(
          adUnitId: 'ca-app-pub-7942690227296112/8520297238',
          size: AdSize.mediumRectangle,
          request: request,
          listener: const BannerAdListener(),
        );

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => debugPrint('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
  );

  @override
  void initState() {
    myBanner.load();
    readLocalstrageSettingInt("setting_dept").then((value) {
      setState(() {
        dept = value;
      });
    });
    Connectivity().checkConnectivity().then((value) {
      setState(() {
        _connectivityResult = value;
      });
    });
    setState(() {
      speed_result = true;
    });
    super.initState();
  }

  @override
  dispose() {
    // subscription.cancel();
    super.dispose();
  }

  void serchFromSyllabus({required String value}) {
    setState(() {
      id = "";
      isSearching = true;
    });
    compute(serchSyllabus, {
      "keyword": value,
      "data": widget.syllabusData["data"],
      "school": school,
      "season": season,
      "date": date,
      "dept": dept,
      "howto": howto,
    }).then((output) {
      setState(() {
        result = output;
        isSearching = false;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 56, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  id != ""
                      ? IconButton(
                          onPressed: () => {
                            setState(() {
                              id = "";
                            })
                          },
                          icon: const Icon(LineIcons.undo),
                          color: Colors.grey[500],
                          iconSize: 24,
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: Padding(
                      padding: id != ""
                          ? const EdgeInsets.fromLTRB(0, 0, 0, 4)
                          : const EdgeInsets.fromLTRB(20, 0, 20, 4),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          serchFromSyllabus(value: value);
                        },
                        onChanged: (value) {
                          setState(() {
                            searchtextinput = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '検索',
                          // fillColor: Colors.green[100],
                          filled: true,
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(24, 0, 0, 0),
                          suffixIcon: IconButton(
                              onPressed: () => {
                                    setState(() {
                                      serchFromSyllabus(value: searchtextinput);
                                    })
                                  },
                              icon: const Icon(Icons.search)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 30, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        children: [
                          Text(
                              school == 0
                                  ? "すべてのキャンパス"
                                  : getCampas(keyword: school),
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          const Text(" / ",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          Text(
                              season == 0
                                  ? "すべての学期"
                                  : getTermData(keyword: season),
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          const Text(" / ",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          Text(date == 0 ? "すべての曜日" : getDay(keyword: date),
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          const Text(" / ",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          Text(
                              dept == 0
                                  ? "すべての部署"
                                  : getDepartment(keyword: dept),
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          Text(
                              howto == 0
                                  ? "すべての履修方法"
                                  : getHowto(keyword: howto),
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) {
                              return ChoiceCategoryPage(
                                school: school,
                                season: season,
                                date: date,
                                dept: dept,
                                howto: howto,
                                onChangedCampas: (e) {
                                  setState(() {
                                    school = e;
                                  });
                                },
                                onChangedHowto: (e) {
                                  setState(() {
                                    howto = e;
                                  });
                                },
                                onChangedDate: (e) {
                                  setState(() {
                                    date = e;
                                  });
                                },
                                onChangedSeason: (e) {
                                  setState(() {
                                    season = e;
                                  });
                                },
                                onChangedDept: (e) {
                                  setState(() {
                                    dept = e;
                                  });
                                },
                              );
                            });
                      },
                      child: const Text('カテゴリ変更',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        id == ""
            ? isSearching
                ? const SpinKitWave(
                    color: Colors.green,
                    size: 50.0,
                  )
                : Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemCount: result.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (result.isEmpty) {
                            return const Spacer();
                          }
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: ListTile(
                              dense: true,
                              tileColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                                side: BorderSide(
                                  color: Color(0xF1F1F1FF),
                                  width: 0.5,
                                ),
                              ),
                              onTap: () => setState(
                                  () => id = (result[index] as Map)["id"]),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      (result[index] as Map)["name"]
                                              .split("／")
                                              .isEmpty
                                          ? (result[index] as Map)["name"]
                                          : (result[index] as Map)["name"]
                                              .split("／")[0],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(
                                      getDepartment(
                                              keyword: (result[index]
                                                      as Map)["管理部署"] +
                                                  1) +
                                          " " +
                                          getTermData(
                                              keyword: (result[index]
                                                      as Map)["開講期"] +
                                                  1) +
                                          " " +
                                          getDateString(list: result[index])
                                              .join('/') +
                                          " " +
                                          (result[index] as Map)["単位数"]
                                              .toString() +
                                          "単位" +
                                          " " +
                                          (result[index] as Map)["担当者"],
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400]))
                                ],
                              ),
                              trailing: const Icon(LineIcons.angleRight),
                            ),
                          );
                        }),
                  )
            : _connectivityResult == ConnectivityResult.none ||
                    speed_result == false
                ? searchWebViewOlder(id: id, syllabusData: widget.syllabusData)
                : searchWebView(id: id),
        result.length < 1
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: Container(
                  alignment: Alignment.center,
                  width: myBanner.size.width.toDouble(),
                  height: myBanner.size.height.toDouble(),
                  child: AdWidget(ad: myBanner),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
