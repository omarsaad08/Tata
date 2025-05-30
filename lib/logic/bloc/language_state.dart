part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState(this.locale);

  @override
  List<Object?> get props => [locale];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(super.locale);
}

class LanguageUpdated extends LanguageState {
  const LanguageUpdated(super.locale);
}
