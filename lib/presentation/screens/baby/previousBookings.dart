import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

class PreviousBookings extends StatefulWidget {
  const PreviousBookings({super.key});

  @override
  State<PreviousBookings> createState() => _PreviousBookingsState();
}

class _PreviousBookingsState extends State<PreviousBookings> {
  Future<List> fetchPreviousBookings() async {
    return [
      {"doctor": "عمر", "date": "10/9/2024"},
      {"doctor": "محمد", "date": "8/7/2024"}
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('الحجوزات السابقة', style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1),
        ),
        body: FutureBuilder(
          future: fetchPreviousBookings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "previousBookingDetails");
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: clr(1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "الدكتور: ${snapshot.data![index]['doctor']}",
                            style: TextStyle(fontSize: 24, color: clr(0)),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: clr(5),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Text("10",
                                    style: TextStyle(
                                        color: clr(0),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text("اكتوبر 2024",
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
              return Text("unknown error");
            }
          },
        ));
  }
}
