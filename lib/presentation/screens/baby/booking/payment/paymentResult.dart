import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';

class PaymentResult extends StatefulWidget {
  final bool result;
  const PaymentResult({super.key, required this.result});

  @override
  State<PaymentResult> createState() => _PaymentResultState();
}

class _PaymentResultState extends State<PaymentResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: BookingServices.bookADoctor(BookingServices.bookingData!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('خطأ: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.result
                          ? Iconsax.tick_circle5
                          : Iconsax.close_circle5,
                      color:
                          widget.result ? Colors.greenAccent : Colors.redAccent,
                      size: 64,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                        widget.result
                            ? "تم الدفع وحجز جلستك بنجاح!"
                            : "لم يتم الدفع",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    mainElevatedButton("الرئيسية", () {
                      Navigator.pushReplacementNamed(context, 'babyHome');
                    })
                  ],
                ),
              );
            },
          );
        } else {
          return Text("unknown error");
        }
      },
    ));
  }
}
