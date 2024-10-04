import 'package:flutter/material.dart';

class PeriodicFollowUp extends StatefulWidget {
  const PeriodicFollowUp({super.key});

  @override
  State<PeriodicFollowUp> createState() => _PeriodicFollowUpState();
}

class _PeriodicFollowUpState extends State<PeriodicFollowUp> {
  final List<Map<String, dynamic>> _checklistItems = [
    {"label": "Buy groceries", "isChecked": false},
    {"label": "Walk the dog", "isChecked": false},
    {"label": "Read a book", "isChecked": false},
    {"label": "Exercise", "isChecked": false},
  ];
  void _handleCheckboxChange(int index, bool? value) {
    setState(() {
      _checklistItems[index]['isChecked'] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("المتابعة الدورية"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(children: [
            ListView.builder(
              itemCount: _checklistItems.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_checklistItems[index]['label']),
                  value: _checklistItems[index]['isChecked'],
                  onChanged: (bool? value) {
                    _handleCheckboxChange(index, value);
                  },
                );
              },
            ),
          ]),
        ));
  }
}
