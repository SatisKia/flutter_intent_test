import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    String url = 'https://www.google.com/';

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0
      ),
      body: Column( children: [
        SizedBox(
            width: contentWidth,
            height: contentWidth / 8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  final intent = AndroidIntent(
                    action: 'action_view',
                    data: Uri.encodeFull( url ),
                    package: 'com.android.chrome',
                  );
                  try {
                    await intent.launch();
                  } catch(e) {
                    debugPrint('Chromeが無効になっています');
                  }
                },
                child: Text(
                  "package com.android.chrome",
                  style: TextStyle( fontSize: contentWidth / 16 ),
                )
            )
        ),
        SizedBox(
            width: contentWidth,
            height: contentWidth / 8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade300,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  final intent = AndroidIntent(
                    action: 'action_view',
                    data: Uri.encodeFull( 'googlechrome://navigate?url=' + url ),
                  );
                  try {
                    await intent.launch();
                  } catch(e) {
                  }
                },
                child: Text(
                  "intent googlechrome://",
                  style: TextStyle( fontSize: contentWidth / 16 ),
                )
            )
        ),
        SizedBox(
            width: contentWidth,
            height: contentWidth / 8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade200,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  try {
                    await launch('googlechrome://navigate?url=' + url);
                  } catch(e) {
                  }
                },
                child: Text(
                  "url_launcher googlechrome://",
                  style: TextStyle( fontSize: contentWidth / 16 ),
                )
            )
        ),
        SizedBox(
            width: contentWidth,
            height: contentWidth / 8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade100,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  launch( url );
                },
                child: Text(
                  "url_launcher",
                  style: TextStyle( fontSize: contentWidth / 16 ),
                )
            )
        ),
      ] ),
    );
  }
}
