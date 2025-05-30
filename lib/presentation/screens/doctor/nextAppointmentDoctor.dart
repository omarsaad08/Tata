import 'package:agora_token_service/agora_token_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/logic/video_utils.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/presentation/screens/video/video_call_page.dart';

class NextAppointmentDoctor extends StatefulWidget {
  final Map appointment;
  const NextAppointmentDoctor({super.key, required this.appointment});

  @override
  State<NextAppointmentDoctor> createState() => NextAppointmentDoctorState();
}

class NextAppointmentDoctorState extends State<NextAppointmentDoctor> {
  @override
  Widget build(BuildContext context) {
    print('appointment_data: ${widget.appointment}');
    return Scaffold(
        appBar: AppBar(
            title: Text("الحجز القادم", style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("الدكتور"),
                    Text(widget.appointment['name'] ?? "محمد محمد"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('المكان'),
                    Text(widget.appointment['place'] ?? "اونلاين"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("اليوم"),
                    Text(widget.appointment['date'].split('T')[0]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("التوقيت"),
                    Text(widget.appointment['time']),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("نوع الحجز"),
                    Text(widget.appointment['type'] ?? "كشف"),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: mainElevatedButton("الاتصال", () async {
                        bool isPermissionGranted =
                            await handlePermissionsForCall(context);

                        if (isPermissionGranted) {
                          const appId = "d3cd34df63c14ee0853c1063429148ae";
                          const appCertificate =
                              "701256341e5847a68266d640744dd945";
                          final String channelName =
                              widget.appointment['roomid'];
                          final int uid = (await Auth.getCurrentUser())!['id'];

                          // Generate RTC token
                          final token = RtcTokenBuilder.build(
                            appId: appId.toString(),
                            appCertificate: appCertificate.toString(),
                            channelName: channelName.toString(),
                            uid: uid.toString(),
                            role:
                                RtcRole.publisher, // Use 'subscriber' if needed
                            expireTimestamp:
                                DateTime.now().millisecondsSinceEpoch ~/ 1000 +
                                    3600, // Expires in 1 hour
                          );
                          print(
                              "token: $token, uid: $uid, channel: $channelName");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoCallScreen(
                                  channelName: channelName,
                                  uid: uid,
                                  token: token),
                            ),
                          );
                        } else {
                          print('mic premission failed');

                          Get.snackbar(
                            "Failed",
                            "Microphone Permission Required for Video Call.",
                            backgroundColor: Colors.white,
                            colorText: Color(0xFF1A1E78),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }, color: clr(1)),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: mainElevatedButton("انهاء", () {
                //         Navigator.pushNamed(context, 'finishAppointment',
                //             arguments: widget.appointment);
                //       }, color: clr(2)),
                //     ),
                //   ],
                // ),
                SizedBox(
                  width: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: mainElevatedButton("الغاء", () {}, color: clr(2)),
                    )
                  ],
                )
              ],
            )));
  }
}
