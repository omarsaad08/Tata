import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  bool loading = false;
  String? errorMessage = null;

  Future login() async {
    setState(() {
      loading = true;
    });
    final user =
        await Auth.signIn(emailController.text, passwordController.text);
    print("user: $user");
    if (user != null) {
      final userType = (await Auth.getCurrentUser())!['role'];
      print("userType: $userType");
      if (userType != null) {
        print("user type: $userType");
        Navigator.pushReplacementNamed(context, "${userType}Home");
      }
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        errorMessage = "البريد الالكتروني او كلمة المرور خطأ";
        loading = false;
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
                  Text("تسجيل الدخول",
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

                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {}, child: Text("نسيت كلمة المرور؟")),
                    ],
                  ),
                  const SizedBox(height: 8),
                  loading ? CircularProgressIndicator() : Container(),
                  errorMessage != null ? Text(errorMessage!) : Container(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: mainElevatedButton("تسجيل الدخول", login),
                      ),
                    ],
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
