import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/session/session.dart';
import '../models/calling_list_model.dart';

/// Remote data source fetching calling lists from Mock API V2.
class CallingListRemoteDataSource {
  const CallingListRemoteDataSource({
    required ApiClient apiClient,
    required Session session,
  })  : _apiClient = apiClient,
        _session = session;

  final ApiClient _apiClient;
  final Session _session;

  Future<List<CallingListModel>> fetchCallingLists() async {
    if (_session.userId.isEmpty) {
      throw const AppException('Please sign in again');
    }

    final response = await _apiClient.getWithBody(
      '/list',
      query: {'userId': _session.userId},
      body: {'email': _session.email},
    );

    if (response == null) return const [];

    if (response is List) {
      return response
          .whereType<Map<String, dynamic>>()
          .map(CallingListModel.fromJson)
          .toList();
    } else if (response is Map<String, dynamic>) {
      if (response['data'] is List) {
        return (response['data'] as List)
            .whereType<Map<String, dynamic>>()
            .map(CallingListModel.fromJson)
            .toList();
      }
      return [CallingListModel.fromJson(response)];
    }

    return const [];
  }
}
