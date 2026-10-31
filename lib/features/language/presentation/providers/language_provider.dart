import 'package:flutter/foundation.dart';
import '../../domain/entities/language.dart';
import '../../domain/usecases/get_languages.dart';
import '../../domain/usecases/select_language.dart';

/// Manages selection state for the Choose Your Language screen.
///
/// • [languages]      – immutable ordered list fetched once on init.
/// • [selectedIndex]  – index of the currently selected row (0 = English by default).
/// • [select(i)]      – changes selection; calls [SelectLanguage] use-case.
/// • [confirm()]      – finalises the choice; triggers [onConfirmed] callback.
class LanguageProvider extends ChangeNotifier {
  LanguageProvider({
    required GetLanguages getLanguages,
    required SelectLanguage selectLanguage,
    this.onConfirmed,
  })  : _getLanguages = getLanguages,
        _selectLanguage = selectLanguage {
    _languages = _getLanguages();
  }

  final GetLanguages _getLanguages;
  final SelectLanguage _selectLanguage;

  /// Called when the user taps "Select" and a language has been confirmed.
  /// Wire this in [app.dart] for navigation to the Register screen later.
  // ignore: prefer_function_declarations_over_variables
  final void Function(Language language)? onConfirmed;

  late final List<Language> _languages;
  int _selectedIndex = 0;

  List<Language> get languages => _languages;
  int get selectedIndex => _selectedIndex;
  Language get selectedLanguage => _languages[_selectedIndex];

  /// Selects the language at [index] via the use-case.
  void select(int index) {
    if (index == _selectedIndex) return;
    _selectLanguage(index); // validates bounds
    _selectedIndex = index;
    notifyListeners();
  }

  /// Confirms the current selection.
  /// Navigation callback left for the caller; a SnackBar is shown on the page.
  void confirm() {
    onConfirmed?.call(selectedLanguage);
  }
}
