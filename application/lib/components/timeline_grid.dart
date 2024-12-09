import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:time_schedule/models/TimeScheduleModel.dart';

import '../components/timeline_concentrate_component.dart';
import '../functions/get_info.dart';
import '../functions/read_local_strage_setting.dart';
import 'timeline_cell_component.dart';
import 'timeline_none_cell_component.dart';

class TimelineGrid extends StatefulWidget {
  final int termIndex;
  final int yearValue;
  final Function? setStates;
  final int owndept;
  final int showSuterday;
  final bool showtime;
  List<TimeScheduleModel> timeSchedule = [];
  Map<String, dynamic>? syllabusFilterData;

  TimelineGrid(
      {Key? key,
      required this.showtime,
      required this.termIndex,
      required this.yearValue,
      required this.timeSchedule,
      required this.setStates,
      required this.owndept,
      required this.showSuterday,
      required this.syllabusFilterData})
      : super(key: key);

  @override
  State<TimelineGrid> createState() => _TimelineGridState();
}

class _TimelineGridState extends State<TimelineGrid> {
  Color currentBackgroundColor = const Color(0xffdcffd9);
  Color currentBorderColor = Colors.green;

  static const AdRequest request = AdRequest();
  bool isModalVisible = false;

  final BannerAd myBanner = Platform.isAndroid
      ? BannerAd(
          adUnitId: 'ca-app-pub-7942690227296112/4076218405',
          size: AdSize.banner,
          request: request,
          listener: const BannerAdListener(),
        )
      : BannerAd(
          adUnitId: 'ca-app-pub-7942690227296112/8520297238',
          size: AdSize.banner,
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
    readLocalstrageSettingString("currentBackgroundCellColor").then((value) {
      if (value != "") {
        setState(() {
          currentBackgroundColor = Color(int.parse(value));
        });
      }
    });
    readLocalstrageSettingString("currentBorderCellColor").then((value) {
      if (value != "") {
        setState(() {
          currentBorderColor = Color(int.parse(value));
        });
      }
      ;
    });
    super.initState();
  }

  List<Widget> inschedule(int content) {
    List<String> dayOfWeek = ["月", "火", "水", "木", "金", "土"];
    var index = 0;
    var result = <Widget>[];
    final startTime = getLessonStarttime(i: widget.owndept);
    final endTime = getLessonEndtime(i: widget.owndept);
    while (index < content) {
      if (index == 0) {
        result.add(const StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Center(child: (Text((""))))));
      } else if (widget.showSuterday == 0 ? index % 7 != 6 : true) {
        if (index % 7 == 0) {
          result.add(StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: widget.showSuterday == 0 ? 5 : 6,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.showtime
                      ? FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(startTime[(index ~/ 7) - 1]))
                      : Container(),
                  Text((index ~/ 7).toString()),
                  widget.showtime
                      ? FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(endTime[(index ~/ 7) - 1]))
                      : Container(),
                ],
              ))));
        } else if (widget.showSuterday == 0 ? index < 6 : index < 7) {
          result.add(StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: Center(child: (Text((dayOfWeek[index - 1]))))));
        } else if (widget.timeSchedule == [] ||
            widget.timeSchedule[index - 7].content == null ||
            widget.timeSchedule[index - 7].content!.subject == "") {
          result.add(TimelineNoneCellComponent(
              timeSchedule: widget.timeSchedule,
              syllabusData: widget.syllabusFilterData,
              index: index,
              setStates: widget.setStates,
              showSuterday: widget.showSuterday,
              termIndex: widget.termIndex,
              owndept: widget.owndept,
              yearValue: widget.yearValue));
        } else {
          result.add(TimelineCellComponent(
              owndept: widget.owndept,
              timeSchedule: widget.timeSchedule,
              syllabusData: widget.syllabusFilterData,
              index: index,
              showSuterday: widget.showSuterday,
              setStates: widget.setStates,
              termIndex: widget.termIndex,
              yearValue: widget.yearValue,
              currentBackgroundColor: currentBackgroundColor,
              currentBorderColor: currentBorderColor));
        }
      }
      index += 1;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 4, 0),
          child: StaggeredGrid.count(
              crossAxisCount: widget.showSuterday == 0 ? 22 : 26,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: inschedule(widget.timeSchedule.isEmpty ? 0 : 42)),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 24, 0, 16),
          child: Text("集中科目 / オンデマンド科目"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: StaggeredGrid.count(
            crossAxisCount: 20,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: timelineConcentrateComponent(
                widget.timeSchedule,
                widget.syllabusFilterData,
                widget.setStates,
                widget.termIndex,
                widget.yearValue,
                widget.owndept,
                currentBackgroundColor,
                currentBorderColor,
                context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Container(
            alignment: Alignment.center,
            width: myBanner.size.width.toDouble(),
            height: myBanner.size.height.toDouble(),
            child: AdWidget(ad: myBanner),
          ),
        ),
      ],
    );
  }
}
