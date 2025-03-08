import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class AvailabilityInput extends StatefulWidget {
  const AvailabilityInput({Key? key}) : super(key: key);

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
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void toggleDaySelection(int index) {
    setState(() {
      selectedDays.contains(index)
          ? selectedDays.remove(index)
          : selectedDays.add(index);
    });
  }

  Future<void> pickTime(bool isStartTime) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? startTime ?? TimeOfDay(hour: 9, minute: 0)
          : endTime ?? TimeOfDay(hour: 17, minute: 0),
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void saveAvailability() async {
    if (selectedDays.isEmpty || startTime == null || endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "يرجى تحديد الأيام وساعات العمل")), // "Please select days and working hours"
      );
      return;
    }
    final doctor = await Auth.getCurrentUser(type: "doctor");
    final availabilityData = {
      "doctor_id": doctor!['id'],
      "available_days": selectedDays,
      "start_time":
          "${startTime!.hour}:${startTime!.minute.toString().padLeft(2, '0')}",
      "end_time":
          "${endTime!.hour}:${endTime!.minute.toString().padLeft(2, '0')}"
    };

    final response = await supabase
        .from("doctor_availability")
        .insert(availabilityData)
        .select()
        .single();
    if (response['id'] != null) {
      Navigator.pushReplacementNamed(context, "doctorHome");
    }
  }

  Widget buildTimePickerTile(String title, TimeOfDay? time, bool isStartTime) {
    return GestureDetector(
      onTap: () => pickTime(isStartTime),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: clr(1), // Background color
          borderRadius: BorderRadius.circular(30), // Circular shape
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title: ${time != null ? time.format(context) : 'اختر وقتًا'}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Icon(Icons.access_time, color: Colors.white),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إعدادات المواعيد', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("اختر الأيام المتاحة",
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
            buildTimePickerTile("وقت البداية", startTime, true),
            SizedBox(height: 10),
            buildTimePickerTile("وقت النهاية", endTime, false),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: mainElevatedButton("حفظ", saveAvailability))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
