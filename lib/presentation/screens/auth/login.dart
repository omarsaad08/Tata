import 'package:flutter/material.dart';
import 'package:tata/logic/auth.dart';
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
      appBar: AppBar(
        title: Text("تسجيل الدخول"),
        centerTitle: true,
        backgroundColor: clr(2),
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
              textDirection: TextDirection.rtl,
            ),

            const SizedBox(height: 8),
            errorMessage != null ? Text(errorMessage!) : Container(),
            const SizedBox(height: 24),
            // Login Button
            ElevatedButton(
              onPressed: () async {
                // Handle login logic
                final user = await Auth.signinWithEmail(
                    emailController.text, passwordController.text);
                if (user != null) {
                  Navigator.pushReplacementNamed(context, "userSetup");
                } else {
                  setState(() {
                    errorMessage = "البريد الالكتروني او كلمة المرور خطأ";
                  });
                }
              },
              child: const Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 18),
              ),
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
                'إنشاء حساب جديد',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
