/// Immutable entity representing a selectable language option.
class Language {
  const Language({
    required this.name,
    required this.greeting,
  });

  /// Display name of the language (e.g. "English").
  final String name;

  /// Native greeting string (e.g. "Hi").
  final String greeting;
}
