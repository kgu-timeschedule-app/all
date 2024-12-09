import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingDetailTimeline extends StatefulWidget {
  final List<String> subject;
  final String title;

  const SettingDetailTimeline(
      {Key? key, required this.subject, required this.title})
      : super(key: key);

  @override
  State<SettingDetailTimeline> createState() => _SettingDetailTimelineState();
}

class _SettingDetailTimelineState extends State<SettingDetailTimeline> {
  List<bool> select = List.generate(70, (i) => false);

  @override
  Widget build(BuildContext context) {
    List arglist = ModalRoute.of(context)?.settings.arguments as List;
    Function setStates = arglist[0];
    int num = arglist[1];
    if (select.every((bool e) => e == false)) {
      select = List.generate(70, (i) => i == num ? true : false);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: Text(widget.title),
                    tiles: <SettingsTile>[
                      for (var i = 0; i < widget.subject.length; i++)
                        if (widget.subject[i] != "すべての部署")
                          SettingsTile.navigation(
                            onPressed: (BuildContext context) {
                              setStates(i);
                              select = List.generate(70, (i) => false);
                              setState(() => {select[i] = true});
                            },
                            title: Text(widget.subject[i]),
                            trailing: select[i]
                                ? const Icon(Icons.check)
                                : const SizedBox.shrink(),
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
