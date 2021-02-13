import 'package:flutter/material.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/operations_model.dart';

class HistoryRow extends StatelessWidget {
  final DataBaseModel model;
  const HistoryRow(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(
          getTitle(model),
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          model.status == "Finished" ? "Finished" : "Pending",
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
        trailing: Text(
          model.result ?? "",
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String getTitle(DataBaseModel model) {
    String operation;
    switch (model.operation.operation) {
      case "ADD":
        operation = "+";
        break;
      case "SUB":
        operation = "-";
        break;
      case "MUL":
        operation = "x";
        break;
      case "DIVID":
        operation = "/";
        break;
    }
    return "${model.firstNum} $operation ${model.secondNum}";
  }
}
