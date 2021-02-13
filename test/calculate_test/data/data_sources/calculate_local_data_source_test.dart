import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/calculate/data/data_sources/calculate_local_data_source.dart';

class MockDataBaseHelper extends Mock implements DataBaseHelper {}

void main() {
  CalculateLocalDataSource localDataSource;
  MockDataBaseHelper mockDataBaseHelper;

  setUp(() {
    mockDataBaseHelper = MockDataBaseHelper();
    localDataSource = CalculateLocalDataSourceImpl(mockDataBaseHelper);
  });

  group('add model to DataBase', () {
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
        operation: Operations('Add', 'ADD', 1),
        status: 'Finished',
        result: '30');

    test('add pending operation to database', () {
      localDataSource.addDataBaseModel(tOperationModelPending);
      verify(mockDataBaseHelper.add(tOperationModelPending));
    });
    test('add finished operation to database', () {
      localDataSource.addDataBaseModel(tOperationModelFinished);
      verify(mockDataBaseHelper.add(tOperationModelFinished));
    });
  });
}
