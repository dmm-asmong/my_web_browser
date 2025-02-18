import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나만의 웹브라우저'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<String>(
            onSelected: (value){
                _webViewController.loadUrl(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                  value: 'https://www.google.com',
                  child: Text('구글')),
              const PopupMenuItem<String>(
                  value: 'https://www.naver.com',
                  child: Text('네이버')),
              const PopupMenuItem<String>(
                  value: 'https://www.kakao.com',
                  child: Text('카카오')),
            ],
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (await _webViewController.canGoBack()) {
            await _webViewController.goBack();
            return;
          }
          if (didPop) {
            return;
          }
        },
        child: WebView(
          initialUrl: 'https://flutter.dev',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
        ),
      ),
    );
  }
}
