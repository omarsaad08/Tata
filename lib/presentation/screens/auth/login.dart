import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/extensions/translation_extension.dart';
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
  String? errorMessage;

  Future<void> handleAuthResponse(response) async {
    if (response != null) {
      final email = response.user?.email;
      if (email != null) {
        final userExists = await Auth.doesUserExist(email);
        if (userExists) {
          final userType = (await Auth.getCurrentUser())!['role'];
          if (mounted && userType != null) {
            Navigator.pushReplacementNamed(context, "${userType}Home");
          }
        } else {
          if (mounted) {
            Navigator.pushReplacementNamed(context, "userSetup");
          }
        }
      }
    } else {
      setState(() {
        errorMessage = context.tr("auth-failed");
      });
    }
  }

  Future<void> login() async {
    setState(() {
      loading = true;
      errorMessage = null;
    });
    try {
      final response =
          await Auth.signIn(emailController.text, passwordController.text);
      await handleAuthResponse(response);
    } catch (e) {
      setState(() {
        errorMessage = context.tr("email-or-password-wrong");
      });
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 32, bottom: 32, left: 16, right: 16),
              decoration: BoxDecoration(
                color: clr(1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr("login-title"),
                    style: TextStyle(color: clr(0), fontSize: 32),
                  ),
                  Text(
                    context.tr("login"),
                    style: TextStyle(color: clr(0), fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      labelText: context.tr("email"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        errorMessage = null;
                      });
                    },
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: context.tr("password"),
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
                        onPressed: () {
                          Navigator.pushNamed(context, 'forgotPassword');
                        },
                        child: Text(context.tr("forget password")),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (loading) const CircularProgressIndicator(),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: mainElevatedButton(
                          context.tr("login"),
                          loading
                              ? null
                              : () {
                                  login();
                                },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "signup");
                    },
                    child: Text(
                      context.tr("don't have an account"),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
