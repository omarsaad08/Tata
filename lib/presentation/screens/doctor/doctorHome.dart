import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/data/storage.dart';
import 'package:tata/data/user.dart';
import 'package:tata/presentation/components/customDrawer.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:dio/dio.dart';
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

  final List<Widget> _screens = [
    Home(),
    DoctorSettings(
      doctorId: TataUser.id!,
    ),
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
          final id = await Storage.get('id');
          Navigator.pushNamed(context, "doctorNotifications",
              arguments: int.parse(id!));
        },
        label: Icon(
          Icons.notifications,
          size: 24,
          color: clr(0),
        ),
      ),
      drawer: CustomDrawer(type: "doctor"),
      appBar: AppBar(
        title: Text("تاتا", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
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
            icon: Icon(Icons.person),
            label: 'الاعدادات',
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
  List<Map> offlineBooking = [];
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchBookings(); // Fetch bookings when screen is initialized
  }

  Future<void> fetchBookings() async {
    try {
      final dio = Dio();
      final doctorId = int.parse((await Storage.get('id'))!);
      final response = await dio
          .get('http://192.168.1.219:3000/appointments/today/$doctorId');

      if (response.statusCode == 200) {
        setState(() {
          // Assuming the API returns lists for both online and offline bookings
          offlineBooking = List<Map>.from(response.data);
          isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load bookings: ${response.data}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator()) // Show loading spinner
        : Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: BookingServices.getNextAppointmentForDoctor(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(color: clr(1)));
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
                                padding: EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: clr(1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12),
                                    Text("الحجز القادم",
                                        style: TextStyle(
                                          color: clr(0),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "nextAppointmentDoctor",
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
                Text(
                  "حجوزات اليوم",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                offlineBooking.length != 0
                    ? SizedBox(
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  margin: EdgeInsets.all(8),
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: clr(1)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${offlineBooking[index]['baby']}",
                                          style: TextStyle(
                                              fontSize: 22, color: clr(0))),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
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
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text("لا يوجد اي حجز اليوم"),
                      ),
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
                ),
              ],
            ),
          );
  }
}
