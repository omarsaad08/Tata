import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

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
          title: Text("تاتا", style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
      body: Container(
        padding: EdgeInsets.all(8),
        color: clr(0),
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          color: clr(1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("assets/followUp.png", width: 100),
                            SizedBox(height: 12),
                            Text("المتابعة الدورية",
                                style: TextStyle(
                                    color: clr(0),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "periodicFollowUp");
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                    child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            color: clr(1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/hospital.png", width: 100),
                              SizedBox(height: 12),
                              Text("حجز في مستشفى",
                                  style: TextStyle(
                                      color: clr(0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ])),
                    onTap: () {
                      Navigator.pushNamed(context, "offlineDoctorBooking");
                    }),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          color: clr(1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/online-doctor.png", width: 100),
                            SizedBox(height: 12),
                            Text("حجز اونلاين",
                                style: TextStyle(
                                    color: clr(0),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "onlineDoctorBooking");
                    }),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                    child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            color: clr(1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/db.png", width: 100),
                              SizedBox(height: 12),
                              Text("الحجوزات السابقة",
                                  style: TextStyle(
                                      color: clr(0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ])),
                    onTap: () {
                      Navigator.pushNamed(context, "babyPreviousBookings");
                    }),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
