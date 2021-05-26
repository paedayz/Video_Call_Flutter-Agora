import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';

// Helper function to get list of native views
List<Widget> _getRenderViews(ClientRole role, List<int> users) {
  final List<StatefulWidget> list = [];
  if (role == ClientRole.Broadcaster) {
    list.add(RtcLocalView.SurfaceView());
  }

  users.forEach(
    (int uid) => list.add(
      RtcRemoteView.SurfaceView(
        uid: uid,
      ),
    ),
  );

  return list;
}

// Video view wrapper
Widget _videoView(view) {
  return Expanded(child: Container(child: view));
}

// Video layout wrapper
Widget _expandedVideoRow(List<Widget> views) {
  final wrappedViews = views.map<Widget>(_videoView).toList();
  return Expanded(
    child: Row(
      children: wrappedViews,
    ),
  );
}

/// Video layout wrapper
Widget viewRows(ClientRole role, List<int> users) {
  final views = _getRenderViews(role, users);
  switch (views.length) {
    case 1:
      return Container(
        child: Column(
          children: [
            _videoView(views[0]),
          ],
        ),
      );
    case 2:
      return Container(
        child: Column(
          children: [
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]]),
          ],
        ),
      );
    case 3:
      return Container(
        child: Column(
          children: [
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ),
      );
    case 4:
      return Container(
        child: Column(
          children: [
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ),
      );
    default:
  }
  return Container();
}
