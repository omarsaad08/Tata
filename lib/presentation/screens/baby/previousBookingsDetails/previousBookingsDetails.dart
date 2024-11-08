import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/presentation/components/theme.dart';

class PreviousBookingsDetails extends StatefulWidget {
  final data;
  const PreviousBookingsDetails({super.key, required this.data});

  @override
  State<PreviousBookingsDetails> createState() =>
      _PreviousBookingsDetailsState();
}

class _PreviousBookingsDetailsState extends State<PreviousBookingsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('تفاصيل حجز سابق', style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  (widget.data['status'] == "مقبول" ||
                          widget.data['status'] == "منتهي")
                      ? Iconsax.tick_circle5
                      : Iconsax.close_circle5,
                  color: clr(1),
                  size: 72,
                ),
                SizedBox(height: 32),
                Text(widget.data['doctor_name'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text(widget.data['status']),
                SizedBox(height: 12),
                SizedBox(
                    width: 300,
                    height: 2,
                    child: Container(
                      color: clr(3),
                    )),
                SizedBox(height: 12),
                Text('تفاصيل الحجز'),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('رقم الحجز'),
                    Text(widget.data['appointment_id'].toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('التاريخ'),
                    Text(widget.data['appointment_date'].split('T')[0]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('وقت'),
                    Text(widget.data['appointment_date'].split('T')[0]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('النوع'),
                    Text(widget.data['type']),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('المكان'),
                    Text(widget.data['online'] ? "اونلاين" : 'العيادة'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('نوع الحجز'),
                    Text(widget.data['type']),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('نوع الحجز'),
                    Text(widget.data['type']),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('نوع الحجز'),
                    Text(widget.data['type']),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
