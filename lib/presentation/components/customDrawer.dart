import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/theme.dart';

class CustomDrawer extends StatelessWidget {
  final String type;
  const CustomDrawer({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: clr(2)),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('الرئيسية'),
            onTap: () {
              // Handle navigation to home
              Navigator.pushReplacementNamed(context, "${type}Home");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('الاعدادات'),
            onTap: () async {
              Navigator.pushNamed(context, "doctorSettings");
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('تسجيل الخروج'),
            onTap: () async {
              await Auth.signOut();
              Navigator.pushReplacementNamed(context, "login");
            },
          ),
        ],
      ),
    );
  }
}
