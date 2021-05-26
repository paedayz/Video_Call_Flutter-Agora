import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    initForAgora();
  }

  Future<void> initForAgora() async {}

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
    return Container();
  }

  // remote user video
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return Container();
    } else {
      return Text(
        'Please wait remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
