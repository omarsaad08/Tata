import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

class AccountHome extends StatefulWidget {
  const AccountHome({super.key});

  @override
  State<AccountHome> createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  List settings = [
    {"name": "تغيير الاسم", "route": "updateUserData"},
    {"name": "تغيير تاريخ الميلاد", "route": "updateUserData"},
    {"name": "تغيير رقم الهاتف", "route": "updateUserData"},
    {"name": "تغيير صورة الحساب", "route": "uploadImage"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اعدادات الحساب", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
      body: Container(
        color: clr(4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, settings[index]['route']);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: clr(0), borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.symmetric(vertical: 6),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        settings[index]['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
