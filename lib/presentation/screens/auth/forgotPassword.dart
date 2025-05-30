import 'package:flutter/material.dart';
import 'package:tata/presentation/components/mainTextField.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("سوف يتم ارسال كود الى ايميلك للتأكد من ملكية الحساب"),
        mainTextField(emailController, "الايميل", Icon(Icons.email)),
        mainElevatedButton("ارسال", () {
          // Auth.sendOtpToEmail(emailController);
        })
      ],
    ));
  }
}
