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
      body: ListView(
        children: [
          ElevatedButton(onPressed: () {}, child: Text("تغير الفئة العمرية")),
          ExpansionTile(
            title: Text("My Tasks"), // Title of the foldable section
            leading: Icon(Icons.check_box), // Optional leading icon
            children: _checklistItems.map((item) {
              int index = _checklistItems.indexOf(item);
              return CheckboxListTile(
                title: Text(item['label']),
                value: item['isChecked'],
                onChanged: (bool? value) {
                  _handleCheckboxChange(index, value);
                },
              );
            }).toList(),
          ),
          ExpansionTile(
            title: Text("My Tasks"), // Title of the foldable section
            leading: Icon(Icons.check_box), // Optional leading icon
            children: _checklistItems.map((item) {
              int index = _checklistItems.indexOf(item);
              return CheckboxListTile(
                title: Text(item['label']),
                value: item['isChecked'],
                onChanged: (bool? value) {
                  _handleCheckboxChange(index, value);
                },
              );
            }).toList(),
          ),
          ExpansionTile(
            title: Text("My Tasks"), // Title of the foldable section
            leading: Icon(Icons.check_box), // Optional leading icon
            children: _checklistItems.map((item) {
              int index = _checklistItems.indexOf(item);
              return CheckboxListTile(
                title: Text(item['label']),
                value: item['isChecked'],
                onChanged: (bool? value) {
                  _handleCheckboxChange(index, value);
                },
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: () {
                // send the data to the server to analyze it

                Navigator.pushNamed(context, "followUpResult");
              },
              child: Text("تم")),
        ],
      ),
    );
  }
}
