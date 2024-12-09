import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class NoLoginSharePage extends StatefulWidget {
  const NoLoginSharePage({Key? key}) : super(key: key);

  @override
  State<NoLoginSharePage> createState() => _NoLoginSharePageState();
}

class _NoLoginSharePageState extends State<NoLoginSharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: SignInScreen(actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          // if (!state.user!.emailVerified) {
          //   Navigator.pushNamed(context, '/verify-email');
          // } else {
          Navigator.pushReplacementNamed(context, '/profile',
              arguments: {"isfirst": true});
          // }
        }),
        AuthCancelledAction((context) {
          FirebaseUIAuth.signOut(context: context);
          Navigator.pushReplacementNamed(context, '/signin');
        }),
      ]),
    );
  }
}
