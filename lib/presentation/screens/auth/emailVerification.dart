import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  const EmailVerificationScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool loading = false;
  String? message;

  Future<void> checkVerification() async {
    setState(() {
      loading = true;
      message = null;
    });
    final user = Auth.supabase.auth.currentUser;
    if (user != null && user.emailConfirmedAt != null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, "userSetup");
      }
    } else {
      setState(() {
        message =
            "لم يتم التحقق من البريد الإلكتروني بعد. يرجى التحقق من بريدك الإلكتروني.";
      });
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> resendVerification() async {
    setState(() {
      loading = true;
      message = null;
    });
    try {
      final result = await Auth.resendVerificationEmail(widget.email);
      setState(() {
        loading = false;
        message = result
            ? "تم إرسال رابط التحقق مرة أخرى إلى بريدك الإلكتروني."
            : "حدث خطأ أثناء إعادة إرسال رابط التحقق.";
      });
    } catch (e) {
      setState(() {
        loading = false;
        final msg = e.toString();
        if (msg.contains('over_email_send_rate_limit') || msg.contains('429')) {
          message =
              "لقد طلبت إعادة إرسال البريد الإلكتروني مؤخرًا. يرجى الانتظار قليلاً قبل المحاولة مرة أخرى.";
        } else {
          message = "حدث خطأ أثناء إعادة إرسال رابط التحقق.";
        }
      });
    }
  }

  void loginAgain() {
    Auth.signOut();
    Navigator.pushReplacementNamed(context, "login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr(0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email, size: 80, color: clr(1)),
              SizedBox(height: 24),
              Text(
                "يرجى التحقق من بريدك الإلكتروني",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: clr(1)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "لقد أرسلنا رابط تحقق إلى بريدك الإلكتروني: ${widget.email}",
                style: TextStyle(fontSize: 16, color: clr(2)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              if (loading) CircularProgressIndicator(),
              if (message != null) ...[
                Text(
                  message!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
              ],
              Text(
                " إذا قمت بالتحقق من بريدك الإلكتروني بالفعل، يرجى تسجيل الدخول مرة أخرى. ليمكنك استكمال انشاء الحساب",
                style: TextStyle(fontSize: 16, color: clr(2)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              mainElevatedButton("تحقق مرة أخرى", checkVerification),
              SizedBox(height: 12),
              mainElevatedButton("إعادة إرسال رابط التحقق", resendVerification),
              SizedBox(height: 24),
              mainElevatedButton("تسجيل الدخول مرة أخرى", loginAgain),
            ],
          ),
        ),
      ),
    );
  }
}
