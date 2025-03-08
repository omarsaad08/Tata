import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'dart:math';
import 'package:tata/presentation/components/theme.dart';

class DoctorAvailabilityScreen extends StatefulWidget {
  final int doctorId;
  const DoctorAvailabilityScreen({Key? key, required this.doctorId})
      : super(key: key);

  @override
  _DoctorAvailabilityScreenState createState() =>
      _DoctorAvailabilityScreenState();
}

class _DoctorAvailabilityScreenState extends State<DoctorAvailabilityScreen> {
  final supabase = Supabase.instance.client;
  List<DateTime> availableDays = [];
  List<String> availableTimes = [];
  DateTime? selectedDate;
  int selectedTimeIndex = 0;
  String appointmentType = "online";
  bool isLoading = true;
  String message = '';
  @override
  void initState() {
    super.initState();
    fetchAvailableDaysAndTimes();
  }

  String generateRoomId() {
    const String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random random = Random();
    return String.fromCharCodes(
      List.generate(
          8, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  Future<void> fetchAvailableDaysAndTimes() async {
    try {
      final response = await supabase
          .from('doctor_availability')
          .select('available_days, start_time, end_time')
          .eq('doctor_id', widget.doctorId)
          .single();

      if (response == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      List<int> days = List<int>.from(response['available_days']);
      String startTimeStr = response['start_time'];
      String endTimeStr = response['end_time'];

      DateTime now = DateTime.now();
      int todayIndex = (now.weekday % 7) + 1;

      List<DateTime> availableDateList = days.map((d) {
        int difference = (d - todayIndex) % 7;
        return now.add(
            Duration(days: difference >= 0 ? difference : (difference + 7)));
      }).toList();
      availableDateList.sort();

      DateTime startTime = DateFormat('HH:mm').parse(startTimeStr);
      DateTime endTime = DateFormat('HH:mm').parse(endTimeStr);

      List<String> times = [];
      DateTime current = startTime;
      while (current.isBefore(endTime)) {
        times.add(
            DateFormat('h:mm a', 'ar').format(current)); // Arabic time format
        current = current.add(const Duration(minutes: 30));
      }

      setState(() {
        availableDays = availableDateList;
        availableTimes = times;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching available days and times: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void bookAppointment() async {
    if (selectedDate == null || availableTimes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى اختيار اليوم والوقت")),
      );
      return;
    }

    // Convert Arabic time format back to 24-hour format (HH:mm)
    DateTime parsedTime =
        DateFormat('hh:mm a', 'ar').parse(availableTimes[selectedTimeIndex]);
    String formattedTime = DateFormat('HH:mm').format(parsedTime);
    final bookingData = {
      "doctor_id": widget.doctorId,
      "date": DateFormat('yyyy-MM-dd').format(selectedDate!),
      "time": formattedTime,
      "place": appointmentType,
      "roomid": generateRoomId(),
      "status": "requested",
      "type": "examination"
    };

    final response = await supabase
        .from("appointments")
        .insert(bookingData)
        .select()
        .single();
    if (response['appointment_id'] != null) {
      setState(() {
        message = "تم طلب حجز الجلسة بنجاح. سنخبركم عندما يوافق الطبيب عليها";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حجز', style: TextStyle(color: Colors.white)),
        backgroundColor: clr(1),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("اختر اليوم",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  availableDays.isEmpty
                      ? Text("لا يوجد أيام متاحة",
                          style: TextStyle(color: Colors.red))
                      : Wrap(
                          spacing: 10,
                          children: availableDays.map((date) {
                            return ChoiceChip(
                              label:
                                  Text(DateFormat('EEEE', 'ar').format(date)),
                              selected: selectedDate == date,
                              onSelected: (selected) {
                                setState(() {
                                  selectedDate = date;
                                  selectedTimeIndex = 0;
                                });
                              },
                              selectedColor: clr(1),
                              backgroundColor: Colors.grey[300],
                              labelStyle: TextStyle(
                                  color: selectedDate == date
                                      ? Colors.white
                                      : Colors.black),
                            );
                          }).toList(),
                        ),
                  SizedBox(height: 20),
                  if (availableTimes.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("اختر الوقت",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: selectedTimeIndex > 0
                                  ? () {
                                      setState(() {
                                        selectedTimeIndex--;
                                      });
                                    }
                                  : null,
                            ),
                            Text(availableTimes[selectedTimeIndex],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed:
                                  selectedTimeIndex < availableTimes.length - 1
                                      ? () {
                                          setState(() {
                                            selectedTimeIndex++;
                                          });
                                        }
                                      : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  Text("نوع الفحص",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: "online",
                        groupValue: appointmentType,
                        onChanged: (value) =>
                            setState(() => appointmentType = value!),
                      ),
                      Text("أونلاين"),
                      Radio(
                        value: "offline",
                        groupValue: appointmentType,
                        onChanged: (value) =>
                            setState(() => appointmentType = value!),
                      ),
                      Text("في العيادة"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: mainElevatedButton("طلب حجز", bookAppointment))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  message != ''
                      ? Text(
                          message,
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
