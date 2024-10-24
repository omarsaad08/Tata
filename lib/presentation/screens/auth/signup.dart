import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/data/storage.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // final storage = FlutterSecureStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  String? errorMessage = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
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
              child: Text("إنشاء حساب",
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
                  const SizedBox(height: 8),
                  errorMessage != null ? Text(errorMessage!) : Container(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: mainElevatedButton(
                          "تسجيل الدخول",
                          () async {
                            final user = await Auth.signupWithEmail(
                                emailController.text, passwordController.text);
                            if (user == 0) {
                              await Storage.save('email', emailController.text);
                              Navigator.pushReplacementNamed(
                                  context, "userSetup");
                            } else if (user == 1) {
                              setState(() {
                                errorMessage = "كلمة المرور ضعيفة.";
                              });
                            } else if (user == 2) {
                              setState(() {
                                errorMessage =
                                    "هذا البريد الالكتروني مسجل مسبقا";
                              });
                            } else {
                              setState(() {
                                errorMessage = "عذرا يوجد خطأ";
                              });
                            }
                          },
                        ),
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
                      Navigator.popAndPushNamed(context, "login");
                    },
                    child: const Text(
                      'عندك حساب؟ سجل الدخول',
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
/*
Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            errorMessage != null ? Text(errorMessage!) : Container(),
            const SizedBox(height: 24),
            // Login Button
            ElevatedButton(
              onPressed: () async {
                // Handle login logic
                final user = await Auth.signupWithEmail(
                    emailController.text, passwordController.text);
                if (user == 0) {
                  Navigator.pushReplacementNamed(context, "userSetup");
                } else if (user == 1) {
                  setState(() {
                    errorMessage = "كلمة المرور ضعيفة.";
                  });
                } else if (user == 2) {
                  setState(() {
                    errorMessage = "هذا البريد الالكتروني مسجل مسبقا";
                  });
                } else {
                  setState(() {
                    errorMessage = "عذرا يوجد خطأ";
                  });
                }
              },
              child: const Text(
                'إنشاء حساب',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            // Google Sign-In Button
            ElevatedButton(
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
                child: Container(
                  padding: EdgeInsets.all(8),
                  // color: clr(4),
                  child: Image.asset(
                    'assets/icons8-google-48.png', // Add your Google logo asset path
                    // height: 24.0,
                  ),
                )),

            const SizedBox(height: 16),
            // Sign-up Text
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "login");
              },
              child: const Text(
                'عندك حساب؟ سجل الدخول',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
 */