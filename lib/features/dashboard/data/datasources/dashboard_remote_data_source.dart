import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/session/session.dart';
import '../models/list_details_model.dart';

/// Remote data source fetching calling list metrics and details.
class DashboardRemoteDataSource {
  const DashboardRemoteDataSource({
    required ApiClient apiClient,
    required Session session,
  })  : _apiClient = apiClient,
        _session = session;

  final ApiClient _apiClient;
  final Session _session;

  Future<ListDetailsModel> fetchListDetails(String listId) async {
    if (_session.userId.isEmpty) {
      throw const AppException('Please sign in again');
    }

    final response = await _apiClient.getWithBody(
      '/list/$listId',
      body: {'email': _session.email},
    );

    if (response is Map<String, dynamic>) {
      final data = response['data'] is Map<String, dynamic>
          ? response['data'] as Map<String, dynamic>
          : response;
      return ListDetailsModel.fromJson(data);
    }

    return const ListDetailsModel(
      pending: 0,
      called: 0,
      rescheduled: 0,
      callsCount: 0,
    );
  }
}
