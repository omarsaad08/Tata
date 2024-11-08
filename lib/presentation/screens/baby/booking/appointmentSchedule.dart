// import 'package:flutter/material.dart';
// import 'package:tata/presentation/components/theme.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/calendar/v3.dart' as calendar;
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http; // Import the http package

// class Appointmentschedule extends StatefulWidget {
//   const Appointmentschedule({super.key});

//   @override
//   State<Appointmentschedule> createState() => _AppointmentscheduleState();
// }

// class _AppointmentscheduleState extends State<Appointmentschedule> {
//   Future<void> scheduleGoogleMeetAppointment() async {
//     // Assuming the user is already signed in
//     final GoogleSignIn googleSignIn = GoogleSignIn(
//       scopes: [calendar.CalendarApi.calendarScope],
//     );

//     // Retrieve the currently signed-in account
//     final GoogleSignInAccount? account = googleSignIn.currentUser;

//     if (account == null) {
//       print('User is not signed in.');
//       return; // User is not signed in, handle accordingly
//     }

//     // Get authentication headers
//     final authHeaders = await account.authHeaders;

//     // Create the authenticated client
//     final client = http.Client(); // Use the http.Client
//     final authClient = authenticatedClient(
//         client, AuthClient.fromHeaders(authHeaders)); // Create AuthClient

//     final calendarApi = calendar.CalendarApi(authClient);

//     // Create the event
//     final event = calendar.Event()
//       ..summary = "Appointment with Doctor"
//       ..description = "Doctor's appointment via Google Meet"
//       ..start = calendar.EventDateTime(
//         dateTime: DateTime.now().add(Duration(days: 1)),
//         timeZone: "UTC", // Set the appropriate time zone
//       )
//       ..end = calendar.EventDateTime(
//         dateTime: DateTime.now().add(Duration(days: 1, hours: 1)),
//         timeZone: "UTC", // Set the appropriate time zone
//       )
//       ..conferenceData = calendar.ConferenceData(
//         createRequest: calendar.CreateConferenceRequest(
//           requestId: 'some-unique-id', // Ensure this is unique for each request
//           conferenceSolutionKey:
//               calendar.ConferenceSolutionKey(type: "hangoutsMeet"),
//         ),
//       );

//     // Insert the event with conference details
//     try {
//       final createdEvent = await calendarApi.events.insert(
//         event,
//         calendarId: 'primary', // 'primary' means the user's main calendar
//         conferenceDataVersion: 1,
//       );

//       print('Google Meet link: ${createdEvent.hangoutLink}');
//     } catch (e) {
//       print('Error creating event: $e');
//     } finally {
//       // Close the client after use
//       client.close();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: Text("حجز المعاد", style: TextStyle(color: clr(0))),
//             centerTitle: true,
//             backgroundColor: clr(1)),
//         body: Column(
//           children: [],
//         ));
//   }
// }
