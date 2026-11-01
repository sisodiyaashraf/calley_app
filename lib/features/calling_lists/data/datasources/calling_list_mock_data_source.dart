import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/calling_list.dart';

/// Mock data source providing mock calling list items with simulated delay.
class CallingListMockDataSource {
  const CallingListMockDataSource();

  static const List<CallingList> _mockLists = [
    CallingList(id: '1', name: AppStrings.testList, totalCalls: 50),
  ];

  Future<List<CallingList>> fetchCallingLists() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return List<CallingList>.from(_mockLists);
  }

  Future<List<CallingList>> refreshCallingLists() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return List<CallingList>.from(_mockLists);
  }
}
