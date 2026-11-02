import '../../domain/entities/calling_list.dart';

/// Data transfer model for calling list representation from the Mock API.
class CallingListModel {
  const CallingListModel({
    required this.id,
    required this.name,
    this.agents = const [],
    this.clientId,
    this.totalCalls = 0,
  });

  final String id;
  final String name;
  final List<dynamic> agents;
  final String? clientId;
  final int totalCalls;

  factory CallingListModel.fromJson(Map<String, dynamic> json) {
    return CallingListModel(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      name: (json['name'] ?? '') as String,
      agents: (json['agents'] as List<dynamic>?) ?? const [],
      clientId: json['clientId'] as String?,
      totalCalls: (json['totalCalls'] as num?)?.toInt() ?? 0,
    );
  }

  CallingList toEntity() => CallingList(
        id: id,
        name: name,
        totalCalls: totalCalls,
        clientId: clientId,
      );
}
