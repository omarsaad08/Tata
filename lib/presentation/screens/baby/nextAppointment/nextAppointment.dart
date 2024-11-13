import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tata/logic/video_utils.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/presentation/screens/video/video_call_page.dart';

class NextAppointment extends StatefulWidget {
  final Map appointment;
  NextAppointment({super.key, required this.appointment});

  @override
  State<NextAppointment> createState() => NextAppointmentState();
}

class NextAppointmentState extends State<NextAppointment> {
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
                    Text(widget.appointment['name'] != null
                        ? widget.appointment['name']
                        : "محمد محمد"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('المكان'),
                    Text(widget.appointment['place'] != null
                        ? widget.appointment['place']
                        : "اونلاين"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("اليوم"),
                    Text(widget.appointment['appointment_date'].split('T')[0]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("التوقيت"),
                    Text(widget.appointment['appointment_time']),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("نوع الحجز"),
                    Text(widget.appointment['type'] != null
                        ? widget.appointment['type']
                        : "كشف"),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: mainElevatedButton("الاتصال", () async {
                        bool isPermissionGranted =
                            await handlePermissionsForCall(context);

                        if (isPermissionGranted) {
                          final dio = Dio();
                          final response = await dio.get(
                              'http://192.168.1.219:3000/appointments/token',
                              data: {
                                "uid": widget.appointment['baby_id'],
                                "channelName": widget.appointment['roomid']
                              });
                          final token = response.data['token'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoCallScreen(
                                  channelName: widget.appointment['roomid'],
                                  uid: widget.appointment['baby_id'],
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
                Row(
                  children: [
                    Expanded(
                      child: mainElevatedButton("انهاء", () {
                        Navigator.pushNamed(context, 'finishAppointment',
                            arguments: widget.appointment);
                      }, color: clr(5)),
                    ),
                  ],
                ),
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
