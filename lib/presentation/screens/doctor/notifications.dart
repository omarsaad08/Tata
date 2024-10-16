import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorNotifications extends StatefulWidget {
  const DoctorNotifications({super.key});

  @override
  State<DoctorNotifications> createState() => _DoctorNotificationsState();
}

class _DoctorNotificationsState extends State<DoctorNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("الاشعارات", style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)));
  }
}
