import '../entities/language.dart';
import '../repositories/language_repository.dart';

/// Use-case: validates and returns the language at [index].
/// Throws [RangeError] if [index] is out of bounds.
class SelectLanguage {
  const SelectLanguage(this._repository);

  final LanguageRepository _repository;

  Language call(int index) {
    final languages = _repository.getLanguages();
    RangeError.checkValidIndex(index, languages, 'index');
    return languages[index];
  }
}
