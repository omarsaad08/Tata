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
  late Future<List?> followUpsFuture;

  @override
  void initState() {
    super.initState();
    followUpsFuture = PeriodicFollowUpServices.getAllFollowUps();
  }

  Future<void> _refreshData() async {
    setState(() {
      followUpsFuture = PeriodicFollowUpServices.getAllFollowUps();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: followUpsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('عذرا حدث خطأ'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('لا توجد متابعات سابقة'),
            );
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                          context, "followUpHistoryDetails",
                          arguments: snapshot.data![index]);

                      if (result == true) {
                        // Refresh the list if a follow-up was deleted
                        _refreshData();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: clr(2),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Text(
                                    snapshot.data![index]['follow_up_date']
                                        .split('T')[0],
                                    style: TextStyle(color: clr(0)))
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
