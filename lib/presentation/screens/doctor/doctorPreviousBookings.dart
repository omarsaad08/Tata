import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorPreviousBookings extends StatefulWidget {
  const DoctorPreviousBookings({super.key});

  @override
  State<DoctorPreviousBookings> createState() => DoctorPreviousBookingsState();
}

class DoctorPreviousBookingsState extends State<DoctorPreviousBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("الحجوزات السابقة", style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)));
  }
}
