import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/presentation/components/customDrawer.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/presentation/screens/baby/follow_up/periodicFolowUpHistory.dart';
import 'package:tata/presentation/screens/baby/previousBookingsDetails/previousBookings.dart';
import 'package:tata/presentation/screens/baby/settings/settings.dart';
import 'package:tata/presentation/screens/baby/tata/tataHome.dart';

class BabyHome extends StatefulWidget {
  BabyHome({super.key});

  @override
  State<BabyHome> createState() => _BabyHomeState();
}

class _BabyHomeState extends State<BabyHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    Home(),
    PeriodicFollowUpHistory(),
    PreviousBookings(),
    BabySettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(type: "baby"),
      appBar: AppBar(
          title: Text("تاتا", style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: clr(1),
        unselectedItemColor: clr(5),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: clr(1),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.home5, color: Colors.white),
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.calendar_tick5),
            label: 'المتابعة الدورية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.hospital5),
            label: 'الحجوزات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: clr(0),
      child: ListView(children: [
        FutureBuilder(
          future: BookingServices.getNextAppointmentForBaby(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: clr(1)));
            } else if (snapshot.hasError) {
              // return Center(child: Text('Error: ${snapshot.error}'));
              return Container();
            } else if (snapshot.hasData) {
              // Make sure to return the Row widget here
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: clr(5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("الحجز القادم",
                                style: TextStyle(
                                  color: clr(0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "nextAppointment",
                            arguments: snapshot.data);
                      },
                    ),
                  ),
                ],
              );
            }
            return Container(); // Return an empty Container if none of the above conditions are met
          },
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: clr(0),
                        border: Border.all(color: clr(1), width: 3),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image.asset("assets/followUp.png", width: 100),
                          Icon(Iconsax.calendar_tick5, size: 48, color: clr(1)),
                          SizedBox(height: 12),
                          Text("المتابعة الدورية",
                              style: TextStyle(
                                  color: clr(1),
                                  fontSize: 18,
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
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.all(color: clr(1), width: 3),
                          color: clr(0),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset("assets/hospital.png",
                            //     width: 100),
                            Icon(
                              Iconsax.hospital5,
                              size: 48,
                              color: clr(1),
                            ),
                            SizedBox(height: 12),
                            Text("حجز في مستشفى",
                                style: TextStyle(
                                    color: clr(1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                          ])),
                  onTap: () {
                    Navigator.pushNamed(context, "offlineDoctorBooking");
                  }),
            )
          ],
        ),
      ]),
    );
  }
}
