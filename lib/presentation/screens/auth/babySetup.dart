import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
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
  TextEditingController phoneController = TextEditingController();
  String? message;
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
          backgroundColor: clr(1),
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
              TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      labelText: 'رقم الهاتف',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.phone),
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
              mainElevatedButton("تم", () async {
                message = '';
                // handle the logic of saving the child's data + check if he is less than 2 years or not

                try {
                  final userData = {
                    "name": babyNameController.text,
                    "email": await Auth.getCurrentUserEmail(),
                    "phone": phoneController.text,
                    "role": "baby"
                  };
                  final user = await Auth.saveUser(userData);

                  final babyData = {
                    "user_id": user!['id'],
                    "date_of_birth":
                        selectedDate!.toLocal().toString().split(' ')[0],
                  };

                  await Auth.saveUser(babyData, type: "baby");

                  Navigator.pushReplacementNamed(context, "babyHome");
                } catch (e) {
                  setState(() {
                    message = 'عذرا حدث خطا';
                  });
                }
              }),
              message != null
                  ? Text(message!)
                  : message == ''
                      ? CircularProgressIndicator(color: clr(1))
                      : Container()
            ],
          ),
        ));
  }
}
