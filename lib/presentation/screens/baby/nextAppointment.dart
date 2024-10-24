import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class NextAppointment extends StatefulWidget {
  final Map appointment;
  NextAppointment({super.key, required this.appointment});

  @override
  State<NextAppointment> createState() => NextAppointmentState();
}

class NextAppointmentState extends State<NextAppointment> {
  @override
  Widget build(BuildContext context) {
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
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCall()));
                      }, color: clr(1)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: mainElevatedButton("انهاء", () {}, color: clr(5)),
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