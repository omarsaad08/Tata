import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/data/storage.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/mainTextField.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorSetup extends StatefulWidget {
  const DoctorSetup({super.key});

  @override
  State<DoctorSetup> createState() => _DoctorSetupState();
}

class _DoctorSetupState extends State<DoctorSetup> {
  String? message;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تسجيل دكتور", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          mainTextField(
              nameController, 'اسم الدكتور', Icon(Icons.local_hospital)),
          SizedBox(height: 12),
          mainTextField(
              phoneNumberController, "رقم هاتف الدكتور", Icon(Icons.phone)),
          SizedBox(height: 12),
          mainTextField(cityController, "المدينة", Icon(Icons.location_city)),
          SizedBox(height: 12),
          mainTextField(addressController, "العنوان", Icon(Icons.map)),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: mainElevatedButton("تم", () async {
                  final data = {
                    'name': nameController.text,
                    'email': await Storage.get('email'),
                    'phone': phoneNumberController.text,
                    'city': cityController.text,
                    'address': addressController.text,
                  };
                  final result = await Auth.saveUser(data, 'doctor');
                  if (result == 0) {
                    Navigator.pushReplacementNamed(context, "doctorHome");
                  } else {
                    setState(() {
                      message = 'عذرا حدث خطا';
                    });
                  }
                }),
              ),
              message != null
                  ? Text(message!)
                  : message == ''
                      ? CircularProgressIndicator(color: clr(1))
                      : Container()
            ],
          ),
        ]),
      ),
    );
  }
}
