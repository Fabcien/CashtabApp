import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CashtabApp());
}

class CashtabApp extends StatelessWidget {
  const CashtabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cashtab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const CashtabHome(title: 'Cashtab', cashtabUrl: "https://cashtab.com"),
    );
  }
}

class CashtabHome extends StatefulWidget {
  const CashtabHome({super.key, required this.title, required this.cashtabUrl,});

  final String title;
  final String cashtabUrl;

  @override
  State<CashtabHome> createState() => _CashtabHomeState();
}

class _CashtabHomeState extends State<CashtabHome> {
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) async {
          if (request.url.startsWith("{widget.cashtabUrl}/")) {
            return NavigationDecision.navigate;
          }
          await launchUrl(Uri.parse(request.url));
          return NavigationDecision.prevent;
        },
      ),
    )
    ..loadRequest(Uri.parse(widget.cashtabUrl));

    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
