import 'package:flutter/material.dart';

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
          title: Text('الحجوزات السابقة'),
          centerTitle: true,
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
                  return Card(
                    child: Text(
                        "الدكتور: ${snapshot.data![index]['doctor']}, التاريخ: ${snapshot.data![index]['date']}"),
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
