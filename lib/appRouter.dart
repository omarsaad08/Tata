import 'package:flutter/material.dart';
import 'package:tata/presentation/screens/auth/login.dart';
import 'package:tata/presentation/screens/auth/signup.dart';
import 'package:tata/presentation/screens/auth/userSetup.dart';
import 'package:tata/presentation/screens/baby/babyHome.dart';
import "package:tata/presentation/screens/auth/babySetup.dart";
import "package:tata/presentation/screens/auth/doctorSetup.dart";
import 'package:tata/presentation/screens/baby/doctorAvailability.dart';
import 'package:tata/presentation/screens/baby/doctorBookingDetails.dart';
import 'package:tata/presentation/screens/baby/followUpResult.dart';
import 'package:tata/presentation/screens/baby/offlineDoctorBooking.dart';
import 'package:tata/presentation/screens/baby/onlineDoctorBooking.dart';
import 'package:tata/presentation/screens/baby/periodicFollowUp.dart';
import 'package:tata/presentation/screens/baby/previousBookings.dart';
import 'package:tata/presentation/screens/doctor/doctorHome.dart';
import 'package:tata/presentation/screens/doctor/doctorPreviousBookings.dart';
import 'package:tata/presentation/screens/doctor/doctorUpcomingBookings.dart';
import 'package:tata/presentation/screens/doctor/notifications.dart';
import 'package:tata/presentation/screens/doctor/offlineBook.dart';
import 'package:tata/presentation/screens/doctor/onlineBook.dart';
import 'package:tata/presentation/screens/doctor/videoCall.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (context) => Login());
      case 'signup':
        return MaterialPageRoute(builder: (context) => Signup());
      case 'babyHome':
        return MaterialPageRoute(builder: (context) => BabyHome());
      case 'doctorHome':
        return MaterialPageRoute(builder: (context) => DoctorHome());
      case "userSetup":
        return MaterialPageRoute(builder: (context) => UserSetup());
      case "babySetup":
        return MaterialPageRoute(builder: (context) => BabySetup());
      case "doctorSetup":
        return MaterialPageRoute(builder: (context) => DoctorSetup());
      case "periodicFollowUp":
        return MaterialPageRoute(builder: (context) => PeriodicFollowUp());
      case "onlineDoctorBooking":
        return MaterialPageRoute(builder: (context) => OnlineDoctorBooking());
      case "offlineDoctorBooking":
        return MaterialPageRoute(builder: (context) => OfflineDoctorBooking());
      case "followUpResult":
        final score = settings.arguments as int;
        return MaterialPageRoute(builder: (context) => FollowUpResult(score: score));
      case "doctorBookingDetails":
        final doctor = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (context) => DoctorBookingDetails(doctor: doctor));
      case 'babyPreviousBookings':
        return MaterialPageRoute(builder: (context) => PreviousBookings());
      case 'doctorUpcomingBookings':
        return MaterialPageRoute(
            builder: (context) => DoctorUpcomingBookings());
      case 'doctorPreviousBookings':
        return MaterialPageRoute(
            builder: (context) => DoctorPreviousBookings());
      case 'doctorNotifications':
        return MaterialPageRoute(builder: (context) => DoctorNotifications());
      case 'offlineBook':
        final Map bookData = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => OfflineBook(
                  bookData: bookData,
                ));
      case 'onlineBook':
        final Map bookData = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => OnlineBook(bookData: bookData));
      case 'doctorAvailability':
        final int doctorId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => DoctorAvailabilityScreen(doctorId: doctorId));
      // case 'videoCall':
      // return MaterialPageRoute(builder: (context) => VideoCall());
    }
  }
}
