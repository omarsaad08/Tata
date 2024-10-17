import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tata/data/storage.dart';
import 'package:tata/firebase_options.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/appRouter.dart';
import 'package:firebase_auth/firebase_auth.dart';

late String route;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? user = FirebaseAuth.instance.currentUser;
  // routing
  if (user != null) {
    final data = await Storage.getIdAndType();
    print('data: ${data}');
    if (data['type'] == 'baby') {
      route = 'babyHome';
    } else if (data['type'] == 'doctor') {
      route = 'doctorHome';
    } else {
      route = 'userSetup';
    }
  } else {
    route = 'signup';
  }
  runApp(MainApp(
    appRouter: AppRouter(),
  ));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;
  // final User? user;
  const MainApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // fontFamily: "Hacen-Liner-Print-out",
          // fontFamily: "Cairo",
          // fontFamily: "NotoNaskhArabic",
          colorScheme: ColorScheme.light(
        primary: clr(1),
        // onPrimary: clr(5),
        // onSurface: clr(1),
      )),
      initialRoute: 'periodicFollowUp',
      onGenerateRoute: appRouter.generateRoute,
      // for making the app RTL
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
      ],
      locale: Locale("ar", "AE"),
    );
  }
}
