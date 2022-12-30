import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'aes.dart';
import 'rsa.dart';
import 'apresentacao/pagecrypto.dart';
import 'webview/pagewebview.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/pagewebview': (_) => PageWebView(),
        '/pagecrypto': (_) => PageCrypto(),
        AESView.routeName: (context) => AESView(),
        RSAView.routeName: (context) => RSAView(),
        '/': (_) => MyHomePage(title: 'Flutter Demo Home Page')
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incrementer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          // Positioned(
          //   left: 30,
          //   bottom: 20,
          //   child: FloatingActionButton(
          //     heroTag: 'back',
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: const Icon(
          //       Icons.arrow_left,
          //       size: 40,
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              //heroTag: 'next',
              onPressed: _incrementCounter,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
          // Add more floating buttons if you want
          // There is no limit
        ],
      ),

    );
  }
}




