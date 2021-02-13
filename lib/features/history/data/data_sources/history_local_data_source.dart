import 'package:injectable/injectable.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/exception.dart';

abstract class HistoryLocalDataSource {
  Future<List<DataBaseModel>> getPendingJobs();
  Future<List<DataBaseModel>> getFinishedJobs();
}

@LazySingleton(as: HistoryLocalDataSource)
class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  final DataBaseHelper _helper;

  HistoryLocalDataSourceImpl(this._helper);

  @override
  Future<List<DataBaseModel>> getFinishedJobs() async {
    var result = _helper
        .getAll()
        .where((element) => element.status == "Finished")
        .toList();
    if (result != null) {
      print("Result1:$result");
      return result;
    } else {
      throw CacheException("Error Retriveing Data");
    }
  }

  @override
  Future<List<DataBaseModel>> getPendingJobs() async {
    var result = _helper
        .getAll()
        .where((element) => element.status == "Pending")
        .toList();
    if (result != null) {
      print("Result:$result");
      return result;
    } else {
      throw CacheException("Error Retriveing Data");
    }
  }
}
