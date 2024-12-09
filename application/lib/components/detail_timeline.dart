import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:time_schedule/models/TimeScheduleModel.dart';

import '../functions/read_local_strage_setting.dart';
import 'test_information_detail_timeline.dart';
import 'textbook_information_detail_timeline.dart';

class DetailTimeline extends StatefulWidget {
  final List<TimeScheduleModel> timeSchedule;

  const DetailTimeline({Key? key, required this.timeSchedule})
      : super(key: key);

  @override
  State<DetailTimeline> createState() => _DetailTimelineState();
}

class _DetailTimelineState extends State<DetailTimeline> {
  int credit = 0;

  int nullPass(int? value) {
    if (value == null) {
      return 0;
    } else {
      return value;
    }
  }

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
    if (widget.timeSchedule
            .map((e) => nullPass(e.content?.credit))
            .reduce((value, element) => value + element) >=
        4) {
      readLocalstrageSettingBool("setting_app_review").then((value) {
        if (value) {
          final InAppReview inAppReview = InAppReview.instance;
          inAppReview.requestReview();
          setLocalstrageSettingBool(false, "setting_app_review");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 6, 12, 0),
                      child: Text("総単位数", style: TextStyle(fontSize: 12)),
                    ),
                    Text(
                        widget.timeSchedule
                            .map((e) => nullPass(e.content?.credit))
                            .reduce((value, element) => value + element)
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 6, 12, 0),
                      child: Text("定期テスト数", style: TextStyle(fontSize: 12)),
                    ),
                    Text(
                        widget.timeSchedule
                            .map((e) {
                              List<int>? tmp = e.content?.test!
                                  .map((y) => y.isNotEmpty &&
                                          y[0] == "定期試験／Final Examination (01)"
                                      ? 1
                                      : 0)
                                  .toList();

                              return tmp != null && tmp.isNotEmpty
                                  ? tmp.reduce((a, b) => a + b)
                                  : 0;
                            })
                            .toList()
                            .reduce((a, b) => a + b)
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ],
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(24, 0, 12, 12),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Padding(
          //             padding: EdgeInsets.fromLTRB(0, 6, 12, 0),
          //             child: Text("上ヶ原", style: TextStyle(fontSize: 12)),
          //           ),
          //           Text(
          //               widget.timeSchedule
          //                   .map((e) => e.content?.dept == "0" ? 1 : 0)
          //                   .reduce((value, element) => value + element)
          //                   .toString(),
          //               style: const TextStyle(
          //                   fontWeight: FontWeight.bold, fontSize: 24)),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Padding(
          //             padding: EdgeInsets.fromLTRB(0, 6, 12, 0),
          //             child: Text("三田", style: TextStyle(fontSize: 12)),
          //           ),
          //           Text(
          //               widget.timeSchedule
          //                   .map((e) => e.content?.dept == "1" ? 1 : 0)
          //                   .reduce((value, element) => value + element)
          //                   .toString(),
          //               style: const TextStyle(
          //                   fontWeight: FontWeight.bold, fontSize: 24)),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Padding(
          //             padding: EdgeInsets.fromLTRB(0, 6, 12, 0),
          //             child: Text("聖和", style: TextStyle(fontSize: 12)),
          //           ),
          //           Text(
          //               widget.timeSchedule
          //                   .map((e) => e.content?.dept == "2" ? 1 : 0)
          //                   .reduce((value, element) => value + element)
          //                   .toString(),
          //               style: const TextStyle(
          //                   fontWeight: FontWeight.bold, fontSize: 24)),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.timeSchedule.length, (index) {
                return TestinformationDetailTimeline(
                    data: widget.timeSchedule[index].toMap(),
                    context: context,
                    issyllabus: false,
                    showname: true);
              })),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
              child: Text("教科書一覧",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xffFC7D3C),
                      letterSpacing: 6.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 24))),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.timeSchedule.length, (index) {
                return TextbookinformationDetailTimeline(
                    data: widget.timeSchedule[index].toMap(),
                    context: context,
                    contentSubject: "textbook");
              })),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Text("参考書一覧",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color(0xffFC7D3C),
                    letterSpacing: 6.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.timeSchedule.length, (index) {
                return TextbookinformationDetailTimeline(
                    data: widget.timeSchedule[index].toMap(),
                    context: context,
                    contentSubject: "referencebook");
              })),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
            child: Container(
              alignment: Alignment.center,
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
              child: AdWidget(ad: myBanner),
            ),
          )
        ],
      ),
    );
  }
}
