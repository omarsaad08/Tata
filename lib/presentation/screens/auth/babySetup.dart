import 'package:flutter/material.dart';

class BabySetup extends StatefulWidget {
  BabySetup({super.key});

  @override
  State<BabySetup> createState() => _BabySetupState();
}

class _BabySetupState extends State<BabySetup> {
  DateTime? selectedDate;
  TextEditingController babyNameController = TextEditingController();

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("تسجيل بيانات الطفل"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              controller: babyNameController,
            ),
            ElevatedButton(
                onPressed: () async {
                  pickDate(context);
                },
                child: Text("اختيار تاريخ الميلاد")),
            Text(selectedDate == null
                ? "لا يوجد تاريخ"
                : 'الميلاد:${selectedDate!.toLocal()}'.split(' ')[0]),
            ElevatedButton(
                onPressed: () {
                  // handle the logic of saving the child's data\

                  Navigator.pushReplacementNamed(context, "babyHome");
                },
                child: Text("تم")),
          ],
        ));
  }
}
