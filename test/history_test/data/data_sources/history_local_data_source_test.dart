import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/history/data/data_sources/history_local_data_source.dart';

class MockDataBaseHelper extends Mock implements DataBaseHelper {}

void main() {
  MockDataBaseHelper mockDataBaseHelper;
  HistoryLocalDataSource localDataSource;

  setUp(() {
    mockDataBaseHelper = MockDataBaseHelper();
    localDataSource = HistoryLocalDataSourceImpl(mockDataBaseHelper);
  });

  group('get pending jobs', () {
    final tOperationModelPending = DataBaseModel(
        id: '1',
        firstNum: 10,
        secondNum: 20,
        operation: Operations('Add', 'ADD', 1),
        status: 'Pending');
    final tOperationModelFinished = DataBaseModel(
        id: '1',
        firstNum: 10,
        secondNum: 20,
        result: '30',
        operation: Operations('Add', 'ADD', 1),
        status: 'Finished');
    test('should call get all on pending jobs function ', () {
      when(mockDataBaseHelper.getAll())
          .thenAnswer((_) => [tOperationModelPending]);
      localDataSource.getPendingJobs();
      verify(mockDataBaseHelper.getAll());
    });
    test('should call get all on finished jobs function ', () {
      when(mockDataBaseHelper.getAll())
          .thenAnswer((_) => [tOperationModelFinished]);
      localDataSource.getFinishedJobs();
      verify(mockDataBaseHelper.getAll());
    });
  });
}
