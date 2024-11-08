import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';

class BookingFinal extends StatefulWidget {
  final message;
  const BookingFinal({super.key, required this.message});

  @override
  State<BookingFinal> createState() => _BookingFinalState();
}

class _BookingFinalState extends State<BookingFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.message == 'تم حجز الجلسة بنجاح'
              ? Icons.check_circle_outlined
              : Icons.error_outline),
          Text(widget.message),
          mainElevatedButton("الرجوع للصفحة الرئيسية", () {
            Navigator.pushReplacementNamed(context, "babyHome");
          })
        ],
      ),
    ));
  }
}
