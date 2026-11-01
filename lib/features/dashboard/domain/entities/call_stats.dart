/// Domain entity representing call statistics for a selected calling list.
class CallStats {
  const CallStats({
    required this.listName,
    required this.totalCalls,
    required this.pending,
    required this.done,
    required this.scheduled,
  });

  final String listName;
  final int totalCalls;
  final int pending;
  final int done;
  final int scheduled;
}
