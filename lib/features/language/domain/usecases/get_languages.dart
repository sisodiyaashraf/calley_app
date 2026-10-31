import '../entities/language.dart';
import '../repositories/language_repository.dart';

/// Use-case: fetches the full ordered list of available languages.
class GetLanguages {
  const GetLanguages(this._repository);

  final LanguageRepository _repository;

  List<Language> call() => _repository.getLanguages();
}
