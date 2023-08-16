part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final int themeId;

  ThemeChanged({required this.themeId});

  @override
  List<Object> get props => [themeId];
}

class LoadThemeEvent extends ThemeEvent {
  @override
  List<Object> get props => [];
}
