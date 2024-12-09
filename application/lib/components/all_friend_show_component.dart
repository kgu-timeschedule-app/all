import 'package:flutter/material.dart';
import 'package:time_schedule/components/user_content.dart';

import '../components/share_detail.dart';
import 'see_other_timeline.dart';

class AllFriendShowComponent extends StatelessWidget {
  const AllFriendShowComponent({
    Key? key,
    required this.humanlist,
    required this.userId,
    required this.isShowAddButton,
    required this.approveButton,
    required this.setStates,
    required this.setStatesFriend,
    required this.showTimeline,
  }) : super(key: key);

  final List<Map<String, dynamic>> humanlist;
  final Function setStatesFriend;
  final String userId;
  final bool isShowAddButton;
  final bool approveButton;
  final Function setStates;
  final bool showTimeline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, showTimeline ? 0 : 12, 0, 24),
      child: GridView.count(
          crossAxisCount: approveButton ? 2 : 4,
          shrinkWrap: true,
          childAspectRatio: approveButton
              ? 1.2
              : showTimeline
                  ? 1 / 1.2
                  : 1 / 1.5,
          children: List.generate(
            isShowAddButton ? humanlist.length + 1 : humanlist.length,
            (index) {
              if (index == 0 && isShowAddButton) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: '友達を追加する',
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                              context: context,
                              // showModalBottomSheetで表示される中身
                              builder: (context) =>
                                  ShareDetailPage(userId: userId));
                        }),
                    const Text("友達を追加"),
                  ],
                );
              } else if (showTimeline) {
                // ここで、友達のタイムラインを表示する画面になります。
                return ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                          context: context,
                          // showModalBottomSheetで表示される中身
                          builder: (context) => SeeOtherTimeLine(
                              userId:
                                  humanlist[isShowAddButton ? index - 1 : index]
                                      ["id"]));
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        elevation: 0,
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: UserContent(
                          deleteButton: false,
                          username:
                              humanlist[isShowAddButton ? index - 1 : index]
                                  ["name"],
                          userimage:
                              humanlist[isShowAddButton ? index - 1 : index]
                                  ["avater"],
                          approveButton: approveButton,
                          userId: humanlist[isShowAddButton ? index - 1 : index]
                              ["id"],
                          currentId: userId,
                          deleteLists: () {
                            humanlist
                                .removeAt(isShowAddButton ? index - 1 : index);
                            setStates(
                              humanlist,
                            );
                          },
                          addFriednLists: () {
                            setStatesFriend(
                                humanlist[isShowAddButton ? index - 1 : index]);
                            humanlist
                                .removeAt(isShowAddButton ? index - 1 : index);
                            setStates(
                              humanlist,
                            );
                          },
                        )));
              } else {
                return UserContent(
                  deleteButton: true,
                  username: humanlist[isShowAddButton ? index - 1 : index]
                      ["name"],
                  userimage: humanlist[isShowAddButton ? index - 1 : index]
                      ["avater"],
                  approveButton: approveButton,
                  userId: humanlist[isShowAddButton ? index - 1 : index]["id"],
                  currentId: userId,
                  deleteLists: () {
                    humanlist.removeAt(isShowAddButton ? index - 1 : index);
                    setStates(
                      humanlist,
                    );
                  },
                  addFriednLists: () {
                    setStatesFriend(
                        humanlist[isShowAddButton ? index - 1 : index]);
                    humanlist.removeAt(isShowAddButton ? index - 1 : index);
                    setStates(
                      humanlist,
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
