import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial(const Locale('ar', ''))) {
    on<InitializeLanguageEvent>(_onInitializeLanguage);
    on<ChangeLanguageEvent>(_onLanguageChanged);
  }

  Future<void> _onInitializeLanguage(
      InitializeLanguageEvent event, Emitter<LanguageState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String langCode = prefs.getString('languageCode') ?? 'ar';
    emit(LanguageUpdated(Locale(langCode, '')));
  }

  Future<void> _onLanguageChanged(
      ChangeLanguageEvent event, Emitter<LanguageState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', event.locale.languageCode);
    emit(LanguageUpdated(event.locale));
  }
}
