import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/calculate/domain/use_cases/add_to_database_use_case.dart';
import 'package:vaTask/injection_container.dart' as di;
import 'package:workmanager/workmanager.dart';

StreamController<DataBaseModel> _resultModel =
    StreamController<DataBaseModel>();

@injectable
class CalculateManager extends ChangeNotifier {
  int _delay = 1;

  Stream<DataBaseModel> get _resultStream => _resultModel.stream;

  final AddToDataBaseUseCase _addToDataBaseUseCase;

  CalculateManager(this._addToDataBaseUseCase) {
    _resultStream.listen((event) {
      print("Entered");
      if (event != null) {
        print("Entered Not Null");
      }
    });
    getData();
  }
  void getData() async {
    // SendPort mainToIsolateStream = await initIsolate();
    // mainToIsolateStream.send('This is from main()');
  }

  set delay(int c) {
    _delay = c;
    notifyListeners();
  }

  int get delay => _delay;
  Operations _selectedOperation;
  set selectedOperation(Operations op) {
    _selectedOperation = op;
    notifyListeners();
  }

  Operations get selectedOperation => _selectedOperation;
  final List<Operations> operations = [
    Operations('Add', "ADD", 0),
    Operations('Substract', "SUB", 1),
    Operations('Multiplication', "MUL", 2),
    Operations('Divide', "DIVID", 3)
  ];

  void startBackgroundService(
      double firstNum, double secondNum) async {
    if (_selectedOperation != null) {
      var uuid = Uuid().v4();
      print("entered");
      await Workmanager.initialize(
        callbackDispatcher,
        isInDebugMode: true,
      ).then((_) => print("After Success:"));
      await Workmanager.registerOneOffTask(
        uuid,
        _selectedOperation.name,
        inputData: {
          "firstNum": firstNum,
          "secondNum": secondNum,
          "ID": uuid
        },
        initialDelay: Duration(seconds: _delay),
      );
      _addToDataBaseUseCase(DataBaseModel(
          id: uuid,
          firstNum: firstNum,
          secondNum: secondNum,
          operation: _selectedOperation,
          status: "Pending"));
      // print('dataaa:${_helper.getAll()}');
      _selectedOperation = null;
    }
  }
}

void callbackDispatcher() {
  double result;
  Operations _selectedOperation;
  di.configureInjection();
  final CalculateManager manager = di.sl<CalculateManager>();

  Workmanager.executeTask((task, inputData) async {
    print('start excuting');
    double firstNum = inputData["firstNum"] as double;
    double secondNum = inputData["secondNum"] as double;
    String id = inputData["ID"] as String;
    // WidgetsFlutterBinding.ensureInitialized();
    // di.configureInjection();
    // DataBaseHelper.initDatabase();
    // AddToDataBaseUseCase _addToDataBase =
    //     di.sl<AddToDataBaseUseCase>();

    switch (task) {
      case "Add":
        result = firstNum + secondNum;
        _selectedOperation = Operations("Add", "ADD", 0);
        break;
      case "Substract":
        result = firstNum - secondNum;
        _selectedOperation = Operations('Substract', "SUB", 1);

        break;
      case "Multiplication":
        result = firstNum * secondNum;
        _selectedOperation = Operations('Multiplication', "MUL", 2);

        break;
      case "Divide":
        result = firstNum / secondNum;
        _selectedOperation = Operations('Divide', "DIVID", 3);
        break;
    }

    // _addToDataBase = AddToDataBaseUseCase(
    //   CalculateRepoImpl(
    //     CalculateLocalDataSourceImpl(
    //       DataBaseHelper(),
    //     ),
    //   ),
    // );

    var model = DataBaseModel(
        id: id,
        firstNum: firstNum,
        secondNum: secondNum,
        operation: _selectedOperation,
        status: "Finished",
        result: result.toString());
    // SendPort mainToIsolateStream = await initIsolate(model);
    // myIsolate(mainToIsolateStream);
    print("result : $result");
    manager._addToDataBaseUseCase(model);

    // var allDataBase = _helper.getAll();
    // print("DATABASE:${allDataBase.toString()}");
    return Future.value(true);
  });

//  "result : $result".log(className: "CalculateManager");
}

Future<SendPort> initIsolate(DataBaseModel model) async {
  Completer completer = new Completer<SendPort>();
  ReceivePort isolateToMainStream = ReceivePort();

  isolateToMainStream.listen((data) {
    if (data is SendPort) {
      SendPort mainToIsolateStream = data;
      completer.complete(mainToIsolateStream);
    } else {
      print('[isolateToMainStream] $data');
      _resultModel.add(data as DataBaseModel);
    }
  });

  // isolateToMainStream.sendPort.send(model);

  Isolate myIsolateInstance = await Isolate.spawn(
      myIsolate, isolateToMainStream.sendPort..send(model));

  return completer.future;
}

void myIsolate(SendPort isolateToMainStream) {
  ReceivePort mainToIsolateStream = ReceivePort();
  isolateToMainStream.send(mainToIsolateStream.sendPort);

  mainToIsolateStream.listen((data) {
    print('[mainToIsolateStream] $data');
    //exit(0);
  });

  isolateToMainStream.send("THis From My Isolate");
}
