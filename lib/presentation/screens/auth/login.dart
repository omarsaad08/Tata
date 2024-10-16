import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  String? errorMessage = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("تسجيل الدخول", style: TextStyle(color: clr(0))),
      //   centerTitle: true,
      //   backgroundColor: clr(2),
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(top: 64, bottom: 32, left: 16, right: 16),
              decoration: BoxDecoration(
                  color: clr(1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Text("تسجيل الدخول",
                  style: TextStyle(color: clr(0), fontSize: 32)),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Image.asset(
                    'assets/login.png',
                    width: 160,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        errorMessage = null;
                      });
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        errorMessage = null;
                      });
                    },
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {}, child: Text("نسيت كلمة المرور؟")),
                    ],
                  ),
                  const SizedBox(height: 8),
                  errorMessage != null ? Text(errorMessage!) : Container(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: mainElevatedButton("تسجيل الدخول", () async {
                          // Handle login logic
                          final user = await Auth.signinWithEmail(
                              emailController.text, passwordController.text);
                          if (user != null) {
                            Navigator.pushReplacementNamed(
                                context, "userSetup");
                          } else {
                            setState(() {
                              errorMessage =
                                  "البريد الالكتروني او كلمة المرور خطأ";
                            });
                          }
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Google Sign-In Button
                  TextButton(
                    onPressed: () async {
                      final user = await Auth.signInWithGoogle();
                      if (user != null) {
                        Navigator.pushReplacementNamed(context, "userSetup");
                      } else {
                        setState(() {
                          errorMessage = "عذرا يوجد خطأ";
                        });
                      }
                    },
                    child: Image.asset(
                      'assets/icons8-google-48.png', // Add your Google logo asset path
                      // height: 24.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Sign-up Text
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "signup");
                    },
                    child: const Text(
                      'معندكش حساب؟ إنشاء حساب جديد',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
