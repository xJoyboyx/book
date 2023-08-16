part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends LanguageEvent {}

class SelectLanguageEvent extends LanguageEvent {
  final Language language;

  SelectLanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}
