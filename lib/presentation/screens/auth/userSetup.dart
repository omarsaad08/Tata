import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

class UserSetup extends StatelessWidget {
  const UserSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr(5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                child: Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: clr(1), borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/baby-girl.png",
                        width: 140,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("طفل", style: TextStyle(color: clr(0), fontSize: 28))
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "babySetup");
                }),
            InkWell(
              child: Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                    color: clr(4), borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/hospital-building.png",
                      width: 140,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text("مستشفى",
                        style: TextStyle(color: clr(-1), fontSize: 28))
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "hospitalSetup");
              },
            )
          ],
        ),
      ),
    );
  }
}
