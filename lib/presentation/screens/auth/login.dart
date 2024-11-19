import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/data/storage.dart';
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
  String _selectedOption = "طفل";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("إبدأ أول تاتا",
                      style: TextStyle(color: clr(0), fontSize: 32)),
                  SizedBox(
                    height: 12,
                  ),
                  Text("تسجيل الدخول",
                      style: TextStyle(color: clr(0), fontSize: 24))
                ],
              ),
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
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'دكتور',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                          ),
                          const Text('دكتور'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "طفل",
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                          ),
                          const Text('طفل'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: mainElevatedButton("تسجيل الدخول", () async {
                          // Handle login logic
                          final user = await Auth.signinWithEmail(
                              emailController.text, passwordController.text);
                          if (user != null) {
                            await Storage.save('email', emailController.text);
                            // get user data
                            final result = await Auth.getUserWithEmail(
                                emailController.text,
                                _selectedOption == "دكتور" ? "doctor" : "baby");
                            if (result != null) {
                              await Storage.save('id', result['id'].toString());
                              await Storage.save(
                                  'type',
                                  _selectedOption == "دكتور"
                                      ? "doctor"
                                      : "baby");
                              Navigator.pushReplacementNamed(context,
                                  "${_selectedOption == "دكتور" ? "doctor" : "baby"}Home");
                            }
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
                        await Storage.save('email', user.email!);
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
