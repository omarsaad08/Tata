// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/data/periodicFollowUpServices.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/mainTextField.dart';
import 'package:tata/presentation/components/theme.dart';
import '../../../../models/followUp.dart';

class PeriodicFollowUp extends StatefulWidget {
  const PeriodicFollowUp({super.key});

  @override
  State<PeriodicFollowUp> createState() => _PeriodicFollowUpState();
}

class _PeriodicFollowUpState extends State<PeriodicFollowUp> {
  String? selectedOption = '3';
  FollowUp followUp = FollowUp(3);
  bool loading = false;
  TextEditingController notesController = TextEditingController();
  void _handleCheckboxChange(
      int index, bool? value, List<Map<String, dynamic>> _checklistItems) {
    setState(() {
      _checklistItems[index]['isChecked'] = value;
    });
  }

  void clearAllCheckboxes() {
    setState(() {
      // Reset motor milestones
      for (var item in followUp.motorMilestones) {
        item['isChecked'] = false;
      }
      // Reset sensory milestones
      for (var item in followUp.sensoryMilestones) {
        item['isChecked'] = false;
      }
      // Reset communication milestones
      for (var item in followUp.communicationMilestones) {
        item['isChecked'] = false;
      }
      // Reset feeding milestones
      for (var item in followUp.feedingMilestones) {
        item['isChecked'] = false;
      }
    });
  }

  void handleRadioChange(String value) {
    setState(() {
      selectedOption = value;
      followUp.setup(int.parse(value));
    });
  }

  int calculateAgeInMonths(DateTime birthDate) {
    DateTime today = DateTime.now();

    int yearsDifference = today.year - birthDate.year;
    int monthsDifference = today.month - birthDate.month;

    int totalMonths = (yearsDifference * 12) + monthsDifference;

    // If the current day of the month is before the birth date, subtract one month
    if (today.day < birthDate.day) {
      totalMonths--;
    }

    return totalMonths;
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
            SizedBox(
              height: 12,
            ),
            mainTextField(notesController, 'ملاحظات', Icon(Icons.notes)),
            SizedBox(
              height: 12,
            ),
            mainElevatedButton("العلامات التحذيرية", () {
              Navigator.pushNamed(context, 'warningSigns');
            }, color: clr(5)),
            mainElevatedButton("تم", () async {
              setState(() {
                loading = true;
              });
              try {
                // send the data to the server to analyze it
                final values = followUp.generateValues();
                print('going to get the user from the server');
                final data = {
                  "baby_id": (await Auth.getCurrentUser(type: 'baby'))!['id'],
                  "follow_up_date":
                      DateTime.now().toLocal().toString().split(' ')[0],
                  "motorMilestones": values[0],
                  "feedingMilestones": values[1],
                  "communicationMilestones": values[2],
                  "sensoryMilestones": values[3],
                  // "score": (followUp.generateScore() * 100).floor(),
                  "healthy": followUp.healthy,
                  // "ageInMonths":
                  //     calculateAgeInMonths(DateTime(user!['date_of_birth'])),
                  "notes": notesController.text,
                };

                print('data: $data');
                final result =
                    await PeriodicFollowUpServices.addPeriodicFollowUp(data);
                print('result: $result');
                // Clear all checkboxes after submission
                clearAllCheckboxes();
                setState(() {
                  loading = false;
                });
                Navigator.pushNamed(context, "followUpResult",
                    arguments: data['healthy']);
              } catch (e) {
                print(e);
              }
            }),
            SizedBox(height: 8),
            loading
                ? Center(
                    child: Container(
                        width: 40,
                        child: CircularProgressIndicator(
                          color: clr(1),
                        )))
                : Container()
          ],
        ),
      ),
    );
  }
}
