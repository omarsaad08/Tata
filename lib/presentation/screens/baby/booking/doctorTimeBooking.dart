import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorTimeBooking extends StatefulWidget {
  final int doctorId;
  const DoctorTimeBooking({super.key, required this.doctorId});
  @override
  _DoctorTimeBookingState createState() => _DoctorTimeBookingState();
}

class _DoctorTimeBookingState extends State<DoctorTimeBooking> {
  DateTime? selectedDate;
  String? selectedTime;
  List<String> bookedTimes =
      []; // This will be populated with booked times from snapshot.data
  List<String> availableTimes =
      []; // This will be populated based on the selected date

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:
          DateTime.now().add(Duration(days: 30)), // Limit to 30 days ahead
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        availableTimes = getAvailableTimes(pickedDate);
      });
    }
  }

  List<String> getAvailableTimes(DateTime date) {
    // Generate a list of times (in 24-hour format) for the dropdown
    List<String> allTimes = [];
    for (int hour = 8; hour <= 17; hour++) {
      // Example: from 08:00 to 17:00
      for (int minute = 0; minute < 60; minute += 30) {
        // 30-minute intervals
        String time =
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        if (!bookedTimes.contains(time)) {
          allTimes.add(time);
        }
      }
    }
    return allTimes;
  }

  void bookAppointment() {
    if (selectedDate != null && selectedTime != null) {
      // Logic to book the appointment, e.g., save to the server
      print(
          'Appointment booked on ${DateFormat.yMd().format(selectedDate!)} at $selectedTime');
    } else {
      print('Please select both date and time.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حجز موعد'), // Appointment Booking in Arabic
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('اختر التاريخ:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => selectDate(context),
              child: Text(selectedDate == null
                  ? 'اختر تاريخ'
                  : DateFormat.yMd().format(selectedDate!)),
            ),
            SizedBox(height: 16),
            Text('اختر الوقت:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              hint: Text('اختر وقت', style: TextStyle(fontSize: 16)),
              value: selectedTime,
              items: availableTimes.map((String time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTime = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: bookAppointment,
              child: Text('احجز الموعد'), // Book Appointment in Arabic
            ),
          ],
        ),
      ),
    );
  }
}
