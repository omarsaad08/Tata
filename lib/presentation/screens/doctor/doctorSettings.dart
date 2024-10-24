import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/data/doctorServices.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorSettings extends StatefulWidget {
  const DoctorSettings({super.key});

  @override
  State<DoctorSettings> createState() => _DoctorSettingsState();
}

class _DoctorSettingsState extends State<DoctorSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("الاعدادات", style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: ListView.builder(
            // itemCount: Auth.getUser(id, 'doctor'),
            itemBuilder: (context, index) {
          return Container();
        }));
  }
}
