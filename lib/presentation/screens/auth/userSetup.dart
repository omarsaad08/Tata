import 'package:flutter/material.dart';

class UserSetup extends StatelessWidget {
  const UserSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting things up"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "babySetup");
              },
              child: Text("تسجيل طفل"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "hospitalSetup");
              },
              child: Text("تسجيل مستشفى"),
            )
          ],
        ),
      ),
    );
  }
}
