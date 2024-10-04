import 'package:flutter/material.dart';
import 'package:tata/logic/auth.dart';
import 'package:tata/presentation/components/theme.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  String? errorMessage = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body: Container(
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
    );
  }
}
