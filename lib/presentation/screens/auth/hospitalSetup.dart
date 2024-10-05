import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/mainTextField.dart';
import 'package:tata/presentation/components/theme.dart';

class HospitalSetup extends StatefulWidget {
  const HospitalSetup({super.key});

  @override
  State<HospitalSetup> createState() => _HospitalSetupState();
}

class _HospitalSetupState extends State<HospitalSetup> {
  TextEditingController hospitalNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تسجيل مستشفى", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(2),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          mainTextField(hospitalNameController, 'اسم المستشفى',
              Icon(Icons.local_hospital)),
          SizedBox(height: 12),
          mainTextField(
              phoneNumberController, "رقم هاتف المستفى", Icon(Icons.phone)),
          SizedBox(height: 12),
          mainTextField(cityController, "المدينة", Icon(Icons.location_city)),
          SizedBox(height: 12),
          mainTextField(addressController, "العنوان", Icon(Icons.map)),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: mainElevatedButton("تم", () {
                  // handle saving hospital's data
                  Navigator.pushNamed(context, "hospitalHome");
                }),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
