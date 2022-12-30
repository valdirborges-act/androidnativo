import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class PageWebView extends StatefulWidget {
  const PageWebView({super.key});

  @override
  State<PageWebView> createState() => PageWebViewState();
}

class PageWebViewState extends State<PageWebView> {
  late WebViewPlusController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: WebViewPlus(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://dapper-centaur-45083b.netlify.app/',
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          javascriptChannels: {
            JavascriptChannel(
              name: 'JavascriptChannel',
              onMessageReceived: (message) async {
                print('Javascript: "${message.message}"');
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(
                      message.message,
                      style: TextStyle(fontSize: 20),
                    ),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );

                controller.webViewController.evaluateJavascript('ok()');
              },
            ),
          },
        ),
      ),
    );
  }
}
