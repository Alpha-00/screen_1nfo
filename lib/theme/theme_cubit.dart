import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_s1ze/theme/app_theme.dart';
import 'package:screen_s1ze/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(AppTheme.lightTheme));

  void toggleTheme() {
    if (state.themeData == AppTheme.lightTheme) {
      emit(ThemeState(AppTheme.darkTheme));
    } else {
      emit(ThemeState(AppTheme.lightTheme));
    }
  }
}
