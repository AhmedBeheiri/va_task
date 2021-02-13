import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../operations_model.dart';
part 'database_helper.g.dart';

@lazySingleton
class DataBaseHelper {
  static const String DATABASE = 'VATASKDATABASE';
  static void initDatabase() async {
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    Hive.registerAdapter(DataBaseModelAdapter());
    Hive.registerAdapter(OperationsAdapter());
    await Hive.openBox<DataBaseModel>(DATABASE);
  }

  Future<void> add(DataBaseModel model) async {
    print("Added 1");
    await Hive.box<DataBaseModel>(DATABASE)
        .put(model.id.toString(), model);
  }

  void remove(int id) async {
    await Hive.box<DataBaseModel>(DATABASE).delete(id.toString());
  }

  void removeAll() async {
    await Hive.box<DataBaseModel>(DATABASE).clear();
  }

  List<DataBaseModel> getAll() {
    return Hive.box<DataBaseModel>(DATABASE).values.toList();
  }

  List<DataBaseModel> getAllPending() {
    return Hive.box<DataBaseModel>(DATABASE)
        .values
        .toList()
        .where((element) => element.status == "Pending")
        .toList();
  }

  List<DataBaseModel> getAllFinished() {
    return Hive.box<DataBaseModel>(DATABASE)
        .values
        .toList()
        .where((element) => element.status == "Finished")
        .toList();
  }

  Stream<BoxEvent> watchAll() {
    return Hive.box<DataBaseModel>(DATABASE).watch();
  }

  DataBaseModel getItem(int id) {
    return Hive.box<DataBaseModel>(DATABASE).get(id.toString());
  }
}

@HiveType(typeId: 0)
class DataBaseModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double firstNum;
  @HiveField(2)
  final double secondNum;
  @HiveField(3)
  final Operations operation;
  @HiveField(4)
  final String result;
  @HiveField(5)
  final String status;

  DataBaseModel(
      {@required this.id,
      @required this.firstNum,
      @required this.secondNum,
      @required this.operation,
      @required this.status,
      this.result});
}
