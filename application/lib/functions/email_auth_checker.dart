// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:time_schedule/functions/read_local_strage_setting.dart';
//
// Future<UserCredential?> email_auth(String emailLink) async {
//   if (FirebaseAuth.instance.isSignInWithEmailLink(emailLink)) {
//     try {
//       final email = await readLocalstrageSettingString('email');
//       // The client SDK will parse the code from the link for you.
//       final userCredential = await FirebaseAuth.instance
//           .signInWithEmailLink(email: email, emailLink: emailLink);
//
//       return userCredential;
//     } catch (error) {
//       print('Error signing in with email link.');
//       return null;
//     }
//   }
//   return null;
// }
