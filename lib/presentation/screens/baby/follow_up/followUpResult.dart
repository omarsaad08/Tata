/*
  idea:
  we can add an analysis to every single data that we took and generate a pdf file explaining with visuals everything to the mother.
*/
import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class FollowUpResult extends StatefulWidget {
  final bool healthy;
  const FollowUpResult({super.key, required this.healthy});

  @override
  State<FollowUpResult> createState() => _FollowUpResultState();
}

class _FollowUpResultState extends State<FollowUpResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("نتيجة المتابعة الدورية", style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(12),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: clr(0), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          widget.healthy
                              ? "طفلك ينمو بشكل سليم"
                              : "طفلك يحتاج لزيارة طبيب",
                          style: TextStyle(
                              fontSize: 24)), // here should be the description
                      SizedBox(
                        height: 48,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: mainElevatedButton("احجز مع دكتور", () {
                              Navigator.pushNamed(
                                  context, "offlineDoctorBooking");
                            }),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      )
                    ],
                  ),
                ))));
  }
}
