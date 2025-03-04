import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/data/bookingServices.dart';

class DoctorNotifications extends StatefulWidget {
  const DoctorNotifications({super.key});

  @override
  State<DoctorNotifications> createState() => _DoctorNotificationsState();
}

class _DoctorNotificationsState extends State<DoctorNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("الاشعارات", style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: FutureBuilder(
          future: BookingServices.getRequestedAppointments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final appointments = snapshot.data!;
              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  Map item = appointments[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: clr(2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item['type'] ?? "كشف",
                                style: TextStyle(
                                    color: clr(0),
                                    fontWeight: FontWeight.bold)),
                            Text(item['appointment_time'],
                                style: TextStyle(color: clr(0)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item['baby_name'],
                                style: TextStyle(
                                    color: clr(0),
                                    fontWeight: FontWeight.bold)),
                            Text(item['online'] ? "اونلاين" : "اوفلاين",
                                style: TextStyle(color: clr(0)))
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                                child: mainElevatedButton("قبول", () async {
                              final result =
                                  await BookingServices.updateAppointment(
                                      item['appointment_id'],
                                      {"status": "approved"});
                              setState(() {});
                            })),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: mainElevatedButton("رفض", () async {
                              final result =
                                  await BookingServices.updateAppointment(
                                      item['appointment_id'],
                                      {"status": "declined"});
                              setState(() {});
                            }, color: clr(5)))
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text("unknown error");
            }
          },
        ));
  }
}
