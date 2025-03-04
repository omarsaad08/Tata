import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorAvailabilityInputScreen extends StatefulWidget {
  const DoctorAvailabilityInputScreen({Key? key}) : super(key: key);

  @override
  _DoctorAvailabilityInputScreenState createState() =>
      _DoctorAvailabilityInputScreenState();
}

class _DoctorAvailabilityInputScreenState
    extends State<DoctorAvailabilityInputScreen> {
  final List<String> daysOfWeek = [
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  final List<TimeOfDay> startTime = List.filled(7, TimeOfDay.now());
  final List<TimeOfDay> endTime = List.filled(7, TimeOfDay.now());
  final List<bool> onlineAvailability = List.filled(7, false);
  final List<bool> offlineAvailability = List.filled(7, false);

  void selectTime(BuildContext context, int index, bool isStart) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime[index] : endTime[index],
    );

    if (time != null) {
      setState(() {
        if (isStart) {
          startTime[index] = time;
        } else {
          endTime[index] = time;
        }
      });
    }
  }

  String formatTimeTo24Hour(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void saveAvailability() async {
    // Here you would save the availability data to your database
    final List<Map<String, dynamic>> availabilityList = [];

    for (int i = 0; i < daysOfWeek.length; i++) {
      // Mapping weekdays to integers
      int weekday = i + 1; // Monday is 1, Sunday is 7
      if (formatTimeTo24Hour(startTime[i]) != formatTimeTo24Hour(endTime[i])) {
        availabilityList.add({
          'doctor_id': (await Auth.getCurrentUser(type: "doctor"))!['id'],
          'weekday': weekday,
          'start_time':
              formatTimeTo24Hour(startTime[i]), // Save in 24-hour format
          'end_time': formatTimeTo24Hour(endTime[i]), // Save in 24-hour format
          'online': onlineAvailability[i],
          'offline': offlineAvailability[i],
        });
      }
    }
    await BookingServices.postDoctorAvailability(availabilityList);
    Navigator.pushReplacementNamed(context, "doctorHome");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('إعدادات المواعيد',
              style:
                  TextStyle(color: clr(0))), // Availability Settings in Arabic
          centerTitle: true,
          backgroundColor: clr(1)),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: clr(2)),
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    daysOfWeek[index],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('وقت البدء: ${startTime[index].format(context)}'),
                      mainElevatedButton(
                        'اختيار', // Select in Arabic
                        () => selectTime(context, index, true),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('وقت الانتهاء: ${endTime[index].format(context)}'),
                      mainElevatedButton(
                        'اختيار', // Select in Arabic
                        () => selectTime(context, index, false),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: onlineAvailability[index],
                        onChanged: (value) {
                          setState(() {
                            onlineAvailability[index] = value!;
                            // if (value)
                            //   offlineAvailability[index] =
                            //       false; // Only one can be true
                          });
                        },
                      ),
                      Text('متاح على الإنترنت'), // Available online in Arabic
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: offlineAvailability[index],
                        onChanged: (value) {
                          setState(() {
                            offlineAvailability[index] = value!;
                            // if (value)
                            //   onlineAvailability[index] =
                            //       false; // Only one can be true
                          });
                        },
                      ),
                      Text('متاح شخصيًا'), // Available offline in Arabic
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveAvailability,
        child: Icon(Icons.save),
        tooltip: 'حفظ', // Save in Arabic
      ),
    );
  }
}
