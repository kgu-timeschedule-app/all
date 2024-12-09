import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeTimelineCellValue extends StatefulWidget {
  final String defaultValue;
  final String title;
  final Function(String) onChanged;
  final bool? isInt;

  const ChangeTimelineCellValue({
    Key? key,
    required this.defaultValue,
    required this.title,
    required this.onChanged,
    this.isInt,
  }) : super(key: key);

  @override
  State<ChangeTimelineCellValue> createState() =>
      _ChangeTimelineCellValueState();
}

class _ChangeTimelineCellValueState extends State<ChangeTimelineCellValue> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(widget.title),
        SizedBox(
          width: 250.0,
          height: 100.0,
          child: TextFormField(
            maxLines: 3,
            onChanged: widget.onChanged,
            initialValue: widget.defaultValue,
            style: const TextStyle(fontSize: 12.0),
            decoration: const InputDecoration(border: OutlineInputBorder()),
            keyboardType: widget.isInt != null
                ? TextInputType.number
                : TextInputType.text,
            inputFormatters: widget.isInt != null
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
          ),
        ),
      ],
    );
  }
}
