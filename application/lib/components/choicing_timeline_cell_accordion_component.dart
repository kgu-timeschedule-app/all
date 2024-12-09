import 'package:flutter/material.dart';

class ChocingTimelineCellAccordion extends StatefulWidget {
  final List<Map<dynamic, dynamic>> rows;
  int checked;
  final Function setStatesInChocing;

  ChocingTimelineCellAccordion(
      {Key? key,
      required this.checked,
      required this.rows,
      required this.setStatesInChocing})
      : super(key: key);

  @override
  State<ChocingTimelineCellAccordion> createState() =>
      _ChocingTimelineCellAccordionState();
}

class _ChocingTimelineCellAccordionState
    extends State<ChocingTimelineCellAccordion> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      showCheckboxColumn: true,
      checkboxHorizontalMargin: 1,
      dataRowHeight: 80,
      columnSpacing: 0,
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                '科目',
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              '曜日',
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              '評価方法',
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              '単位',
            ),
          ),
        ),
      ],
      rows: widget.rows
          .map(
            (e) => DataRow(
                selected: e["id"] == widget.checked,
                onSelectChanged: (bool? selected) {
                  widget.setStatesInChocing(e["id"]);
                },
                cells: [
                  DataCell(
                    Text('${e['subject']}'),
                  ),
                  // DataCell(
                  //   Text('${e['teacher']}'),
                  // ),
                  DataCell(
                    Text('${e['date']}'),
                  ),
                  DataCell(
                    Text('${e['evaluate']}'),
                  ),
                  DataCell(
                    Center(child: Text('${e['credit']}')),
                  )
                ]),
          )
          .toList(),
    );
  }
}
