import 'package:flutter/material.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/presentation/components/theme.dart';

class PreviousBookings extends StatefulWidget {
  const PreviousBookings({super.key});

  @override
  State<PreviousBookings> createState() => _PreviousBookingsState();
}

class _PreviousBookingsState extends State<PreviousBookings> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BookingServices.fetchPreviousBookingsForBaby(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('لا يوجد حجوزات سابقة'));
        } else if (snapshot.hasData) {
          if (snapshot.data != 0) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "babyPreviousBookingsDetails",
                        arguments: snapshot.data![index]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: clr(1), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الدكتور: ${snapshot.data![index]['doctor_name']}",
                          style: TextStyle(fontSize: 18, color: clr(0)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: clr(2),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Text(
                                  snapshot.data![index]['appointment_date']
                                      .split('T')[0],
                                  style: TextStyle(
                                    color: clr(0),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("لا يوجد حجوزات سابقة"),
            );
          }
        } else {
          return Text("unknown error");
        }
      },
    );
  }
}
