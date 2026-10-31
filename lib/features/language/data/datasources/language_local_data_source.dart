import '../../domain/entities/language.dart';

/// In-memory data source providing the hard-coded language list.
/// Only the repository implementation may access this class directly.
class LanguageLocalDataSource {
  const LanguageLocalDataSource();

  /// Returns the ordered language list as defined in the Figma spec.
  List<Language> fetchLanguages() => const [
        Language(name: 'English', greeting: 'Hi'),
        Language(name: 'Hindi', greeting: 'नमस्ते'),
        Language(name: 'Bengali', greeting: 'হ্যালো'),
        Language(name: 'Kannada', greeting: 'ನಮಸ್ಕಾರ'),
        Language(name: 'Punjabi', greeting: 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ'),
        Language(name: 'Tamil', greeting: 'வணக்கம்'),
        Language(name: 'Telugu', greeting: 'హలో'),
        Language(name: 'French', greeting: 'Bonjour'),
        Language(name: 'Spanish', greeting: 'Hola'),
      ];
}
