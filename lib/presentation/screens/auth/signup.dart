import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/presentation/screens/auth/privacyPolicyDialog.dart';

import 'package:flutter/services.dart' show rootBundle;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  void _showPrivacyPolicy() async {
    final markdownText = await rootBundle.loadString('privacy-policy.md');

    showDialog(
      context: context,
      builder: (context) => PrivacyPolicyDialog(
        markdownData: markdownText,
      ),
    );
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  String? errorMessage;
  bool loading = false;

  Future signUp() async {
    if (emailController.text != "" || passwordController.text != "") {
      setState(() {
        loading = true;
      });
      try {
        final doesUserExist = await Auth.doesUserExist(emailController.text);
        if (doesUserExist) {
          final doesDoctorExist =
              await Auth.doesUserExist(emailController.text, type: "doctor");
          final doesBabyExist =
              await Auth.doesUserExist(emailController.text, type: "baby");
          if (doesDoctorExist || doesBabyExist) {
            throw Exception("هذا الحساب مسجل بالفعل");
          } else {
            final user = await Auth.signIn(
                emailController.text, passwordController.text);
            if (user != null) {
              Navigator.pushReplacementNamed(context, "userSetup");
              setState(() {
                loading = false;
              });
            } else {
              setState(() {
                errorMessage = "هذا الحساب مسجل بالفعل لكن كلمة المرور خطأ";
                loading = false;
              });
            }
          }
        }
        final authResponse =
            await Auth.signUp(emailController.text, passwordController.text);
        if (authResponse.runtimeType == AuthException) {
          setState(() {
            errorMessage = authResponse.toString();
          });
        }
        if (authResponse != null && authResponse.runtimeType != AuthException) {
          Navigator.pushReplacementNamed(context, "userSetup");
        } else {
          throw Exception(authResponse);
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        print(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("error: $e")));
      }
    } else {
      setState(() {
        errorMessage = "اكتب الايميل وكلمة المرور";
      });
    }
  }

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
              height: 32,
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
                  Text("بتسجيل حسابك فأنت توافق على سياسة الخصوصية الخاصة بنا"),
                  TextButton(
                    onPressed: _showPrivacyPolicy,
                    child: const Text(
                      'عرض سياسة الخصوصية',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: mainElevatedButton(
                          "إنشاء حساب",
                          signUp,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
