import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

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
          title: Text(widget.doctor["name"]!, style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: clr(2),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Doctor's image
              Image.asset("assets/${widget.doctor["imageUrl"]!}", width: 120),
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
                      widget.doctor["name"]!,
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
                      "الخبرة: ${widget.doctor["experience"]}",
                      style: TextStyle(fontSize: 18, color: clr(0)),
                    ),
                    SizedBox(height: 20),
                    // Any other information can go here
                    Text("سعر الحجز: 100 جنيه",
                        style: TextStyle(color: clr(0))),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // ###### booking time ######
              Text("الموعد الفارغ القادم: 10/10/2024 الساعة 10:30 AM"),
              SizedBox(
                height: 12,
              ),
              Row(children: [
                Expanded(
                  child:
                      mainElevatedButton("تغيير الموعد", () {}, color: clr(5)),
                )
              ]),
              Row(
                children: [
                  Expanded(
                      child: mainElevatedButton("حجز", () {
                    Navigator.pushNamed(context, 'doctorAvailability',
                        arguments: 1);
                  }))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
