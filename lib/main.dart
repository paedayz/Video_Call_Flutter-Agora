import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_video_call/page/indexPage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

const appId = "6dd9d3a2d571494798400064f6c23e40";
const token =
    "0066dd9d3a2d571494798400064f6c23e40IAA24me2tJffiqW//m0sy6Zjzph6LAD1hNgEObbB5rN6sdzDPrsAAAAAEACAJnsk2A2vYAEAAQDXDa9g";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
