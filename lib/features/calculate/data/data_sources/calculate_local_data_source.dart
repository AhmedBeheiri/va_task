import 'package:injectable/injectable.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/exception.dart';
import 'package:vaTask/core/error/failures.dart';

abstract class CalculateLocalDataSource {
  Future<DataBaseModel> addDataBaseModel(DataBaseModel model);
}

@LazySingleton(as: CalculateLocalDataSource)
class CalculateLocalDataSourceImpl
    implements CalculateLocalDataSource {
  final DataBaseHelper _helper;

  CalculateLocalDataSourceImpl(this._helper);

  @override
  Future<DataBaseModel> addDataBaseModel(DataBaseModel model) async {
    try {
      await _helper.add(model);
      return model;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
