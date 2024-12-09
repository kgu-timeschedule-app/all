import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/webview_flutter.dart';

String alphanumericToHalfLength(String runes) {
  final regex = RegExp(r'^[Ａ-Ｚａ-ｚ０-９]+$');
  final string = runes.runes.toList().map<String>((rune) {
    final char = String.fromCharCode(rune);
    return regex.hasMatch(char) ? String.fromCharCode(rune - 65248) : char;
  });
  return string.join();
}

class searchWebView extends StatefulWidget {
  final String id;

  const searchWebView({Key? key, required this.id}) : super(key: key);

  @override
  State<searchWebView> createState() => _searchWebViewState();
}

class _searchWebViewState extends State<searchWebView> {
  Map<String, dynamic> subjectData = {};
  bool _isLoading = true;
  late final WebViewController controller;

  static final AdRequest request = AdRequest();

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-7942690227296112/4076218405',
    size: AdSize.banner,
    request: request,
    listener: const BannerAdListener(),
  );

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => debugPrint('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
    _isLoading = true;
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (_) {
        setState(() {
          _isLoading = false;
        });
      }))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://subject.kgu-syllabus.com/' + widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: controller),
                _isLoading
                    ? const SpinKitWave(
                        color: Colors.green,
                        size: 50.0,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: myBanner.size.width.toDouble(),
            height: myBanner.size.height.toDouble(),
            child: AdWidget(ad: myBanner),
          )
        ],
      ),
    );
  }
}
