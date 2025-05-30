// import 'dart:async';
// import 'package:tata/logic/video_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:tata/presentation/components/theme.dart';

// class VideoCallScreen extends StatefulWidget {
//   const VideoCallScreen(
//       {super.key,
//       required this.uid,
//       required this.channelName,
//       required this.token});
//   final int uid;
//   final String channelName;
//   final String token;
//   @override
//   State<VideoCallScreen> createState() => _VideoCallScreenState();
// }

// class _VideoCallScreenState extends State<VideoCallScreen> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   Future<void> initAgora() async {
//     await [Permission.microphone, Permission.camera].request();
//     //create the engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(
//       appId: getAgoraAppId(),
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );

//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();
//     await _engine.joinChannel(
//       token: widget.token,
//       channelId: widget.channelName,
//       uid: widget.uid,
//       options: const ChannelMediaOptions(),
//     );
//   }

//   @override
//   void dispose() {
//     _dispose();
//     super.dispose();
//   }

//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }

//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('مكالمة فيديو', style: TextStyle(color: clr(0))),
//         centerTitle: true,
//         backgroundColor: clr(1),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//               decoration:
//                   BoxDecoration(border: Border.all(width: 1, color: clr(1))),
//               child: SizedBox(
//                 width: 100,
//                 height: 150,
//                 child: Center(
//                   child: _localUserJoined
//                       ? AgoraVideoView(
//                           controller: VideoViewController(
//                             rtcEngine: _engine,
//                             canvas: const VideoCanvas(uid: 0),
//                           ),
//                         )
//                       : const CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: widget.channelName),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }

// // /// Your channel ID
// // String get channelId {
// //   // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
// //   return const String.fromEnvironment(
// //     'TEST_CHANNEL_ID',
// //     defaultValue: '<YOUR_CHANNEL_ID>',
// //   );
// // }

// // /// Your int user ID
// // const int uid = 0;

// // /// Your user ID for the screen sharing
// // const int screenSharingUid = 10;

// // /// Your string user ID
// // const String stringUid = '0';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen(
      {super.key,
      required this.uid,
      required this.channelName,
      required this.token});
  final int uid;
  final String channelName;
  final String token;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}