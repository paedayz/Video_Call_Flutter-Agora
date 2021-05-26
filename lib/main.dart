import 'package:agora_rtc_engine/rtc_engine.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _remoteUid;
  RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initForAgora();
  }

  Future<void> initForAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    // create the engine
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));

    await _engine.enableVideo();

    _engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print("local user $uid joined");
    }, userJoined: (int uid, int elapsed) {
      print("remote user $uid joined");
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print("remote user $uid left channel");
      setState(() {
        _remoteUid = null;
      });
    }));

    await _engine.joinChannel(token, 'firstchannel', null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 100,
              child: Center(
                child: _renderLocalPreview(),
              ),
            ),
          )
        ],
      ),
    );
  }

  // current user video
  Widget _renderLocalPreview() {
    return RtcLocalView.SurfaceView();
  }

  // remote user video
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
      );
    } else {
      return Text(
        'Please wait remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
