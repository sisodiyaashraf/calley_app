/// Domain entity representing a calling list.
class CallingList {
  const CallingList({
    required this.id,
    required this.name,
    required this.totalCalls,
  });

  final String id;
  final String name;
  final int totalCalls;
}
