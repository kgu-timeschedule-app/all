import 'package:flutter/material.dart';

import 'detail_test_timeline_list_gen.dart';

class TestinformationDetailTimeline extends StatelessWidget {
  final Map<String, dynamic> data;
  final BuildContext context;
  final bool showname;
  final bool issyllabus;
  List only1list = [];

  TestinformationDetailTimeline(
      {super.key,
      required this.data,
      required this.context,
      required this.showname,
      required this.issyllabus});

  List<DataRow> _buildMakeListDetailTimeline(
      final Map<String, dynamic> data, List only1list, BuildContext context) {
    List<DataRow> list = [];
    // print(data["content"]["test"].length);
    for (var index = 0; index < data["content"]["test"].length; index++) {
      if (data["content"]["test"][index].length == 1) {
        only1list.add(index);
        break;
      } else {
        list.add(detailTestTimeLineList(
            context: context,
            index: index,
            data: data,
            isconpact: !showname,
            issyllabus: issyllabus));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return data["content"] != null &&
            data["content"]["subject"] != "" &&
            data["content"]["test"].length > 0 &&
            data["content"]["test"][0].length > 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                showname
                    ? Text(data["content"]["subject"],
                        textAlign: TextAlign.left,
                        style: issyllabus
                            ? const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)
                            : const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))
                    : const SizedBox.shrink(),
                DataTable(
                  columnSpacing: 4,
                  headingRowHeight: 0,
                  dataRowHeight: showname ? 70 : 70,
                  columns: const [
                    DataColumn(
                      label: Text('テスト情報'),
                    ),
                    DataColumn(
                      label: Text('割合'),
                    ),
                    DataColumn(
                      label: Text('詳細'),
                    ),
                  ],
                  rows: _buildMakeListDetailTimeline(data, only1list, context),
                ),
                ExpansionTile(
                    title: Text('詳細',
                        style: issyllabus
                            ? const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)
                            : const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                            children: only1list
                                .map((e) => Text(data["content"]["test"][e][0]))
                                .toList()),
                      ),
                    ]),
              ])
        : const SizedBox.shrink();
  }
}
