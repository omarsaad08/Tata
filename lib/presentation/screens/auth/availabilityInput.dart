import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/extensions/translation_extension.dart';

class AvailabilityInput extends StatefulWidget {
  const AvailabilityInput({super.key});

  @override
  _AvailabilityInputState createState() => _AvailabilityInputState();
}

class _AvailabilityInputState extends State<AvailabilityInput> {
  final supabase = Supabase.instance.client;
  final List<String> weekDaysArabic = [
    "السبت",
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة"
  ];

  List<int> selectedDays = [];
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  String startAmPm = 'ص'; // Default AM/PM for start time (ص = AM)
  String endAmPm = 'ص'; // Default AM/PM for end time (ص = AM)

  void toggleDaySelection(int index) {
    setState(() {
      selectedDays.contains(index)
          ? selectedDays.remove(index)
          : selectedDays.add(index);
    });
  }

  bool validateTimeFormat(String time) {
    // Validate 12-hour time format (hh:mm)
    final RegExp timeRegex = RegExp(r'^(0?[1-9]|1[0-2]):[0-5][0-9]$');
    return timeRegex.hasMatch(time);
  }

  String convertTo24HourFormat(String time, String amPm) {
    // Convert 12-hour time to 24-hour format
    final format = DateFormat('hh:mm a');
    final dateTime = format.parse('$time ${amPm == 'ص' ? 'AM' : 'PM'}');
    return DateFormat('HH:mm').format(dateTime);
  }

  void saveAvailability() async {
    // Validate selected days
    if (selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى تحديد الأيام المتاحة")),
      );
      return;
    }

    // Validate start time
    if (startTimeController.text.isEmpty ||
        !validateTimeFormat(startTimeController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى إدخال وقت بداية صحيح (hh:mm)")),
      );
      return;
    }

    // Validate end time
    if (endTimeController.text.isEmpty ||
        !validateTimeFormat(endTimeController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى إدخال وقت نهاية صحيح (hh:mm)")),
      );
      return;
    }

    // Convert 12-hour time to 24-hour format
    final startTime24 =
        convertTo24HourFormat(startTimeController.text, startAmPm);
    final endTime24 = convertTo24HourFormat(endTimeController.text, endAmPm);

    // Ensure end time is after start time
    final start = DateFormat('HH:mm').parse(startTime24);
    final end = DateFormat('HH:mm').parse(endTime24);
    if (end.isBefore(start)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("وقت النهاية يجب أن يكون بعد وقت البداية")),
      );
      return;
    }

    // Save availability
    final doctor = await Auth.getCurrentUser(type: "doctor");
    final availabilityData = {
      "doctor_id": doctor!['id'],
      "available_days": selectedDays,
      "start_time": startTime24,
      "end_time": endTime24,
    };

    final response = await supabase
        .from("doctor_availability")
        .insert(availabilityData)
        .select()
        .single();
    if (response['id'] != null) {
      Navigator.pushReplacementNamed(context, "uploadImage");
    }
  }

  Widget buildTimeInputRow(String label, TextEditingController controller,
      String amPm, Function(String) onAmPmChanged) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.access_time),
            ),
            keyboardType: TextInputType.datetime,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<String>(
                value: 'ص',
                groupValue: amPm,
                onChanged: (value) => onAmPmChanged(value!),
              ),
              Text(context.tr("am")), // AM in Arabic
              Radio<String>(
                value: 'م',
                groupValue: amPm,
                onChanged: (value) => onAmPmChanged(value!),
              ),
              Text(context.tr("pm")), // PM in Arabic
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("time-settings"),
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.tr("choose-available-days"),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(weekDaysArabic.length, (index) {
                return ChoiceChip(
                  label: Text(weekDaysArabic[index]),
                  selected: selectedDays.contains(index),
                  onSelected: (selected) => toggleDaySelection(index),
                  selectedColor: clr(1),
                  backgroundColor: Colors.grey[300],
                  labelStyle: TextStyle(
                      color: selectedDays.contains(index)
                          ? Colors.white
                          : Colors.black),
                );
              }),
            ),
            SizedBox(height: 20),
            buildTimeInputRow(
              "${context.tr("start-time")} (12:00)",
              startTimeController,
              startAmPm,
              (value) => setState(() => startAmPm = value),
            ),
            SizedBox(height: 10),
            buildTimeInputRow(
              "${context.tr("end-time")} (12:00)",
              endTimeController,
              endAmPm,
              (value) => setState(() => endAmPm = value),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: mainElevatedButton(
                        context.tr("done"), saveAvailability))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
