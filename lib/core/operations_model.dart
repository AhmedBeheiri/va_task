import 'package:hive/hive.dart';
part 'operations_model.g.dart';

@HiveType(typeId: 1)
class Operations {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String operation;
  @HiveField(2)
  final int id;

  Operations(this.name, this.operation, this.id);
}

// @HiveType(typeId: 3)
// enum Operation { ADD, SUB, MUL, DIVID }
// @HiveType(typeId: 2)
// enum OperationStatus { Pending, Finished }
