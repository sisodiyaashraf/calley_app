import '../../domain/entities/otp_verification.dart';
import '../../domain/repositories/otp_repository.dart';
import '../datasources/otp_remote_data_source.dart';

/// Concrete repository implementation backed by [OtpRemoteDataSource].
class OtpRepositoryImpl implements OtpRepository {
  const OtpRepositoryImpl(this._dataSource);

  final dynamic _dataSource;

  @override
  Future<bool> verify(OtpVerification verification) {
    final ds = _dataSource;
    if (ds is OtpRemoteDataSource) {
      return ds.verify(verification);
    }
    return ds.verify(verification);
  }

  @override
  Future<bool> resend(String email) {
    final ds = _dataSource;
    if (ds is OtpRemoteDataSource) {
      return ds.resend(email);
    }
    return ds.resend(email);
  }
}
