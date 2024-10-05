import 'package:flutter/material.dart';

class OfflineDoctorBooking extends StatefulWidget {
  const OfflineDoctorBooking({super.key});

  @override
  State<OfflineDoctorBooking> createState() => _OfflineDoctorBookingState();
}

class _OfflineDoctorBookingState extends State<OfflineDoctorBooking> {
  final List<Map<String, String>> doctors = [
    {
      "name": "Dr. Ahmed",
      "speciality": "Cardiologist",
      "experience": "10 years",
      "imageUrl": "https://via.placeholder.com/120"
    },
    {
      "name": "Dr. Sara",
      "speciality": "Dermatologist",
      "experience": "5 years",
      "imageUrl": "https://via.placeholder.com/120"
    },
    {
      "name": "Dr. John",
      "speciality": "Pediatrician",
      "experience": "8 years",
      "imageUrl": "https://via.placeholder.com/120"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("حجز دكتور"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            return DoctorCard(
              doctor: doctors[index],
              onPressed: () {
                // Navigate to the doctor's detail screen
              },
            );
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
                // Display the doctor's speciality
                Text("Speciality: ${doctor["speciality"]}"),
                // Display the doctor's experience
                Text("Experience: ${doctor["experience"]}"),
                SizedBox(height: 10),
                // Button to open the detailed screen
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "doctorBookingDetails",
                        arguments: doctor);
                  },
                  child: Text("View Details"),
                ),
              ],
            ),
            Column(children: [Image.network(doctor["imageUrl"]!)]),
          ],
        ),
      ),
    );
  }
}
