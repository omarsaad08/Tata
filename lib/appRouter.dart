import 'package:flutter/material.dart';
import 'package:tata/presentation/screens/auth/login.dart';
import 'package:tata/presentation/screens/auth/signup.dart';
import 'package:tata/presentation/screens/auth/userSetup.dart';
import 'package:tata/presentation/screens/baby/babyHome.dart';
import "package:tata/presentation/screens/auth/babySetup.dart";
import "package:tata/presentation/screens/auth/hospitalSetup.dart";
import 'package:tata/presentation/screens/baby/doctorBookingDetails.dart';
import 'package:tata/presentation/screens/baby/followUpResult.dart';
import 'package:tata/presentation/screens/baby/offlineDoctorBooking.dart';
import 'package:tata/presentation/screens/baby/onlineDoctorBooking.dart';
import 'package:tata/presentation/screens/baby/periodicFollowUp.dart';
import 'package:tata/presentation/screens/baby/previousBookings.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (context) => Login());
      case 'signup':
        return MaterialPageRoute(builder: (context) => Signup());
      case 'babyHome':
        return MaterialPageRoute(builder: (context) => BabyHome());
      case "userSetup":
        return MaterialPageRoute(builder: (context) => UserSetup());
      case "babySetup":
        return MaterialPageRoute(builder: (context) => BabySetup());
      case "hospitalSetup":
        return MaterialPageRoute(builder: (context) => HospitalSetup());
      case "periodicFollowUp":
        return MaterialPageRoute(builder: (context) => PeriodicFollowUp());
      case "onlineDoctorBooking":
        return MaterialPageRoute(builder: (context) => OnlineDoctorBooking());
      case "offlineDoctorBooking":
        return MaterialPageRoute(builder: (context) => OfflineDoctorBooking());
      case "followUpResult":
        return MaterialPageRoute(builder: (context) => FollowUpResult());
      case "doctorBookingDetails":
        final doctor = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (context) => DoctorBookingDetails(doctor: doctor));
      case 'babyPreviousBookings':
        return MaterialPageRoute(builder: (context) => PreviousBookings());
    }
  }
}
