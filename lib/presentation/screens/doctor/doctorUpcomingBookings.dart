import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorUpcomingBookings extends StatefulWidget {
  const DoctorUpcomingBookings({super.key});

  @override
  State<DoctorUpcomingBookings> createState() => _DoctorUpcomingBookingsState();
}

class _DoctorUpcomingBookingsState extends State<DoctorUpcomingBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("الحجوزات القادمة", style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
    );
  }
}
