import 'package:flutter/material.dart';
import 'package:tata/data/bookingPaymentServices.dart';
import 'package:tata/models/payment_method_model.dart';
import 'package:tata/presentation/components/theme.dart';

class BookingPayment extends StatefulWidget {
  const BookingPayment({super.key});

  @override
  State<BookingPayment> createState() => _BookingPaymentState();
}

class _BookingPaymentState extends State<BookingPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الدفع", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
      body: FutureBuilder(
        future: BookingPaymentServices.getPaymentMethod(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: clr(1)));
          } else if (snapshot.hasError) {
            // return Center(child: Text('Error: ${snapshot.error}'));
            return Container();
          } else {
            // Make sure to return the Row widget here
            return ListView.builder(
                itemCount: BookingPaymentServices.paymentMethod!.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      BookingPaymentServices.processPaymentMethod(
                          index, context);
                    },
                    title: Text(BookingPaymentServices
                        .paymentMethod!.data![index].nameEn!),
                    subtitle: Text(BookingPaymentServices
                        .paymentMethod!.data![index].nameAr!),
                    leading: Image.network(BookingPaymentServices
                        .paymentMethod!.data![index].logo!),
                  );
                });
          }
        },
      ),
    );
  }
}
