import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/extensions/translation_extension.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'privacyPolicyDialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool loading = false;
  String? errorMessage;

  Future<void> handleAuthResponse(response) async {
    if (response != null) {
      final email = response.user?.email;
      final isVerified = response.user?.emailConfirmedAt != null;
      if (email != null) {
        if (isVerified) {
          if (mounted) {
            Navigator.pushReplacementNamed(context, "userSetup");
          }
        } else {
          if (mounted) {
            Navigator.pushReplacementNamed(context, "emailVerification",
                arguments: {"email": email});
          }
        }
      }
    } else {
      setState(() {
        errorMessage = context.tr("auth-failed");
      });
    }
  }

  bool validateForm() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      setState(() {
        errorMessage = context.tr("please-fill-fields");
      });
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        errorMessage = context.tr("passwords-dont-match");
      });
      return false;
    }

    if (passwordController.text.length < 6) {
      setState(() {
        errorMessage = context.tr("password-too-short");
      });
      return false;
    }

    return true;
  }

  Future<void> signUp() async {
    if (!validateForm()) return;

    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final response = await Auth.signUp(
        emailController.text,
        passwordController.text,
      );
      await handleAuthResponse(response);
    } catch (e) {
      setState(() {
        errorMessage = context.tr("signup-failed");
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
                top: 32,
                bottom: 32,
                left: 16,
                right: 16,
              ),
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
                    context.tr("signup-title"),
                    style: TextStyle(color: clr(0), fontSize: 32),
                  ),
                  Text(
                    context.tr("signup"),
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
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        errorMessage = null;
                      });
                    },
                    controller: confirmPasswordController,
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: context.tr("confirm-password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
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
                          context.tr("signup"),
                          loading
                              ? null
                              : () {
                                  signUp();
                                },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Privacy Policy message and button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            context.tr("by-signing-up-you-agree"),
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final markdown = await rootBundle
                                .loadString('assets/privacy-policy.md');
                            if (!mounted) return;
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  PrivacyPolicyDialog(markdownData: markdown),
                            );
                          },
                          child: Text(context.tr("privacy-policy")),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "login");
                    },
                    child: Text(
                      context.tr("have-account"),
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
