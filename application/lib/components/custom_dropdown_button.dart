import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String> contentList;
  int value;
  final Function(int) onChanged;

  CustomDropDownButton(
      {Key? key,
      required this.contentList,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.contentList[widget.value],
      onChanged: (String? e) {
        setState(() {
          widget.value = widget.contentList.indexOf(e!);
        });
        widget.onChanged(widget.value);
      },
      selectedItemBuilder: (BuildContext context) {
        return widget.contentList.map<Widget>((String item) {
          return Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(minWidth: 100),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              item,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          );
        }).toList();
      },
      items: widget.contentList.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
