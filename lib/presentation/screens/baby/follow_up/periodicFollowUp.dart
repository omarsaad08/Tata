// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/data/periodicFollowUpServices.dart';
import 'package:tata/extensions/translation_extension.dart';
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
  late Future<FollowUp> followUpFuture;
  bool loading = false;
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    followUpFuture = FollowUp.create(3);
  }

  void _handleCheckboxChange(
      int index, bool? value, List<Map<String, dynamic>> checklistItems) {
    setState(() {
      checklistItems[index]['isChecked'] = value;
    });
  }

  void clearAllCheckboxes(FollowUp followUp) {
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

  void handleRadioChange(String value) async {
    setState(() {
      selectedOption = value;
      followUpFuture = FollowUp.create(int.parse(value));
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
          title: Text(context.tr("periodic-followup"),
              style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
      body: FutureBuilder<FollowUp>(
        future: followUpFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final followUp = snapshot.data!;

          return Container(
            padding: EdgeInsets.all(12),
            child: ListView(
              children: [
                Column(
                  children: <Widget>[
                    RadioListTile<String>(
                      title: Text(context.tr("age-group-3")),
                      value: '3',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(context.tr("age-group-6")),
                      value: '6',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(context.tr("age-group-9")),
                      value: '9',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(context.tr("age-group-12")),
                      value: '12',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text("من سن 12 الى 18 شهر"),
                      value: '18',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text("من سن 18 الى 24 شهر"),
                      value: '24',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text("من سن سنتين الى 3 سنوات"),
                      value: '36',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text("من سن 3 الى 4 سنوات"),
                      value: '48',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text("من سن 4 الى 5 سنوات"),
                      value: '60',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        handleRadioChange(value!);
                      },
                    ),
                    RadioListTile<String>(
                      title: Text("من سن 5 الى 6 سنوات"),
                      value: '72',
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
                  title: Text(context.tr("motor-milestones")),
                  leading: Image.asset("assets/motor-milestones.png"),
                  children: followUp.motorMilestones.map((item) {
                    int index = followUp.motorMilestones.indexOf(item);
                    return CheckboxListTile(
                      title: Text(context.tr(item['label'], fallback: "test")),
                      value: item['isChecked'],
                      onChanged: (bool? value) {
                        _handleCheckboxChange(
                            index, value, followUp.motorMilestones);
                      },
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  title: Text("علامات النمو الحسية"),
                  leading: Image.asset("assets/sensory-milestones.png"),
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
                  title: Text("علامات نمو التواصل"),
                  leading: Image.asset("assets/communication-milestones.png"),
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
                int.parse(selectedOption!) < 18
                    ? ExpansionTile(
                        title: Text("نقاط التغذية"),
                        leading: Image.asset("assets/feeding-milestones.png"),
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
                      )
                    : SizedBox(),
                SizedBox(height: 12),
                mainTextField(notesController, 'ملاحظات', Icon(Icons.notes)),
                SizedBox(height: 12),
                mainElevatedButton("العلامات التحذيرية", () {
                  Navigator.pushNamed(context, 'warningSigns');
                }, color: clr(2)),
                mainElevatedButton("تم", () async {
                  setState(() {
                    loading = true;
                  });
                  try {
                    followUp.age = int.parse(selectedOption!);
                    final values = followUp.generateValues();
                    print('going to get the user from the server');
                    final data = {
                      "baby_id":
                          (await Auth.getCurrentUser(type: 'baby'))!['id'],
                      "follow_up_date":
                          DateTime.now().toLocal().toString().split(' ')[0],
                      "motormilestones": values[0],
                      "feedingmilestones": values[1],
                      "communicationmilestones": values[2],
                      "sensorymilestones": values[3],
                      "healthy": followUp.healthy,
                      "notes": notesController.text,
                    };

                    print('data: $data');
                    final result =
                        await PeriodicFollowUpServices.addPeriodicFollowUp(
                            data);
                    print('result: $result');

                    final report = followUp.generateReport();
                    final motorScore = followUp.motorScore;
                    final sensoryScore = followUp.sensoryScore;
                    final feedingScore = followUp.feedingScore;
                    final communicationScore = followUp.communicationScore;

                    clearAllCheckboxes(followUp);
                    setState(() {
                      loading = false;
                    });

                    if (context.mounted) {
                      Navigator.pushNamed(
                        context,
                        "followUpResult",
                        arguments: {
                          'healthy': data['healthy'],
                          'motorScore': motorScore,
                          'sensoryScore': sensoryScore,
                          'feedingScore': feedingScore,
                          'communicationScore': communicationScore,
                          'reportDetails': report,
                        },
                      );
                    }
                  } catch (e) {
                    print(e);
                    setState(() {
                      loading = false;
                    });
                  }
                }),
                SizedBox(height: 8),
                loading
                    ? Center(
                        child: SizedBox(
                            width: 40,
                            child: CircularProgressIndicator(
                              color: clr(1),
                            )))
                    : Container()
              ],
            ),
          );
        },
      ),
    );
  }
}
