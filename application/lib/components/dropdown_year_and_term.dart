import 'package:flutter/material.dart';

class DropdownYearandTerm extends StatefulWidget {
  final List<String> termList;
  final List<int> yearList;
  int termIndex;
  int yearValue;
  final Function onChange;

  DropdownYearandTerm(
      {Key? key,
      required this.termList,
      required this.yearList,
      required this.termIndex,
      required this.yearValue,
      required this.onChange})
      : super(key: key);

  @override
  State<DropdownYearandTerm> createState() => _DropdownYearandTermState();
}

class _DropdownYearandTermState extends State<DropdownYearandTerm> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: widget.yearValue.toString(),
          icon: const Icon(Icons.expand_more_outlined),
          elevation: 16,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          underline: Container(
            height: 2,
            color: Colors.white,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            widget.onChange(null, int.parse(value!));
          },
          items: widget.yearList.map((value) {
            return DropdownMenuItem<String>(
              value: value.toString(),
              child: Text(value.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black)),
            );
          }).toList(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
          child: Text("年度",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        DropdownButton<String>(
          value: widget.termList[widget.termIndex],
          icon: const Icon(Icons.expand_more_outlined),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          elevation: 16,
          underline: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            widget.onChange(widget.termList.indexOf(value!), null);
            widget.termIndex = widget.termList.indexOf(value);
            // setState(() {
            //   widget.termIndex = widget.termList.indexOf(value!);
            //   widget.onChange(widget.termList.indexOf(value), null);
            // });
          },
          items: widget.termList.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value == "spring" ? "春学期" : "秋学期"),
            );
          }).toList(),
        )
      ],
    );
  }
}
