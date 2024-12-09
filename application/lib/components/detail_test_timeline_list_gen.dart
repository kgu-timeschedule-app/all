import 'package:flutter/material.dart';

import '../functions/get_info.dart';

DataRow detailTestTimeLineList(
    {required context,
    required index,
    required data,
    required isconpact,
    required issyllabus}) {
  return DataRow(cells: <DataCell>[
    DataCell(SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Text(
            data["content"]["test"][index].length > 1
                ? becomeSmallname(data["content"]["test"][index][0])
                : "",
            softWrap: true,
            overflow: TextOverflow.visible,
            style: issyllabus
                ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                : const TextStyle()))),
    DataCell(SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        child: Text(data["content"]["test"][index].length >= 2
            ? data["content"]["test"][index][1]
            : ""))),
    DataCell(SizedBox(
        width: isconpact
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width * 0.6,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Text(
              data["content"]["test"][index].length >= 3
                  ? data["content"]["test"][index][2]
                  : "",
              style: issyllabus
                  ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                  : const TextStyle(),
              textScaleFactor: 1.0,
              overflow: TextOverflow.visible),
        )))),
  ]);
}
