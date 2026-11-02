/// Domain entity representing a calling list.
class CallingList {
  const CallingList({
    required this.id,
    required this.name,
    this.totalCalls = 0,
    this.clientId,
  });

  final String id;
  final String name;
  final int totalCalls;
  final String? clientId;
}
