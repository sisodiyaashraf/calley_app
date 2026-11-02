import '../../../../core/constants/app_strings.dart';
import 'call_stats.dart';

/// Predefined static call statistics for the Dashboard chart screen.
class StaticCallStats {
  StaticCallStats._();

  static const CallStats data = CallStats(
    listName: AppStrings.testList,
    totalCalls: 50,
    pending: 28,
    done: 22,
    scheduled: 9,
  );
}
