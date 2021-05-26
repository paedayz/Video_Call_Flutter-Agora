import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_video_call/page/callPage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();

  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Index Page'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                        errorText:
                            _validateError ? 'Channel name is mandatory' : null,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Channel name'),
                  ))
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title: Text(ClientRole.Broadcaster.toString()),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(ClientRole.Audience.toString()),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    if (_channelController.text.isNotEmpty) {
      // await for camera and microphone permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);

      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
