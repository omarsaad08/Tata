import 'package:flutter/material.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class FinishAppointment extends StatefulWidget {
  final Map appointment;
  const FinishAppointment({super.key, required this.appointment});

  @override
  State<FinishAppointment> createState() => _FinishAppointmentState();
}

class _FinishAppointmentState extends State<FinishAppointment> {
  TextEditingController reportController = TextEditingController();
  String? message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('انهاء الجلسة', style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'التقرير'),
                  controller: reportController),
              Row(
                children: [
                  Expanded(
                    child: mainElevatedButton("حفظ", () async {
                      final result = await BookingServices.updateAppointment(
                          widget.appointment['appointment_id'],
                          {'record': reportController.text, 'status': "منتهي"});
                      if (result != 1) {
                        message = 'عذرا يوجد خطأ';
                      } else {
                        Navigator.pushReplacementNamed(context, 'doctorHome');
                      }
                    }),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
