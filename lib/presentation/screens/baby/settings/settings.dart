import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/theme.dart';

class BabySettings extends StatefulWidget {
  const BabySettings({super.key});

  @override
  State<BabySettings> createState() => _BabySettingsState();
}

class _BabySettingsState extends State<BabySettings> {
  List screens = [
    {
      "icon": Icon(Icons.person),
      "name": "الحساب",
      "route": "accountHome",
    },
    {
      "icon": Icon(Icons.language),
      "name": "تغيير اللغة",
      "route": "changeLanguage"
    },
    {"icon": Icon(Icons.logout), "name": "تسجيل الخروج", "route": "logout"}
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: clr(4),
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
                decoration: BoxDecoration(
                    color: clr(0), borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    screens[index]['icon'],
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      screens[index]['name'],
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
