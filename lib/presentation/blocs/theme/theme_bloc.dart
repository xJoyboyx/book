import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book/domain/usecases/theme/get_theme.dart';
import 'package:book/domain/usecases/theme/set_theme.dart';
import 'package:book/themes/app_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SetSelectedTheme setSelectedTheme;
  final GetSelectedTheme getSelectedTheme;

  ThemeBloc({required this.setSelectedTheme, required this.getSelectedTheme})
      : super(ThemeState(themeData: AppThemes.theme1)) {
    on<ThemeChanged>(_onThemeChanged);
    on<LoadThemeEvent>(_onLoadTheme);
  }

  Future<void> _onThemeChanged(
      ThemeChanged event, Emitter<ThemeState> emit) async {
    await setSelectedTheme(event.themeId);
    emit(ThemeState(themeData: AppThemes.getThemeById(event.themeId)));
  }

  Future<void> _onLoadTheme(
      LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final themeId = getSelectedTheme();
    if (themeId != null) {
      emit(ThemeState(themeData: AppThemes.getThemeById(themeId)));
    } else {
      emit(ThemeState(themeData: AppThemes.theme1));
    }
  }
}
