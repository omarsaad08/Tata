import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/mainTextField.dart';
import 'package:tata/presentation/components/theme.dart';

class OnlineDoctorBooking extends StatefulWidget {
  const OnlineDoctorBooking({super.key});

  @override
  State<OnlineDoctorBooking> createState() => _OnlineDoctorBookingState();
}

class _OnlineDoctorBookingState extends State<OnlineDoctorBooking> {
  TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> doctors = [
    {
      "name": "احمد محمد",
      "speciality": "Cardiologist",
      "experience": "10 سنين",
      "imageUrl": "doctor-ahmed.png"
    },
    {
      "name": "محمد مصطفى",
      "speciality": "Dermatologist",
      "experience": "5 سنين",
      "imageUrl": "doctor-mohamed.png"
    },
    {
      "name": "خالد احمد",
      "speciality": "Pediatrician",
      "experience": "8 سنين",
      "imageUrl": "doctor-khalid.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                Text("حجز دكتور", style: TextStyle(color: clr(0))),
              ],
            ),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: mainTextField(
                        searchController, "بحث عن دكتور", Icon(Icons.search)),
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
          },
        ));
  }
}

class DoctorCard extends StatelessWidget {
  final Map<String, String> doctor;
  final VoidCallback onPressed;

  DoctorCard({required this.doctor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: clr(2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Display the doctor's name
                Text(
                  doctor["name"]!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Display the doctor's experience
                Text("الخبرة: ${doctor["experience"]}"),
                SizedBox(height: 10),
                // Button to open the detailed screen
                mainElevatedButton("تفاصيل", () {
                  Navigator.pushNamed(context, "doctorBookingDetails",
                      arguments: doctor);
                }),
              ],
            ),
            Column(children: [
              Image.asset(
                'assets/${doctor["imageUrl"]!}',
                width: 120,
              )
            ]),
          ],
        ),
      ),
    );
  }
}
