part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageSelectedState extends LanguageState {
  final Language language;
  final Translations translations;

  LanguageSelectedState({required this.language, required this.translations});

  @override
  List<Object> get props => [language];
}
