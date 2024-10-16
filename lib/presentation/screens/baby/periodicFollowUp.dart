import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import '../../../../utils/followUp.dart';

class PeriodicFollowUp extends StatefulWidget {
  const PeriodicFollowUp({super.key});

  @override
  State<PeriodicFollowUp> createState() => _PeriodicFollowUpState();
}

class _PeriodicFollowUpState extends State<PeriodicFollowUp> {
  String? selectedOption = '3';
  FollowUp followUp = FollowUp(3);
  void _handleCheckboxChange(
      int index, bool? value, List<Map<String, dynamic>> _checklistItems) {
    setState(() {
      _checklistItems[index]['isChecked'] = value;
    });
  }

  void handleRadioChange(String value) {
    setState(() {
      selectedOption = value;
      followUp.setup(int.parse(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("المتابعة الدورية", style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                RadioListTile<String>(
                  title: Text('من سن 0 الى 3 شهور'),
                  value: '3',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    handleRadioChange(value!);
                  },
                ),
                RadioListTile<String>(
                  title: Text('من سن 4 الى 6 شهور'),
                  value: '6',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    handleRadioChange(value!);
                  },
                ),
                RadioListTile<String>(
                  title: Text('من سن 7 الى 9 شهور'),
                  value: '9',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    handleRadioChange(value!);
                  },
                ),
                RadioListTile<String>(
                  title: Text('من سن 10 الى 12 شهور'),
                  value: '12',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    handleRadioChange(value!);
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            ExpansionTile(
              backgroundColor: clr(2),
              initiallyExpanded: true,
              title:
                  Text("علامات النمو الحركية"), // Title of the foldable section
              leading: Image.asset(
                  "assets/motor-milestones.png"), // Optional leading icon
              children: followUp.motorMilestones.map((item) {
                int index = followUp.motorMilestones.indexOf(item);
                return CheckboxListTile(
                  title: Text(item['label']),
                  value: item['isChecked'],
                  onChanged: (bool? value) {
                    _handleCheckboxChange(
                        index, value, followUp.motorMilestones);
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title:
                  Text("علامات النمو الحسية"), // Title of the foldable section
              leading: Image.asset(
                  "assets/sensory-milestones.png"), // Optional leading icon
              children: followUp.sensoryMilestones.map((item) {
                int index = followUp.sensoryMilestones.indexOf(item);
                return CheckboxListTile(
                  title: Text(item['label']),
                  value: item['isChecked'],
                  onChanged: (bool? value) {
                    _handleCheckboxChange(
                        index, value, followUp.sensoryMilestones);
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title:
                  Text("علامات نمو التواصل"), // Title of the foldable section
              leading: Image.asset(
                  "assets/communication-milestones.png"), // Optional leading icon
              children: followUp.communicationMilestones.map((item) {
                int index = followUp.communicationMilestones.indexOf(item);
                return CheckboxListTile(
                  title: Text(item['label']),
                  value: item['isChecked'],
                  onChanged: (bool? value) {
                    _handleCheckboxChange(
                        index, value, followUp.communicationMilestones);
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title: Text("نقاط التغذية"), // Title of the foldable section
              leading: Image.asset(
                  "assets/feeding-milestones.png"), // Optional leading icon
              children: followUp.feedingMilestones.map((item) {
                int index = followUp.feedingMilestones.indexOf(item);
                return CheckboxListTile(
                  title: Text(item['label']),
                  value: item['isChecked'],
                  onChanged: (bool? value) {
                    _handleCheckboxChange(
                        index, value, followUp.feedingMilestones);
                  },
                );
              }).toList(),
            ),
            mainElevatedButton("تم", () {
              // send the data to the server to analyze it

              Navigator.pushNamed(context, "followUpResult");
            })
          ],
        ),
      ),
    );
  }
}
