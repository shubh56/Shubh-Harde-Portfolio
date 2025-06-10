class ThemeState {
  final bool isDarkMode;

  ThemeState({required this.isDarkMode});

  factory ThemeState.initial() => ThemeState(isDarkMode: false);
}
