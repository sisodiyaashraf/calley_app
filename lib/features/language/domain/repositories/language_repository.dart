import '../entities/language.dart';

/// Contract that the data layer must fulfil.
/// The domain layer depends only on this abstraction.
abstract class LanguageRepository {
  /// Returns the ordered list of available languages.
  List<Language> getLanguages();
}
