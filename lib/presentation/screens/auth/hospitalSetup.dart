import 'package:flutter/material.dart';

class HospitalSetup extends StatefulWidget {
  const HospitalSetup({super.key});

  @override
  State<HospitalSetup> createState() => _HospitalSetupState();
}

class _HospitalSetupState extends State<HospitalSetup> {
  TextEditingController hospitalNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تسجيل مستشفى"),
        centerTitle: true,
      ),
      body: Column(children: [
        TextField(controller: hospitalNameController),
      ]),
    );
  }
}
