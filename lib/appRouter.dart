import 'package:flutter/material.dart';
import 'package:tata/presentation/screens/auth/login.dart';
import 'package:tata/presentation/screens/auth/signup.dart';
import 'package:tata/presentation/screens/auth/uploadImage.dart';
import 'package:tata/presentation/screens/auth/userSetup.dart';
import 'package:tata/presentation/screens/baby/babyHome.dart';
import "package:tata/presentation/screens/auth/babySetup.dart";
import "package:tata/presentation/screens/auth/doctorSetup.dart";
import 'package:tata/presentation/screens/baby/booking/doctorBookingDetails.dart';
import 'package:tata/presentation/screens/baby/booking/doctorTimeBooking.dart';
import 'package:tata/presentation/screens/baby/booking/bookingFinal.dart';
import 'package:tata/presentation/screens/baby/booking/doctorAvailability.dart';
import 'package:tata/presentation/screens/baby/booking/payment/bookingPayment.dart';
import 'package:tata/presentation/screens/baby/booking/payment/paymentResult.dart';
import 'package:tata/presentation/screens/baby/booking/payment/paymentWebView.dart';
import 'package:tata/presentation/screens/baby/follow_up/followUpResult.dart';
import 'package:tata/presentation/screens/baby/follow_up/warningSigns.dart';
import 'package:tata/presentation/screens/baby/nextAppointment/finishAppointment.dart';
import 'package:tata/presentation/screens/baby/nextAppointment/nextAppointment.dart';
import 'package:tata/presentation/screens/baby/booking/doctorBooking.dart';
import 'package:tata/presentation/screens/baby/booking/payment.dart';
import 'package:tata/presentation/screens/baby/follow_up/periodicFollowUp.dart';
import 'package:tata/presentation/screens/baby/previousBookingsDetails/previousBookings.dart';
import 'package:tata/presentation/screens/baby/previousBookingsDetails/previousBookingsDetails.dart';
// import 'package:tata/presentation/screens/baby/videoCallPage.dart';
import 'package:tata/presentation/screens/auth/availabilityInput.dart';
import 'package:tata/presentation/screens/doctor/doctorHome.dart';
import 'package:tata/presentation/screens/doctor/doctorPreviousBookings.dart';
import 'package:tata/presentation/screens/doctor/doctorUpcomingBookings.dart';
import 'package:tata/presentation/screens/doctor/nextAppointmentDoctor.dart';
import 'package:tata/presentation/screens/doctor/notifications.dart';
import 'package:tata/presentation/screens/doctor/offlineBook.dart';
import 'package:tata/presentation/screens/doctor/settings/settings.dart';

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
      case "offlineDoctorBooking":
        return MaterialPageRoute(builder: (context) => OfflineDoctorBooking());
      case "followUpResult":
        final healthy = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (context) => FollowUpResult(healthy: healthy));
      case 'warningSigns':
        return MaterialPageRoute(builder: (context) => WarningSigns());
      case "doctorBookingDetails":
        final doctor = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => DoctorBookingDetails(doctor: doctor));
      case 'babyPreviousBookings':
        return MaterialPageRoute(builder: (context) => PreviousBookings());
      case 'babyPreviousBookingsDetails':
        final bookingData = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => PreviousBookingsDetails(data: bookingData));
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
      case 'doctorAvailability':
        final int doctorId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => DoctorAvailabilityScreen(doctorId: doctorId));
      case 'nextAppointment':
        final data = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => NextAppointment(appointment: data));
      case 'nextAppointmentDoctor':
        final data = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => NextAppointmentDoctor(appointment: data));
      case 'inputAvailability':
        return MaterialPageRoute(builder: (context) => AvailabilityInput());
      case 'doctorSettings':
        return MaterialPageRoute(builder: (context) => DoctorSettings());
      case 'doctorTimeBooking':
        final doctorId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => DoctorTimeBooking(doctorId: doctorId));
      case 'paymentGateway':
        final data = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) =>
                Payment(url: data['url'], data: data['data']));
      case 'bookingFinal':
        final data = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BookingFinal(message: data['message']));
      case 'finishAppointment':
        final appointment = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => FinishAppointment(
                  appointment: appointment,
                ));
      case 'bookingPayment':
        return MaterialPageRoute(builder: (context) => BookingPayment());
      case 'paymentWebView':
        final url = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => PaymentWebView(url: url));
      case 'paymentResult':
        final result = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (context) => PaymentResult(result: result));
      case 'uploadImage':
        return MaterialPageRoute(builder: (context) => UploadImageScreen());
    }
  }
}
