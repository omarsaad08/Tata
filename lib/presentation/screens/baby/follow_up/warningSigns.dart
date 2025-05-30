import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/models/warningSigns.dart';

class WarningSigns extends StatefulWidget {
  const WarningSigns({super.key});

  @override
  State<WarningSigns> createState() => _WarningSignsState();
}

class _WarningSignsState extends State<WarningSigns> {
  String? selectedOption = '3';
  Warnings warnings = Warnings(3);
  void handleRadioChange(String value) {
    setState(() {
      selectedOption = value;
      warnings.setup(int.parse(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('العلامات التحذيرية', style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
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
              int.parse(selectedOption!) < 18
                  ? Column(children: <Widget>[
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "علامات التحذير الحركية"), // Title of the foldable section
                        leading: Image.asset(
                            "assets/motor-milestones.png"), // Optional leading icon
                        children: warnings.motorSigns.map((item) {
                          int index = warnings.motorSigns.indexOf(item);
                          return Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [Text('- ${item.toString()}')],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 8),
                      ExpansionTile(
                        title: Text(
                            "علامات التحذير الحسية"), // Title of the foldable section
                        leading: Image.asset(
                            "assets/sensory-milestones.png"), // Optional leading icon
                        children: warnings.sensorySigns.map((item) {
                          int index = warnings.sensorySigns.indexOf(item);
                          return Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [Text('- ${item.toString()}')],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 8),
                      ExpansionTile(
                        title: Text(
                            "علامات التحذير التواصلية"), // Title of the foldable section
                        leading: Image.asset(
                            "assets/communication-milestones.png"), // Optional leading icon
                        children: warnings.communicationSigns.map((item) {
                          int index = warnings.communicationSigns.indexOf(item);
                          return Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [Text('- ${item.toString()}')],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 8),
                      ExpansionTile(
                        title: Text(
                            "علامات التحذير الغذائية"), // Title of the foldable section
                        leading: Image.asset(
                            "assets/feeding-milestones.png"), // Optional leading icon
                        children: warnings.feedingSigns.map((item) {
                          int index = warnings.feedingSigns.indexOf(item);
                          return Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [Text('- ${item.toString()}')],
                            ),
                          );
                        }).toList(),
                      ),
                      ExpansionTile(
                        title: Text("ردود أفعال أنعكاسية مهمة"),
                        leading: Image.asset("assets/motor-milestones.png"),
                        children: warnings.reflexes.map((item) {
                          int index = warnings.reflexes.indexOf(item);
                          return Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['name'],
                                    style: TextStyle(
                                        color: clr(1),
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 100, // Set an appropriate height
                                  child: ListView.builder(
                                    shrinkWrap:
                                        true, // Helps with nested scroll views
                                    physics:
                                        NeverScrollableScrollPhysics(), // Prevents independent scrolling
                                    itemCount: item['steps'].length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4.0),
                                        child:
                                            Text('* ${item['steps'][index]}'),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child:
                                      Text("امتى الأم تقلق: ${item['worry']}"),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ])
                  : ExpansionTile(
                      title: Text(
                          "علامات تحذير عامة"), // Title of the foldable section
                      leading: Image.asset(
                          "assets/feeding-milestones.png"), // Optional leading icon
                      children: warnings.generalSigns.map((item) {
                        int index = warnings.generalSigns.indexOf(item);
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [Text('- ${item.toString()}')],
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ));
  }
}
