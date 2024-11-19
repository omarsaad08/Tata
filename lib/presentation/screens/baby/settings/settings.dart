import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

class BabySettings extends StatefulWidget {
  const BabySettings({super.key});

  @override
  State<BabySettings> createState() => _BabySettingsState();
}

class _BabySettingsState extends State<BabySettings> {
  List screens = [
    {"icon": Icon(Icons.person), "name": "الحساب", "route": "accountHome"}
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
            onTap: () {
              Navigator.pushNamed(context, screens[index]['route']);
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
