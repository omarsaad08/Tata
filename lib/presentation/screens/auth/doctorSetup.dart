import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
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
  TextEditingController examinationPriceController = TextEditingController();
  TextEditingController sessionPriceController = TextEditingController();
  List<String> specialities = [
    "باطني",
    "مخ واعصاب",
    "جراحة",
    "تخاطب",
    "علاج طبيعي",
    "اخر"
  ];
  String? selectedSpecialitiy;
  List<String> sessions = ["وظيفي", "تخاطب", "طبيعي"];
  String? selectedSession;
  int experience = 0;
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
        child: ListView(children: [
          mainTextField(
              nameController, 'اسم الدكتور', Icon(Icons.local_hospital)),
          SizedBox(height: 12),
          mainTextField(
              phoneNumberController, "رقم هاتف الدكتور", Icon(Icons.phone)),
          SizedBox(height: 12),
          mainTextField(cityController, "المدينة", Icon(Icons.location_city)),
          SizedBox(height: 12),
          mainTextField(addressController, "العنوان", Icon(Icons.map)),
          SizedBox(height: 12),
          DropdownButton<String>(
              hint: Text('اختر تخصصك'),
              value: selectedSpecialitiy,
              items: specialities.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSpecialitiy = newValue;
                });
              }),
          SizedBox(height: 12),
          DropdownButton<String>(
              hint: Text('اختر نوع الجلسات التي تقدمها'),
              value: selectedSession,
              items: sessions.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSession = newValue;
                });
              }),
          SizedBox(height: 12),
          mainTextField(
              examinationPriceController, 'سعر الكشف', Icon(Icons.money)),
          SizedBox(height: 12),
          mainTextField(
              sessionPriceController, "سعر الجلسة", Icon(Icons.attach_money)),
          SizedBox(height: 12),
          Text("سنوات الخبرة"),
          SizedBox(height: 12),
          DropdownButton<int>(
            value: experience,
            onChanged: (value) {
              setState(() {
                experience = value!;
              });
            },
            items: List<DropdownMenuItem<int>>.generate(
              51,
              (index) => DropdownMenuItem<int>(
                value: index,
                child: Text(index.toString()),
              ),
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: mainElevatedButton("تم", () async {
                  final userData = {
                    'name': nameController.text,
                    'email': await Auth.getCurrentUserEmail(),
                    'phone': phoneNumberController.text,
                    'role': "doctor"
                  };
                  final user = await Auth.saveUser(userData);
                  final doctorData = {
                    'user_id': user!['id'],
                    'city': cityController.text,
                    'address': addressController.text,
                    'speciality': selectedSpecialitiy,
                    'sessionsType': selectedSession,
                    'examinationPrice': examinationPriceController.text,
                    'sessionPrice': sessionPriceController.text,
                    'experience': experience
                  };
                  final doctor =
                      await Auth.saveUser(doctorData, type: "doctor");
                  Navigator.pushReplacementNamed(context, "inputAvailability");
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
