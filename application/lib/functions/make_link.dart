import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<String> createDynamicLink(String myId) {
  // リンクを作成するためのDynamicLinkParametersを作成する
  final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
    // リンク先のURI
    link: Uri.parse('https://share.kgu-syllabus.com/addFriend?myId=$myId'),
    // ショートリンクを生成するための設定
    androidParameters:
        const AndroidParameters(packageName: "io.timeschedule.kgu"),
    iosParameters: const IOSParameters(
      bundleId: "io.timeschedule.kgu",
    ),
    // iOS用の設定
    // Firebaseプロジェクトのサブドメイン
    uriPrefix: 'https://share.kgu-syllabus.com',
  );
  // ショートリンクを生成する
  return FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams).then((e) {
    return e.toString();
  }).catchError((error) {
    // print(error);
    return "";
  });
}
