import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/features/calling_lists/domain/entities/calling_list.dart';
import 'package:calley_app/features/calling_lists/domain/repositories/calling_list_repository.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'package:calley_app/features/calling_lists/presentation/providers/calling_list_provider.dart';

class _FakeCallingListRepo implements CallingListRepository {
  List<CallingList> stored = const [
    CallingList(id: '1', name: AppStrings.testList, totalCalls: 50),
  ];

  @override
  Future<List<CallingList>> getLists() async => stored;

  @override
  Future<List<CallingList>> refresh() async {
    stored = const [
      CallingList(id: '1', name: AppStrings.testList, totalCalls: 50),
      CallingList(id: '2', name: 'Refreshed List', totalCalls: 20),
    ];
    return stored;
  }
}

void main() {
  test('CallingListProvider loads lists and allows selection and refresh', () async {
    final repo = _FakeCallingListRepo();
    final provider = CallingListProvider(
      getCallingLists: GetCallingLists(repo),
      refreshCallingLists: RefreshCallingLists(repo),
    );

    await provider.load();

    expect(provider.lists.length, 1);
    expect(provider.selected?.name, AppStrings.testList);

    provider.select(provider.lists.first);
    expect(provider.selected?.name, AppStrings.testList);

    await provider.refresh();
    expect(provider.lists.length, 2);
    expect(provider.isRefreshing, isFalse);

    provider.select(provider.lists.last);
    expect(provider.selected?.name, 'Refreshed List');
  });
}
