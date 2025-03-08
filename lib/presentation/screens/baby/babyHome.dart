import 'package:flutter/material.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/presentation/screens/baby/follow_up/periodicFolowUpHistory.dart';
import 'package:tata/presentation/screens/baby/babyLanding.dart';
import 'package:tata/presentation/screens/baby/previousBookingsDetails/previousBookings.dart';
import 'package:tata/presentation/screens/baby/settings/settings.dart';

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
    BabyLanding(),
    PeriodicFollowUpHistory(),
    PreviousBookings(),
    BabySettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("تاتا", style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: clr(2),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: clr(0),
          unselectedItemColor: clr(0),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home5, color: Colors.white),
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
              label: 'الحساب',
            ),
          ],
        ));
  }
}
