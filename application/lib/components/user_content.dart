import 'package:flutter/material.dart';

import '../models/friends.dart';

class UserContent extends StatelessWidget {
  const UserContent({
    Key? key,
    this.userimage,
    required this.username,
    required this.approveButton,
    required this.userId,
    required this.currentId,
    required this.deleteLists,
    required this.addFriednLists,
    required this.deleteButton,
  }) : super(key: key);

  final String? userimage;
  final String username;
  final bool approveButton;
  final String userId;
  final String currentId;
  final Function deleteLists;
  final Function? addFriednLists;
  final bool deleteButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.brown.shade800,
          backgroundImage: NetworkImage(
            userimage ?? 'https://via.placeholder.com/100',
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 0, deleteButton ? 12 : 0),
          child: Text(username),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            approveButton
                ? ElevatedButton(
                    onPressed: () {
                      FriendService().aproveFriend(currentId, userId);
                      addFriednLists!();
                    },
                    child: const Text("承認",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      backgroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            deleteButton
                ? Padding(
                    padding:
                        EdgeInsets.fromLTRB(approveButton ? 12 : 0, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        FriendService().deleteFriend(currentId, userId);
                        deleteLists();
                      },
                      child: const Text("削除",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.white,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.all(0),
                        side: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        )
      ],
    );
  }
}
