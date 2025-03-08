import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/presentation/components/theme.dart';

class BabyLanding extends StatefulWidget {
  const BabyLanding({super.key});

  @override
  State<BabyLanding> createState() => _BabyLandingState();
}

class _BabyLandingState extends State<BabyLanding> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: clr(0),
      child: ListView(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
              color: clr(3),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("اسم الطفل: محمد"),
              Text("الفئة العمرية: 0-3 شهور")
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: clr(1),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("اخر متابعة دورية", style: TextStyle(color: clr(0))),
                    Text("منذ: 10 ايام", style: TextStyle(color: clr(0))),
                    Text("التالية بعد: 4 ايام",
                        style: TextStyle(color: clr(0))),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: clr(2),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.calendar_tick5, size: 32, color: clr(0)),
                          SizedBox(height: 12),
                          Text("المتابعة الدورية",
                              style: TextStyle(
                                  color: clr(0),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "periodicFollowUp");
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: clr(1),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
              ]),
          child: Column(
            children: [
              Text(
                "الحالة الصحية: سليم",
                style: TextStyle(color: clr(0), fontWeight: FontWeight.w600),
              ),
              Text(
                "هل يحتاج كشف؟",
                style: TextStyle(color: clr(0), fontWeight: FontWeight.w600),
              ),
              Text(
                "لا",
                style: TextStyle(color: clr(0), fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: InkWell(
                  child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: clr(1),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2))
                          ]),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.hospital5,
                              size: 48,
                              color: clr(0),
                            ),
                            SizedBox(height: 12),
                            Text("حجز في مستشفى",
                                style: TextStyle(
                                    color: clr(0),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))
                          ])),
                  onTap: () {
                    Navigator.pushNamed(context, "offlineDoctorBooking");
                  }),
            )
          ],
        ),
      ]),
    );
  }
}
