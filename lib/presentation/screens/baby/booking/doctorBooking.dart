import 'package:flutter/material.dart';
import 'package:tata/data/doctorServices.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/mainTextField.dart';
import 'package:tata/presentation/components/theme.dart';

class OfflineDoctorBooking extends StatefulWidget {
  const OfflineDoctorBooking({super.key});

  @override
  State<OfflineDoctorBooking> createState() => _OfflineDoctorBookingState();
}

class _OfflineDoctorBookingState extends State<OfflineDoctorBooking> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("حجز دكتور", style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: FutureBuilder(
          future: DoctorServices.getAllDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final doctors = snapshot.data!;
              return ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  if (doctors.length != 0) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: mainTextField(
                              searchController,
                              "بحث عن دكتور",
                              Icon(Icons.search),
                            ),
                          ),
                          DoctorCard(
                            doctor: doctors[index],
                            onPressed: () {
                              // Navigate to the doctor's detail screen
                            },
                          ),
                        ],
                      );
                    } else {
                      return DoctorCard(
                        doctor: doctors[index],
                        onPressed: () {
                          // Navigate to the doctor's detail screen
                        },
                      );
                    }
                  } else {
                    return Center(child: Text("لا يوجد دكتور متوفر حاليا"));
                  }
                },
              );
            } else {
              return Text("unknown error");
            }
          },
        ));
  }
}

class DoctorCard extends StatelessWidget {
  final Map doctor;
  final VoidCallback onPressed;

  DoctorCard({required this.doctor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: clr(4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['users']['name'],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: clr(0)),
                    ),
                    Text("الخبرة: ${doctor["experience"]} سنوات",
                        style: TextStyle(color: clr(0))),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      doctor['city'],
                      style: TextStyle(fontSize: 16, color: clr(0)),
                    ),
                    Text(
                      doctor['address'],
                      style: TextStyle(fontSize: 16, color: clr(0)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: mainElevatedButton("تفاصيل", () {
                    Navigator.pushNamed(context, "doctorBookingDetails",
                        arguments: doctor);
                  }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
