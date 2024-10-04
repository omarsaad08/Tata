import 'package:flutter/material.dart';

class OfflineDoctorBooking extends StatefulWidget {
  const OfflineDoctorBooking({super.key});

  @override
  State<OfflineDoctorBooking> createState() => _OfflineDoctorBookingState();
}

class _OfflineDoctorBookingState extends State<OfflineDoctorBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("حجز دكتور"),
          centerTitle: true,
        ),
        body: Column());
  }
}
