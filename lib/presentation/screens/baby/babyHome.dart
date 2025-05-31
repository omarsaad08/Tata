import 'package:flutter/material.dart';
import 'package:tata/extensions/translation_extension.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/presentation/screens/baby/follow_up/periodicFolowUpHistory.dart';
import 'package:tata/presentation/screens/baby/babyLanding.dart';
import 'package:tata/data/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tata/presentation/screens/baby/settings/settings.dart';

class BabyHome extends StatefulWidget {
  const BabyHome({super.key});

  @override
  State<BabyHome> createState() => _BabyHomeState();
}

class _BabyHomeState extends State<BabyHome> {
  int _selectedIndex = 0;
  bool? isEmailVerified;
  bool loading = true;
  String? resendMessage;
  bool resendLoading = false;

  @override
  void initState() {
    super.initState();
    checkEmailVerification();
  }

  Future<void> checkEmailVerification() async {
    final user = Auth.supabase.auth.currentUser;
    setState(() {
      isEmailVerified = user != null && user.emailConfirmedAt != null;
      loading = false;
    });
  }

  Future<void> resendVerification() async {
    setState(() {
      resendLoading = true;
      resendMessage = null;
    });
    final email = Auth.getCurrentUserEmail();
    if (email != null) {
      try {
        final result = await Auth.resendVerificationEmail(email);
        setState(() {
          resendLoading = false;
          resendMessage = result
              ? "تم إرسال رابط التحقق مرة أخرى إلى بريدك الإلكتروني."
              : "حدث خطأ أثناء إعادة إرسال رابط التحقق.";
        });
      } catch (e) {
        setState(() {
          resendLoading = false;
          final msg = e.toString();
          if (msg.contains('over_email_send_rate_limit') ||
              msg.contains('429')) {
            resendMessage =
                "لقد طلبت إعادة إرسال البريد الإلكتروني مؤخرًا. يرجى الانتظار قليلاً قبل المحاولة مرة أخرى.";
          } else {
            resendMessage = "حدث خطأ أثناء إعادة إرسال رابط التحقق.";
          }
        });
      }
    } else {
      setState(() {
        resendLoading = false;
        resendMessage = "تعذر العثور على البريد الإلكتروني للمستخدم.";
      });
    }
  }

  Future<void> logout() async {
    await Auth.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, "login");
    }
  }

  Future<void> openMailApp() async {
    final Uri mailtoUri = Uri(scheme: 'mailto');
    if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri, mode: LaunchMode.externalApplication);
    } else {
      // fallback: open mailto: in browser (works for web)
      await launchUrl(mailtoUri, mode: LaunchMode.platformDefault);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    BabyLanding(),
    PeriodicFollowUpHistory(),
    BabySettings(),
  ];

  void loginAgain() {
    Auth.signOut();
    Navigator.pushReplacementNamed(context, "login");
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (isEmailVerified == false) {
      // Restrict UI for unverified users
      return Scaffold(
        backgroundColor: clr(0),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mark_email_unread_rounded,
                    color: Colors.orange, size: 80),
                SizedBox(height: 32),
                Text(
                  "يرجى التحقق من بريدك الإلكتروني قبل استخدام التطبيق. سيتم إرسال رابط إعادة التحقق إلى بريدك الإلكتروني.",
                  style: TextStyle(fontSize: 20, color: clr(1)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  "إذا قمت بالتحقق من بريدك الإلكتروني بالفعل، يرجى تسجيل الدخول مرة أخرى.",
                  style: TextStyle(fontSize: 16, color: clr(2)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                if (resendLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton.icon(
                    icon: Icon(Icons.refresh, color: clr(0)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: clr(1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: resendVerification,
                    label: Text("إعادة إرسال رابط التحقق",
                        style: TextStyle(color: clr(0))),
                  ),
                if (resendMessage != null) ...[
                  SizedBox(height: 12),
                  Text(resendMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center),
                ],
                SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: Icon(Icons.login, color: clr(0)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: clr(2),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: loginAgain,
                  label: Text("تسجيل الدخول مرة أخرى",
                      style: TextStyle(color: clr(0))),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: Icon(Icons.logout, color: clr(0)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: logout,
                  label: Text("تسجيل الخروج", style: TextStyle(color: clr(0))),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // Normal home UI
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(context.tr("title"), style: TextStyle(color: clr(0))),
            centerTitle: true,
            backgroundColor: clr(1)),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: clr(2),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: clr(0),
          unselectedItemColor: clr(0),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home5, color: Colors.white),
              label: context.tr("home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.calendar_tick5),
              label: context.tr("periodic-followup"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: context.tr("profile"),
            ),
          ],
        ));
  }
}
