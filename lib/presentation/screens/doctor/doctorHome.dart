import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/data/notificationHandler.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/presentation/screens/doctor/settings/settings.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    NotificationHandler.listenForNewAppointments();
  }

  final List<Widget> _screens = [
    Home(),
    DoctorSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: clr(1),
          padding: EdgeInsets.all(20),
        ),
        onPressed: () async {
          Navigator.pushNamed(context, "doctorNotifications");
        },
        label: Icon(
          Icons.notifications,
          size: 24,
          color: clr(0),
        ),
      ),
      appBar: AppBar(
        title: Text("تاتا", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
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
            icon: Icon(Icons.person),
            label: 'الحساب',
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
