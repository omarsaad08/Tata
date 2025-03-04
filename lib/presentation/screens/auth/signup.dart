import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';
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
  bool loading = false;

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
                  EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
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
                  Text("إنشاء حساب",
                      style: TextStyle(color: clr(0), fontSize: 20))
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
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
                          "إنشاء حساب",
                          () async {
                            setState(() {
                              loading = true;
                            });
                            try {
                              final authResponse = await Auth.signUp(
                                  emailController.text,
                                  passwordController.text);
                              if (authResponse.runtimeType == AuthException) {
                                setState(() {
                                  errorMessage = authResponse.toString();
                                });
                              }
                              if (authResponse != null &&
                                  authResponse.runtimeType != AuthException) {
                                Navigator.pushReplacementNamed(
                                    context, "userSetup");
                              } else {
                                throw Exception(authResponse);
                              }
                            } catch (e) {
                              setState(() {
                                loading = false;
                              });
                              print(e.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("error: $e")));
                            }
                          },
                        ),
                      ),
                    ],
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
                  const SizedBox(height: 16),
                  loading ? CircularProgressIndicator() : Container(),
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
