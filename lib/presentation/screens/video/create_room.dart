// import 'package:tata/logic/video_utils.dart';
// import 'package:tata/presentation/screens/video/video_call_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CreateRoomDialog extends StatefulWidget {
//   @override
//   _CreateRoomDialogState createState() => _CreateRoomDialogState();
// }

// class _CreateRoomDialogState extends State<CreateRoomDialog> {
//   String roomId = "";
//   @override
//   void initState() {
//     roomId = generateRandomString(8);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       title: Text("Room Created"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             'assets/room_created_vector.png',
//           ),
//           Text(
//             "Room id : " + roomId,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton.icon(
//                 icon: Icon(Icons.share, color: Colors.white),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6)),
//                   backgroundColor: const Color(0xFF1A1E78),
//                 ),
//                 onPressed: () {
//                   shareToApps(roomId);
//                 },
//                 label: Text(
//                   "Share",
//                 ),
//               ),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.arrow_forward, color: Colors.white),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6)),
//                   backgroundColor: const Color(0xFF1A1E78),
//                 ),
//                 onPressed: () async {
//                   bool isPermissionGranted =
//                       await handlePermissionsForCall(context);

//                   if (isPermissionGranted) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => VideoCallScreen(
//                           channelName: roomId,
//                         ),
//                       ),
//                     );
//                   } else {
//                     print('mic premission failed');

//                     Get.snackbar(
//                       "Failed",
//                       "Microphone Permission Required for Video Call.",
//                       backgroundColor: Colors.white,
//                       colorText: Color(0xFF1A1E78),
//                       snackPosition: SnackPosition.BOTTOM,
//                     );
//                   }
//                 },
//                 label: Text(
//                   "Join",
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
