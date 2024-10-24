import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/data/storage.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart'; // For date formatting

class DoctorAvailabilityScreen extends StatefulWidget {
  final int doctorId;
  const DoctorAvailabilityScreen({Key? key, required this.doctorId})
      : super(key: key);

  @override
  _DoctorAvailabilityScreenState createState() =>
      _DoctorAvailabilityScreenState();
}

class _DoctorAvailabilityScreenState extends State<DoctorAvailabilityScreen> {
  bool isLoading = true;
  bool hasError = false;
  List<dynamic> availabilityData = [];
  List<dynamic> bookedAppointments = [];
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String? selectedDate;
  String? selectedTime;
  Map? bookingResponse;

  // Arabic names for the days and months
  final List<String> arabicDays = [
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  final List<String> arabicMonths = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  @override
  void initState() {
    super.initState();
    fetchDoctorAvailability();
  }

  Future<void> fetchDoctorAvailability() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.11:3000/doctorAvailability/week/${widget.doctorId}'));
      if (response.statusCode == 200) {
        print('data: ${response.body}');
        final data = jsonDecode(response.body);
        final booked = data['bookedAppointments'];
        setState(() {
          availabilityData = data['availability'];
          bookedAppointments = booked;
          isLoading = false;
          hasError = false;
        });
      } else {
        throw Exception('Failed to load availability');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  // Function to generate time slots with 30-minute intervals
  List<String> generateTimeSlots(String startTime, String endTime) {
    List<String> timeSlots = [];
    DateTime start = DateTime.parse("1970-01-01 $startTime");
    DateTime end = DateTime.parse("1970-01-01 $endTime");

    while (start.isBefore(end)) {
      timeSlots.add(DateFormat('HH:mm').format(start));
      start = start.add(Duration(minutes: 30)); // 30-minute interval
    }

    return timeSlots;
  }

  // Check if a time slot is booked
  bool isTimeSlotBooked(String date, String time) {
    return bookedAppointments.any((appointment) =>
        appointment['appointment_date'].startsWith(date) &&
        appointment['appointment_time'] == time);
  }

  // Function to handle slot selection
  void selectTimeSlot(String date, String time) {
    setState(() {
      selectedDate = date;
      selectedTime = time;
    });
  }

  String formatDateToArabic(DateTime date) {
    String day = arabicDays[date.weekday - 1];
    String month = arabicMonths[date.month - 1];
    return '$day, $month ${date.day}'; // e.g., "الإثنين, يناير 1"
  }

  List<String> getNextSevenDays() {
    DateTime today = DateTime.now();
    return List.generate(7, (index) {
      DateTime nextDay = today.add(Duration(days: index));
      return dateFormat.format(nextDay); // Return formatted date string
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حجز', style: TextStyle(color: clr(0))),
        backgroundColor: clr(1),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child:
                      Text('خطأ في تحميل المواعيد')) // Error message in Arabic
              : Column(
                  children: [
                    // Display week days as a vertical list
                    Expanded(
                      child: ListView.builder(
                        itemCount: getNextSevenDays().length,
                        itemBuilder: (context, index) {
                          String currentDate = getNextSevenDays()[index];
                          DateTime date = DateTime.parse(currentDate);

                          // Use proper weekday matching
                          List availableSlots = availabilityData.where((slot) {
                            int weekday = date
                                .weekday; // Get the actual weekday from Dart's DateTime
                            return slot['weekday'] ==
                                weekday; // Match the weekday directly
                          }).toList();

                          return Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: clr(1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    formatDateToArabic(date),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: clr(0)),
                                  ),
                                ),
                                Column(
                                  children: availableSlots.isEmpty
                                      ? [
                                          Text('لا توجد مواعيد',
                                              style: TextStyle(color: clr(0)))
                                        ] // No slots message in Arabic
                                      : availableSlots.map((slot) {
                                          String startTime = slot['start_time'];
                                          String endTime = slot['end_time'];
                                          List<String> timeSlots =
                                              generateTimeSlots(
                                                  startTime, endTime);
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: DropdownButton<String>(
                                                  hint: Text('اختر موعدًا',
                                                      style: TextStyle(
                                                          color: clr(
                                                              0))), // Select time hint in Arabic
                                                  value: selectedTime,
                                                  onChanged: (value) {
                                                    selectTimeSlot(
                                                        currentDate, value!);
                                                  },
                                                  items:
                                                      timeSlots.map((timeSlot) {
                                                    bool isBooked =
                                                        isTimeSlotBooked(
                                                            currentDate,
                                                            timeSlot);
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: isBooked
                                                          ? null
                                                          : timeSlot,
                                                      child: Text(
                                                        isBooked
                                                            ? '$timeSlot (محجوز)' // Booked label in Arabic
                                                            : timeSlot,
                                                        style: TextStyle(
                                                          color: isBooked
                                                              ? Colors.grey
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Display payment details under selected slot
                    if (selectedDate != null && selectedTime != null)
                      Container(
                        color: clr(2),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('التاريخ المختار: $selectedDate',
                                style: TextStyle(
                                    fontSize: 18)), // Selected date in Arabic
                            SizedBox(height: 8),
                            Text('الوقت المختار: $selectedTime',
                                style: TextStyle(
                                    fontSize: 18)), // Selected time in Arabic
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: mainElevatedButton(
                                    "احجز",
                                    () async {
                                      final baby_id =
                                          (await Storage.getIdAndType())['id'];
                                      final data = {
                                        "baby_id": baby_id,
                                        "doctor_id": widget.doctorId,
                                        "appointment_date": selectedDate,
                                        "appointment_time": selectedTime,
                                        "status": "requested",
                                        "type": null,
                                        "online": true
                                      };
                                      print('booking data: ${data}');
                                      bookingResponse =
                                          await BookingServices.bookADoctor(
                                              data);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            bookingResponse != null
                                ? Text(bookingResponse.toString())
                                : Container(),
                          ],
                        ),
                      ),
                  ],
                ),
    );
  }

  // Example function for Paymob integration (add your actual logic here)
  void initiatePaymobPayment() {
    // TODO: Integrate Paymob API for payment
    print('Initiating Paymob Payment for $selectedDate at $selectedTime');
  }
}
