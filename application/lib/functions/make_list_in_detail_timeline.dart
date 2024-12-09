import 'package:flutter/material.dart';

import '../components/detail_test_timeline_list_gen.dart';

List<DataRow> buildMakeListDetailTimeline(int index,
    final Map<String, dynamic> data, List only1list, BuildContext context) {
  List<DataRow> list = [];
  for (var index = 0; index < data["content"]["test"].length; index++) {
    if (data["content"]["test"][index].length == 1) {
      only1list.add(index);
      break;
    } else {
      list.add(detailTestTimeLineList(
          context: context,
          index: index,
          data: data,
          isconpact: false,
          issyllabus: false));
    }
  }
  return list;
}
