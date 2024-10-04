import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BabyHome extends StatefulWidget {
  const BabyHome({super.key});

  @override
  State<BabyHome> createState() => _BabyHomeState();
}

class _BabyHomeState extends State<BabyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle navigation to home
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle navigation to settings
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () async {
                // Add sign-out logic here
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "login");
                // Sign out logic
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(onPressed: () {}, child: Text("المتابعة الدورية")),
          ElevatedButton(onPressed: () {}, child: Text("حجز في مستشفى")),
          ElevatedButton(onPressed: () {}, child: Text("حجز اونلاين")),
          ElevatedButton(onPressed: () {}, child: Text("الحجوزات السابقة")),
        ]),
      ),
    );
  }
}
