part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final int themeId;
  ThemeState({required this.themeData, required this.themeId});

  @override
  List<Object> get props => [themeData, themeId];
}
