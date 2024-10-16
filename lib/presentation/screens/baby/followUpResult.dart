import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

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
                      color: clr(2), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("2/5",
                          style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight
                                  .bold)), // here should be the score of the periodic follow up
                      SizedBox(
                        height: 32,
                      ),
                      Text("طفلك يحتاج لزيارة طبيب",
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
                          Expanded(
                              child: mainElevatedButton("احجز اونلاين", () {
                            Navigator.pushNamed(context, "onlineDoctorBooking");
                          })),
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
