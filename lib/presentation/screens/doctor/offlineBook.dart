import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class OfflineBook extends StatefulWidget {
  final Map bookData;
  OfflineBook({super.key, required this.bookData});

  @override
  State<OfflineBook> createState() => _OfflineBookState();
}

class _OfflineBookState extends State<OfflineBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("حجز", style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: clr(1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("اسم الطفل: ${widget.bookData['baby']}",
                            style: TextStyle(
                                color: clr(0),
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: clr(2)),
                            child: Column(
                              children: [
                                Text(
                                    "${widget.bookData['date'].split('/')[0]}/${widget.bookData['date'].split('/')[1]}",
                                    style: TextStyle(
                                        color: clr(0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Text("${widget.bookData['date'].split('/')[2]}",
                                    style: TextStyle(color: clr(0))),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("الموعد: ${widget.bookData['time']}",
                        style: TextStyle(color: clr(0), fontSize: 18)),
                    Text(
                        "الحالة: ${widget.bookData['status'] == 0 ? "لم ينته" : widget.bookData['status'] == 1 ? "انتهى" : "تم الالغاء"}",
                        style: TextStyle(color: clr(0), fontSize: 18)),
                    Text("الدفع: ${widget.bookData['paid'] ? "تم" : "لم يتم"}",
                        style: TextStyle(color: clr(0), fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: mainElevatedButton("انهاء", () {}, color: clr(2)),
                  ),
                ],
              ),
              SizedBox(
                width: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: mainElevatedButton("الغاء", () {}, color: clr(2)),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
