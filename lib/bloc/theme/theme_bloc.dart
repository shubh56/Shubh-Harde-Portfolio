import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ToggleTheme>((event, emit) {
      emit(ThemeState(isDarkMode: !state.isDarkMode));
    });
  }
}
