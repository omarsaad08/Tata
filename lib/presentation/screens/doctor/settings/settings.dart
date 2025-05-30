import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorSettings extends StatefulWidget {
  const DoctorSettings({super.key});

  @override
  State<DoctorSettings> createState() => _DoctorSettingsState();
}

class _DoctorSettingsState extends State<DoctorSettings> {
  List screens = [
    // {
    //   "icon": Icon(Icons.language),
    //   "name": "تغيير اللغة",
    //   "route": "changeLanguage"
    // },
    {"icon": Icon(Icons.logout), "name": "تسجيل الخروج", "route": "logout"}
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: ListView.builder(
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              if (screens[index]['route'] != "logout") {
                Navigator.pushNamed(context, screens[index]['route']);
              } else {
                await Auth.signOut();
                Navigator.pushReplacementNamed(context, "login");
              }
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: clr(3), borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    screens[index]['icon'],
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      screens[index]['name'],
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
