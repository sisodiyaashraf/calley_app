/// Data transfer model for calling list details and stats metrics.
class ListDetailsModel {
  const ListDetailsModel({
    required this.pending,
    required this.called,
    required this.rescheduled,
    required this.callsCount,
  });

  final int pending;
  final int called;
  final int rescheduled;
  final int callsCount;

  factory ListDetailsModel.fromJson(Map<String, dynamic> json) {
    final callsRaw = json['calls'];
    final count = callsRaw is List ? callsRaw.length : 0;

    return ListDetailsModel(
      pending: (json['pending'] as num?)?.toInt() ?? 0,
      called: (json['called'] as num?)?.toInt() ?? 0,
      rescheduled: (json['rescheduled'] as num?)?.toInt() ?? 0,
      callsCount: count,
    );
  }
}
