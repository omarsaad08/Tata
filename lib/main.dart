import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/data/notificationHandler.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/appRouter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late String route;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
      url: "https://dnndzkbrszfuhhtvppuj.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRubmR6a2Jyc3pmdWhodHZwcHVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkwOTQ5NDQsImV4cCI6MjA1NDY3MDk0NH0.divvhyL00ZFImM2GcuOrzl5yp3uuWoOGaYJo0gyoemY");

  final user = await Auth.getCurrentUser();
  if (user != null) {
    await NotificationHandler.saveDoctorToken();
    route = '${user['role']}Home';
  } else {
    route = 'login';
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MainApp(
    appRouter: AppRouter(),
  ));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;
  const MainApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Rubik",
          colorScheme: ColorScheme.light(
            primary: clr(1),
          )),
      initialRoute: route,
      onGenerateRoute: appRouter.generateRoute,
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
