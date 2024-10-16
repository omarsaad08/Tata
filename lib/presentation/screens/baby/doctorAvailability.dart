import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tata/data/bookingServices.dart'; // For date formatting

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
  @override
  void initState() {
    super.initState();
    fetchDoctorAvailability();
  }

  Future<void> fetchDoctorAvailability() async {
    try {
      final response = await dio
          .get('http://192.168.103.224:3000/doctorAvailability/week/1');
      if (response.statusCode == 200) {
        print('data: ${response.data}');
        final data = response.data['availability'];
        final booked = response.data['bookedAppointments'];
        setState(() {
          availabilityData = data;
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

  // Function to generate 15-minute intervals
  List<String> generateTimeSlots(String startTime, String endTime) {
    List<String> timeSlots = [];
    DateTime start = DateTime.parse("1970-01-01 $startTime");
    DateTime end = DateTime.parse("1970-01-01 $endTime");

    while (start.isBefore(end)) {
      timeSlots.add(DateFormat('HH:mm').format(start));
      start = start.add(Duration(minutes: 15)); // 15-minute interval
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

  List<String> getNextSevenDays() {
    DateTime today = DateTime.now();
    return List.generate(7, (index) {
      return dateFormat.format(today.add(Duration(days: index)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctor Availability')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text('Error loading availability'))
              : Column(
                  children: [
                    // Display week days as a horizontal list
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: getNextSevenDays().length,
                        itemBuilder: (context, index) {
                          String currentDate = getNextSevenDays()[index];
                          // Filter availability by date
                          List availableSlots = availabilityData.where((slot) {
                            return slot['weekday'] ==
                                DateTime.parse(currentDate).weekday;
                          }).toList();

                          return Container(
                            width: 120,
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('EEE, MMM d')
                                      .format(DateTime.parse(currentDate)),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: availableSlots.isEmpty
                                      ? Center(child: Text('No Slots'))
                                      : ListView.builder(
                                          itemCount: availableSlots.length,
                                          itemBuilder: (context, slotIndex) {
                                            String startTime =
                                                availableSlots[slotIndex]
                                                    ['start_time'];
                                            String endTime =
                                                availableSlots[slotIndex]
                                                    ['end_time'];
                                            List<String> timeSlots =
                                                generateTimeSlots(
                                                    startTime, endTime);

                                            return Column(
                                              children:
                                                  timeSlots.map((timeSlot) {
                                                bool isBooked =
                                                    isTimeSlotBooked(
                                                        currentDate, timeSlot);
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  child: ElevatedButton(
                                                    onPressed: isBooked
                                                        ? null // Disable if the slot is booked
                                                        : () => selectTimeSlot(
                                                            currentDate,
                                                            timeSlot),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: isBooked
                                                          ? Colors
                                                              .grey // Grey for booked slots
                                                          : Colors
                                                              .blue, // Blue for available slots
                                                    ),
                                                    child: Text(
                                                      timeSlot,
                                                      style: TextStyle(
                                                        color: isBooked
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Display payment details under selected slot
                    if (selectedDate != null && selectedTime != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Selected Date: $selectedDate'),
                            Text('Selected Time: $selectedTime'),
                            SizedBox(height: 20),
                            // Add payment details form or Paymob integration widget here
                            Text('Proceed '),
                            ElevatedButton(
                              onPressed: () async {
                                // Call Paymob integration function
                                // initiatePaymobPayment(); disabled for later
                                final data = {
                                  "baby_id": "1",
                                  "doctor_id": "1",
                                  "appointment_date": " 2024-10-15",
                                  "appointment_time": "9:00:00"
                                };
                                bookingResponse =
                                    await BookingServices.bookADoctor(data);
                              },
                              child: Text('book'),
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
