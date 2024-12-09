import 'package:flutter/material.dart';

import '../functions/get_info.dart';

class TextbookinformationDetailTimeline extends StatelessWidget {
  final Map<String, dynamic> data;
  final BuildContext context;
  final String contentSubject;
  List only1list = [];

  TextbookinformationDetailTimeline(
      {super.key,
      required this.data,
      required this.context,
      required this.contentSubject});

  @override
  Widget build(BuildContext context) {
    return data["content"] != null &&
            data["content"][contentSubject] != [] &&
            data["content"][contentSubject] != null
        ? data["content"][contentSubject].length >= 1 &&
                data["content"][contentSubject][0] is List
            ? Padding(
                padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(data["content"]["subject"],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      DataTable(
                          dataRowHeight: 60,
                          columnSpacing: 4,
                          columns: [
                            DataColumn(
                                label: Text(
                                    data["content"][contentSubject][0].length >=
                                            2
                                        ? data["content"][contentSubject][0][0]
                                        : "")),
                            DataColumn(
                              label: Text(
                                  data["content"][contentSubject][0].length >= 2
                                      ? data["content"][contentSubject][0][1]
                                      : ""),
                            ),
                            DataColumn(
                              label: Text(
                                  data["content"][contentSubject][0].length >= 2
                                      ? data["content"][contentSubject][0][2]
                                      : ""),
                            ),
                          ],
                          rows: List.generate(
                              data["content"][contentSubject].length - 1,
                              (index) {
                            if (data["content"][contentSubject][index + 1]
                                is String) {
                              only1list.add(index + 1);
                              return const DataRow(cells: [
                                DataCell(SizedBox.shrink()),
                                DataCell(SizedBox.shrink()),
                                DataCell(SizedBox.shrink()),
                              ]);
                            }
                            // print(data["content"][contentSubject]);
                            return DataRow(cells: <DataCell>[
                              DataCell(SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                      data["content"][contentSubject][index + 1]
                                                  .length >
                                              1
                                          ? becomeSmallname(data["content"]
                                              [contentSubject][index + 1][0])
                                          : "",
                                      softWrap: true,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis))),
                              DataCell(SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                      data["content"][contentSubject][index + 1]
                                                  .length >=
                                              2
                                          ? data["content"][contentSubject]
                                              [index + 1][1]
                                          : "",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis))),
                              DataCell(SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                      data["content"][contentSubject][index + 1]
                                                  .length >=
                                              3
                                          ? data["content"][contentSubject]
                                              [index + 1][2]
                                          : "",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis))),
                            ]);
                          })),
                      Column(
                          children: only1list
                              .map((e) =>
                                  Text(data["content"][contentSubject][e][0]))
                              .toList()),
                    ]),
              )
            : data["content"][contentSubject].length >= 1 &&
                    data["content"][contentSubject][0] is String &&
                    data["content"][contentSubject][0] != ""
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
                    child: Column(
                      children: [
                        Center(
                          child: Text(data["content"]["subject"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        Text(data["content"][contentSubject][0])
                      ],
                    ),
                  )
                : const SizedBox.shrink()
        : const SizedBox.shrink();
  }
}
