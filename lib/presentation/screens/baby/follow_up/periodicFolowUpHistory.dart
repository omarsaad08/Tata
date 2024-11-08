import 'package:flutter/material.dart';

class PeriodicFollowUpHistory extends StatefulWidget {
  const PeriodicFollowUpHistory({super.key});

  @override
  State<PeriodicFollowUpHistory> createState() =>
      _PeriodicFollowUpHistoryState();
}

class _PeriodicFollowUpHistoryState extends State<PeriodicFollowUpHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("تاريخ المتابعة الدورية"));
  }
}
