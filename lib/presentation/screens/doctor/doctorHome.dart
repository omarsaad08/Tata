import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/data/doctorServices.dart';
import 'package:tata/data/userServices.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/presentation/screens/doctor/settings/settings.dart';
import 'package:tata/data/auth.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
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
    final user = await Auth.getCurrentUser();
    setState(() {
      isEmailVerified = user != null && user['email_confirmed_at'] != null;
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
      final result = await Auth.resendVerificationEmail(email);
      setState(() {
        resendLoading = false;
        resendMessage = result
            ? "تم إرسال رابط التحقق مرة أخرى إلى بريدك الإلكتروني."
            : "حدث خطأ أثناء إعادة إرسال رابط التحقق.";
      });
    } else {
      setState(() {
        resendLoading = false;
        resendMessage = "تعذر العثور على البريد الإلكتروني للمستخدم.";
      });
    }
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => DoctorSettings()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    Home(),
    DoctorSettings(),
  ];
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
                SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: Icon(Icons.settings, color: clr(0)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: clr(2),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _openSettings,
                  label: Text("الإعدادات / تسجيل الخروج",
                      style: TextStyle(color: clr(0))),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // Normal home UI
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: clr(1),
          padding: EdgeInsets.all(20),
        ),
        onPressed: () async {
          Navigator.pushNamed(context, "doctorNotifications");
        },
        label: Icon(
          Icons.notifications,
          size: 24,
          color: clr(0),
        ),
      ),
      appBar: AppBar(
        title: Text("تاتا", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
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
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: FutureBuilder(
                future: UserServices.getUserImage(40),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasError ||
                      !snapshot.hasData) {
                    return Icon(Icons.person);
                  } else {
                    return snapshot.data!;
                  }
                }),
            label: 'الحساب',
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic>? user;
  List<dynamic>? appointments;
  bool isUserLoading = true;
  bool isAppointmentsLoading = true;
  String? userError;
  String? appointmentsError;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch user and appointments in parallel
      final userFuture = UserServices.fetchFullUserData();
      final appointmentsFuture = DoctorServices.getTodaysAppointments();

      final List results = await Future.wait([userFuture, appointmentsFuture]);

      setState(() {
        user = results[0];
        isUserLoading = false;
      });

      setState(() {
        appointments = results[1];
        isAppointmentsLoading = false;
      });
    } catch (e) {
      setState(() {
        isUserLoading = false;
        isAppointmentsLoading = false;
        userError = "حدث خطأ في تحميل البيانات";
        appointmentsError = "حدث خطأ في تحميل الحجوزات";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // User Info
          if (isUserLoading)
            Center(child: Text("..."))
          else if (userError != null)
            Center(child: Text(userError!))
          else
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: clr(3),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("أهلاً دكتور ${user!['name']}!"),
                  Text("التخصص: ${user!['doctor']['speciality']}"),
                ],
              ),
            ),

          SizedBox(height: 16),
          FutureBuilder(
              future: DoctorServices.getNextAppointment(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Row(
                    children: [
                      Expanded(
                          child: mainElevatedButton("الحجز القادم", () {
                        Navigator.pushNamed(context, "nextAppointmentDoctor",
                            arguments: snapshot.data);
                      }))
                    ],
                  );
                }
              }),
          Text("حجوزات اليوم",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),

          // Appointments
          if (isAppointmentsLoading)
            Center(child: CircularProgressIndicator())
          else if (appointmentsError != null)
            Center(child: Text(appointmentsError!))
          else if (appointments == null || appointments!.isEmpty)
            Center(child: Text("لا يوجد حجوزات اليوم"))
          else
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: appointments!.length,
                itemBuilder: (context, index) {
                  final appointment = appointments![index];
                  return Container(
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: clr(1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            appointment['type'] == "examination"
                                ? "كشف"
                                : "جلسة",
                            style: TextStyle(
                                color: clr(0), fontWeight: FontWeight.bold)),
                        Text("الوقت: ${appointment['time']}",
                            style: TextStyle(color: clr(0))),
                        Text(
                          "الحالة: ${_getAppointmentStatus(appointment['status'])}",
                          style: TextStyle(color: clr(0)),
                        ),
                        SizedBox(height: 8),
                        mainElevatedButton("الدخول", () {
                          Navigator.pushNamed(context, "enterAppointment",
                              arguments: appointment);
                        }, color: clr(2))
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  String _getAppointmentStatus(String status) {
    switch (status) {
      case "pending":
        return "في الانتظار";
      case "canceled":
        return "ملغي";
      case "finished":
        return "منتهي";
      default:
        return "";
    }
  }
}
