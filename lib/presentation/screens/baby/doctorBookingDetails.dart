import 'package:flutter/material.dart';

class DoctorBookingDetails extends StatefulWidget {
  final Map<String, String> doctor;

  DoctorBookingDetails({required this.doctor});

  @override
  State<DoctorBookingDetails> createState() => _DoctorBookingDetailsState();
}

class _DoctorBookingDetailsState extends State<DoctorBookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctor["name"]!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Doctor's image
            Image.network(widget.doctor["imageUrl"]!),
            SizedBox(height: 20),
            // Doctor's name
            Text(
              widget.doctor["name"]!,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Doctor's speciality
            Text(
              "التقييم: ★★★★☆",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Doctor's experience
            Text(
              "Experience: ${widget.doctor["experience"]}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Any other information can go here
            Text("سعر الحجز: 100EGP"),
            // ###### booking time ######
            Text("الموعد الفارغ القادم: 10/10/2024 الساعة 10:30 AM"),
            ElevatedButton(onPressed: () {}, child: Text("تغيير الموعد")),
            ElevatedButton(onPressed: () {}, child: Text("حجز"))
          ],
        ),
      ),
    );
  }
}
