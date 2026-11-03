import '../../domain/entities/register_request.dart';
import '../../domain/repositories/register_repository.dart';
import '../../../otp/domain/repositories/otp_repository.dart';
import '../../../../core/session/pending_registration.dart';
import '../datasources/register_remote_data_source.dart';

/// Concrete [RegisterRepository] backed by [RegisterRemoteDataSource].
class RegisterRepositoryImpl implements RegisterRepository {
  const RegisterRepositoryImpl(this._dataSource, [this._otpRepository]);

  final dynamic _dataSource;
  final OtpRepository? _otpRepository;

  @override
  Future<bool> register(RegisterRequest request) async {
    final ds = _dataSource;
    if (ds is RegisterRemoteDataSource) {
      final success = await ds.register(
        username: request.name,
        email: request.email,
        password: request.password,
      );
      if (!success) return false;
      PendingRegistration.set(request.email, request.password);
      final otp = _otpRepository;
      if (otp != null) {
        await otp.resend(request.email);
      }
      return true;
    }
    return ds.register(request);
  }
}
