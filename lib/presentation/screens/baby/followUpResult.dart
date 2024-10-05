import 'package:flutter/material.dart';

class FollowUpResult extends StatefulWidget {
  const FollowUpResult({super.key});

  @override
  State<FollowUpResult> createState() => _FollowUpResultState();
}

class _FollowUpResultState extends State<FollowUpResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("نتيجة المتابعة الدورية"),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                        "2/5"), // here should be the score of the periodic follow up
                    Text(
                        "طفلك يحتاج لزيارة طبيب"), // here should be the description
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "offlineDoctorBooking");
                        },
                        child: Text("احجز مع دكتور")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "onlineDoctorBooking");
                        },
                        child: Text("احجز اونلاين"))
                  ],
                ))));
  }
}
