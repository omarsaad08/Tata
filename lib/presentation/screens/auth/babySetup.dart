import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

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
          title: Text("تسجيل بيانات الطفل", style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(2),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: babyNameController,
                  decoration: InputDecoration(
                      labelText: 'اسم الطفل',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: clr(1))),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: mainElevatedButton("اختر تاريخ الميلاد", () async {
                      pickDate(context);
                    }),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                  selectedDate == null
                      ? "لا يوجد تاريخ"
                      : 'الميلاد:${selectedDate!.toLocal()}'.split(' ')[0],
                  style: TextStyle(fontSize: 18)),
              mainElevatedButton("تم", () {
                // handle the logic of saving the child's data + check if he is less than 2 years or not
                Navigator.pushReplacementNamed(context, "babyHome");
              })
            ],
          ),
        ));
  }
}
