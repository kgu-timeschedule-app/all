import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_schedule/pages/AddFriend.dart';
import 'package:time_schedule/pages/ColorChoicing.dart';
import 'package:time_schedule/pages/FirebaseAuthJA.dart';
import 'package:time_schedule/pages/NotLoginShare.dart';
import 'package:time_schedule/pages/ProfilteSetting.dart';
import 'package:time_schedule/pages/SettingDetailTimeLine.dart';
import 'package:time_schedule/pages/share.dart';
import 'package:time_schedule/pages/tutorial.dart';

import '../functions/get_info.dart';
import 'firebase_options.dart';
import 'functions/read_local_strage_setting.dart';
import 'pages/top.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
    // Check internet connection with created instance
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    late final SharedPreferences sharedPreferences;
    try {
    // SharedPreferencesの初期化
    await Future.wait([
      Future(() async {
        sharedPreferences = await SharedPreferences.getInstance();
      }),
    ]);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }

    await SentryFlutter.init((options) {
      options.dsn =
          'https://74866e0984cd42f6af22feaef78ee24e@o4504382268178432.ingest.sentry.io/4504389490049024';
      options.tracesSampleRate = 0.5;
    }, appRunner: () => runApp(const MyApp()));
  }, (error, stackTrace) {
    //Flutterでキャッチされなかった例外/エラー
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
  List<AuthProvider> providers;
  providers = [
    GoogleProvider(
      clientId:
          "515864974460-i6rftmbi1jkh7lkjll0ok9lipmrqtnnd.apps.googleusercontent.com",
      redirectUri: 'socialauth://',
    ),
    AppleProvider(),
  ];
  // }

  FirebaseUIAuth.configureProviders(providers);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  Color currentThemeColor = const Color(0xffFC7D3C);

  @override
  void initState() {
    super.initState();
    readLocalstrageSettingString("currentThemeColor").then((value) {
      if (value != "") {
        setState(() {
          currentThemeColor = Color(int.parse(value));
        });
      }
    });
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    Future(() async {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    });
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      addFriendFromLink(context, dynamicLinkData.link.queryParameters['myId']!);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
      ],
      navigatorObservers: [SentryNavigatorObserver()],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
          // useMaterial3: true,
          colorScheme: ColorScheme.light(
              primary: currentThemeColor, background: const Color(0xfff2f2f7)),
          textTheme: TextTheme(
            headline1: GoogleFonts.roboto(
                fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.roboto(
                fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3: GoogleFonts.roboto(
                fontSize: 42, color: Colors.black, fontWeight: FontWeight.w600),
            headline4: GoogleFonts.roboto(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.25),
            headline5:
                GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.roboto(
                fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: 0.15),
            subtitle1: GoogleFonts.roboto(
                fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 0.15),
            subtitle2: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
            bodyText2: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.roboto(
                fontSize: 19,
                color: const Color(0xffD26919),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4),
            overline: GoogleFonts.roboto(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          )),
      home: const MainPage(),
      routes: <String, WidgetBuilder>{
        '/backtomain': (BuildContext context) =>
            const MainPage(showtutorial: true),
        '/nomalmain': (BuildContext context) =>
            const MainPage(showtutorial: false),
        '/tutorial': (BuildContext context) => const Tutorial(),
        '/year': (BuildContext context) => const SettingDetailTimeline(
            subject: ["1年", "2年", "3年", "4年"], title: '学年'),
        '/choose_main': (BuildContext context) => SettingDetailTimeline(
            subject: getAvailableTermAndYearStringList(DateTime.now()),
            title: 'メイン時間割'),
        '/choose_dept': (BuildContext context) =>
            SettingDetailTimeline(subject: getAllDept(), title: '所属学部'),
        '/signin': (BuildContext context) => const NoLoginSharePage(),
        '/share': (BuildContext context) => const SharePage(),
        '/profile': (BuildContext context) => const ProfileSettingPage(),
        '/login': (context) {
          return SignInScreen(
            actions: [
              EmailLinkSignInAction((context) {
                Navigator.pushReplacementNamed(context, '/email-link-sign-in');
              }),
            ],
          );
        },
        '/email-link-sign-in': (context) => EmailLinkSignInScreen(
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  Navigator.pushReplacementNamed(context, '/share');
                }),
              ],
            ),
        '/color-choicing': (context) => const ColorPickerPage(),
        '/verify-email': (context) => EmailVerificationScreen(
              actions: [
                EmailVerifiedAction(() {
                  Navigator.pushReplacementNamed(context, '/profile',
                      arguments: {"isfirst": true});
                }),
                AuthCancelledAction((context) {
                  FirebaseUIAuth.signOut(context: context);
                  Navigator.pushReplacementNamed(context, '/signin');
                }),
              ],
            ),
      },
    );
  }
}
