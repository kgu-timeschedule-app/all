import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'メールアドレス';

  @override
  String get passwordInputLabel => 'パスワード';

  @override
  String get signInActionText => 'サインイン';

  @override
  String get registerActionText => '登録';

  @override
  String get linkEmailButtonText => 'メールアドレスをリンク';

  @override
  String get signInWithPhoneButtonText => '電話番号でサインイン';

  @override
  String get phoneVerificationViewTitleText => '電話番号認証';

  @override
  String get signInText => 'SNSアカウントでログイン';

  @override
  String get registerText => 'アカウント登録';

  @override
  String get emailLinkSignInButtonLabel => 'メールにログインリンクが送信されます';

  @override
  String get signInWithEmailLinkViewTitleText => 'メールに送付されるリンクでログイン';

  @override
  String get sendLinkButtonLabel => 'メールにログインリンクを送信';

  @override
  String get credentialAlreadyInUseErrorText => 'すでに使われています';

  @override
  String get isNotAValidEmailErrorText => 'メールアドレスが間違っています';
}
