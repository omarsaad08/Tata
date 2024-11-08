import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorBookingDetails extends StatefulWidget {
  final Map doctor;

  DoctorBookingDetails({required this.doctor});

  @override
  State<DoctorBookingDetails> createState() => _DoctorBookingDetailsState();
}

class _DoctorBookingDetailsState extends State<DoctorBookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.doctor["name"] != null
                  ? widget.doctor["name"]
                  : "محمد محمد",
              style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: clr(0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Doctor's image
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: clr(
                      1,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    // Doctor's name
                    Text(
                      widget.doctor["name"] != null
                          ? widget.doctor['name']
                          : "محمد محمد",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: clr(0)),
                    ),
                    SizedBox(height: 10),
                    // Doctor's speciality
                    Text(
                      "التقييم: ",
                      style: TextStyle(fontSize: 18, color: clr(0)),
                    ),
                    Text(
                      "★★★★★",
                      style: TextStyle(fontSize: 18, color: clr(6)),
                    ),
                    SizedBox(height: 10),
                    // Doctor's experience
                    Text(
                      "الخبرة: ${widget.doctor["experience"] ?? 0}",
                      style: TextStyle(fontSize: 18, color: clr(0)),
                    ),
                    SizedBox(height: 20),
                    // Any other information can go here
                    Text("سعر الحجز: 100 جنيه",
                        style: TextStyle(color: clr(0))),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: mainElevatedButton("حجز", () {
                    Navigator.pushNamed(context, 'doctorAvailability',
                        arguments: widget.doctor['id']);
                  }, color: clr(5)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
