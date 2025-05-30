import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/extensions/translation_extension.dart';
import 'package:tata/logic/bloc/language_bloc.dart';
import 'package:tata/presentation/components/theme.dart';
// import "dart:js_interop";

// @JS('window.location.reload')
// external void reloadPage(); // Calls JS function to refresh

class BabySettings extends StatefulWidget {
  const BabySettings({super.key});

  @override
  State<BabySettings> createState() => _BabySettingsState();
}

class _BabySettingsState extends State<BabySettings> {
  List screens = [
    // {
    //   "icon": Icon(Icons.language),
    //   "name": "change-language",
    //   "route": "changeLanguage"
    // },
    {"icon": Icon(Icons.logout), "name": "logout", "route": "logout"}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: ListView.builder(
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              if (screens[index]['route'] == "logout") {
                await Auth.signOut();
                Navigator.pushReplacementNamed(context, "login");
              } else if (screens[index]['route'] == "changeLanguage") {
                _toggleLanguage(context);
                // reloadPage();
              }
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: clr(3), borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    screens[index]['icon'],
                    SizedBox(width: 12),
                    Text(context.tr(screens[index]['name'])),
                  ],
                )),
          );
        },
      ),
    );
  }

  void _toggleLanguage(BuildContext context) {
    Locale currentLocale = context.read<LanguageBloc>().state.locale;
    Locale newLocale = currentLocale.languageCode == 'en'
        ? Locale('ar', '')
        : Locale('en', '');

    context.read<LanguageBloc>().add(ChangeLanguageEvent(newLocale));
  }
}
