import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  List<Map> offlineBooking = [
    {
      "baby": "اسلام",
      "time": "10:00AM",
      "date": "10/10/2024",
      "paid": true,
      "status": 0,
      "review": null,
    },
    {
      "baby": "خالد",
      "time": "10:15AM",
      "date": "10/10/2024",
      "paid": false,
      "status": 0,
      "review": null,
    },
    {
      "baby": "محمد",
      "time": "10:30AM",
      "date": "10/10/2024",
      "paid": true,
      "status": 0,
      "review": null,
    },
    {
      "baby": "حسن",
      "time": "11:00AM",
      "date": "10/10/2024",
      "paid": false,
      "status": 0,
      "review": null,
    }
  ];
  List<Map> onlineBooking = [
    {
      "baby": "نادر",
      "time": "10:45AM",
      "date": "10/10/2024",
      "status": 0,
      "paid": true,
      "review": null,
    },
    {
      "baby": "يوسف",
      "time": "11:15AM",
      "date": "10/10/2024",
      "status": 0,
      "paid": true,
      "review": null,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: clr(1),
              padding: EdgeInsets.all(20),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "doctorNotifications");
            },
            label: Icon(
              Icons.notifications,
              size: 24,
              color: clr(0),
            )),
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
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "حجوزات اليوم",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: ListView.builder(
                  itemCount: offlineBooking.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "offlineBook",
                            arguments: offlineBooking[index]);
                      },
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          margin: EdgeInsets.all(8),
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: clr(1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${offlineBooking[index]['baby']}",
                                  style:
                                      TextStyle(fontSize: 22, color: clr(0))),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: clr(5)),
                                child: Text(
                                  "${offlineBooking[index]['time']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: clr(0)),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
              Text(
                "الحجوزات الاونلاين",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: ListView.builder(
                  itemCount: onlineBooking.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "onlineBook",
                            arguments: onlineBooking[index]);
                      },
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          margin: EdgeInsets.all(8),
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: clr(1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${onlineBooking[index]['baby']}",
                                  style:
                                      TextStyle(fontSize: 22, color: clr(0))),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: clr(5)),
                                child: Text(
                                  "${onlineBooking[index]['time']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: clr(0)),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: mainElevatedButton(
                    "الحجوزات القادمة",
                    () {
                      Navigator.pushNamed(context, "doctorUpcomingBookings");
                    },
                  )),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: mainElevatedButton(
                    "الحجوزات السابقة",
                    () {
                      Navigator.pushNamed(context, "doctorPreviousBookings");
                    },
                  )),
                ],
              )
            ],
          ),
        ));
  }
}
