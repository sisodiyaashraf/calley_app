import '../../domain/entities/language.dart';
import '../../domain/repositories/language_repository.dart';
import '../datasources/language_local_data_source.dart';

/// Concrete implementation of [LanguageRepository] backed by
/// [LanguageLocalDataSource].
class LanguageRepositoryImpl implements LanguageRepository {
  const LanguageRepositoryImpl(this._dataSource);

  final LanguageLocalDataSource _dataSource;

  @override
  List<Language> getLanguages() => _dataSource.fetchLanguages();
}
