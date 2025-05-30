import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/app_localizations.dart';
import 'package:tata/appRouter.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/firebase_options.dart';
import 'package:tata/logic/bloc/language_bloc.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:firebase_core/firebase_core.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Supabase
  await Supabase.initialize(
    url: "https://dnndzkbrszfuhhtvppuj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRubmR6a2Jyc3pmdWhodHZwcHVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkwOTQ5NDQsImV4cCI6MjA1NDY3MDk0NH0.divvhyL00ZFImM2GcuOrzl5yp3uuWoOGaYJo0gyoemY",
  );
  // Determine initial route
  final user = await Auth.getCurrentUser();
  if (user != null) {
    initialRoute = '${user['role']}Home';
  } else {
    initialRoute = 'login';
  }

  runApp(MainApp(appRouter: AppRouter()));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;
  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageBloc()..add(InitializeLanguageEvent()),
        ),
      ],
      child: AppView(appRouter: appRouter),
    );
  }
}

class AppView extends StatefulWidget {
  final AppRouter appRouter;
  const AppView({super.key, required this.appRouter});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "NotoSansArabic",
            colorScheme: ColorScheme.light(primary: clr(1)),
          ),
          initialRoute: initialRoute,
          onGenerateRoute: widget.appRouter.generateRoute,
          supportedLocales: const [Locale('ar', ''), Locale('en', '')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: state.locale, // 🌍 Set locale from Bloc state
        );
      },
    );
  }
}
/*
<meta name="monetag" content="7374593d7148f836fb6f268dbfb43439">
*/
