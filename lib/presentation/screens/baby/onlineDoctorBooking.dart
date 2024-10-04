import 'package:flutter/material.dart';

class OnlineDoctorBooking extends StatefulWidget {
  const OnlineDoctorBooking({super.key});

  @override
  State<OnlineDoctorBooking> createState() => _OnlineDoctorBookingState();
}

class _OnlineDoctorBookingState extends State<OnlineDoctorBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("حجز دكتور اونلاين"),
          centerTitle: true,
        ),
        body: Column());
  }
}
