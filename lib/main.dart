import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:tata/appRouter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late String route;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://dnndzkbrszfuhhtvppuj.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRubmR6a2Jyc3pmdWhodHZwcHVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkwOTQ5NDQsImV4cCI6MjA1NDY3MDk0NH0.divvhyL00ZFImM2GcuOrzl5yp3uuWoOGaYJo0gyoemY");
  final user = await Auth.getCurrentUser();
  if (user != null) {
    route = '${user['type']}Home';
  } else {
    route = 'login';
  }
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
          fontFamily: "NotoSansArabic",
          colorScheme: ColorScheme.light(
            primary: clr(1),
          )),
      initialRoute: "login",
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
