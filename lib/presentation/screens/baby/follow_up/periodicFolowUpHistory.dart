import 'package:flutter/material.dart';
import 'package:tata/data/periodicFollowUpServices.dart';
import 'package:tata/presentation/components/theme.dart';

class PeriodicFollowUpHistory extends StatefulWidget {
  const PeriodicFollowUpHistory({super.key});

  @override
  State<PeriodicFollowUpHistory> createState() =>
      _PeriodicFollowUpHistoryState();
}

class _PeriodicFollowUpHistoryState extends State<PeriodicFollowUpHistory> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PeriodicFollowUpServices.getAllFollowUps(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('عذرا حدث خطأ'),
            );
          } else {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, "babyPreviousBookingsDetails",
                      //     arguments: snapshot.data![index]);
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
                            "النتيجة: ${snapshot.data![index]['healthy'] ? "سليم" : "غير سليم"}",
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
                                    snapshot.data![index]['follow_up_date']
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
              ),
            );
          }
        });
  }
}
