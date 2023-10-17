import 'dart:async';
import 'package:book/data/datasources/translation_data_source.dart';
import 'package:book/data/models/translations.dart';
import 'package:book/data/repositories/language/language_repository.dart';
import 'package:book/domain/entities/language.dart';
import 'package:book/domain/usecases/language/get_selected_language.dart';
import 'package:book/domain/usecases/language/set_selected_language.dart';
import 'package:book/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository repository;
  final GetSelectedLanguage getSelectedLanguage;
  final SetSelectedLanguage setSelectedLanguage;

  LanguageBloc({required this.repository})
      : getSelectedLanguage = GetSelectedLanguage(repository),
        setSelectedLanguage = SetSelectedLanguage(repository),
        super(LanguageInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SelectLanguageEvent>(_onSelectLanguageEvent);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<LanguageState> emit) async {
    final language = await getSelectedLanguage();
    if (language != null) {
      final translationDataSource = TranslationDataSource();
      final translations =
          await translationDataSource.loadTranslations(language.code);
      emit(LanguageSelectedState(
          language: language, translations: translations));
    } else {
      emit(LanguageInitial());
    }
  }

  Future<void> _onSelectLanguageEvent(
      SelectLanguageEvent event, Emitter<LanguageState> emit) async {
    await setSelectedLanguage(event.language);
    final translationDataSource = TranslationDataSource();
    final Translations translations =
        await translationDataSource.loadTranslations(event.language.code);
    emit(LanguageSelectedState(
        language: event.language, translations: translations));
  }
}
