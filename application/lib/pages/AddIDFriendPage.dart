import 'package:flutter/material.dart';
import 'package:time_schedule/models/friends.dart';

class AddIdFriend extends StatefulWidget {
  const AddIdFriend({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<AddIdFriend> createState() => _AddIdFriendState();
}

class _AddIdFriendState extends State<AddIdFriend> {
  final _friendIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text("友達のIDを入力してください"),
          TextField(
            controller: _friendIdController,
            decoration: const InputDecoration(
              hintText: '友達のID',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // 送信処理をここに書きます
              // print(widget.userId);
              FriendService()
                  .addFriend(widget.userId, _friendIdController.text)
                  .then((value) => Navigator.of(context).pop());
            },
            child: const Text('追加する'),
          ),
        ],
      ),
    );
  }
}
