import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/presentation/screens/doctor/videoCall.dart';
// import 'package:permission_handler/permission_handler.dart';

class OnlineBook extends StatefulWidget {
  final Map bookData;
  OnlineBook({super.key, required this.bookData});

  @override
  State<OnlineBook> createState() => OnlineBookState();
}

class OnlineBookState extends State<OnlineBook> {
  // Future<void> requestPermissions() async {
  //   // Request camera and microphone permissions
  //   var status = await Permission.camera.request();
  //   if (status.isDenied) {
  //     // Handle denied permission case
  //     print('permission denied');
  //   }

  //   status = await Permission.microphone.request();
  //   if (status.isDenied) {
  //     // Handle denied permission case
  //     print('permission denied');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("حجز اونلاين", style: TextStyle(color: clr(0))),
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
                                color: clr(5)),
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
                    child: mainElevatedButton("الاتصال", () async {

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCall()));
                    }, color: clr(1)),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: mainElevatedButton("انهاء", () {}, color: clr(5)),
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
