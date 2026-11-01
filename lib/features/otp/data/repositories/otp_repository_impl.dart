import '../../domain/entities/otp_verification.dart';
import '../../domain/repositories/otp_repository.dart';
import '../datasources/otp_mock_data_source.dart';

/// Concrete repository implementation backed by [OtpMockDataSource].
class OtpRepositoryImpl implements OtpRepository {
  const OtpRepositoryImpl(this._dataSource);

  final OtpMockDataSource _dataSource;

  @override
  Future<bool> verify(OtpVerification verification) =>
      _dataSource.verify(verification);

  @override
  Future<bool> resend(String phone) => _dataSource.resend(phone);
}
