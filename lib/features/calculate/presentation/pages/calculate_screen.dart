import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/calculate/presentation/manager/calculate_manager.dart';

import '../../../../injection_container.dart';

final calculateManager =
    ChangeNotifierProvider((ref) => sl<CalculateManager>());

class CalculateScreen extends StatefulWidget {
  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final TextEditingController _firstController =
      TextEditingController();

  final TextEditingController _secondController =
      TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _firstController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter First Number';
                  }
                  return null;
                },
                decoration:
                    InputDecoration(labelText: 'First Number'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _secondController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Second Number';
                  }
                  return null;
                },
                decoration:
                    InputDecoration(labelText: 'Second Number'),
              ),
              SizedBox(height: 16.0),
              Consumer(builder: (context, watch, child) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: DropdownButton<Operations>(
                    value: watch(calculateManager).selectedOperation,
                    underline: Container(),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    iconSize: 30,
                    style: TextStyle(color: Colors.black),
                    isExpanded: true,
                    onChanged: (Operations newValue) {
                      context
                          .read(calculateManager)
                          .selectedOperation = newValue;
                    },
                    items: context
                        .read(calculateManager)
                        .operations
                        .map<DropdownMenuItem<Operations>>(
                            (Operations value) {
                      return DropdownMenuItem<Operations>(
                        value: value,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(value.name),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
              SizedBox(
                height: 16.0,
              ),
              Row(children: [
                Text('Choose delay Time:'),
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      context.read(calculateManager).delay++;
                    }),
                Consumer(builder: (context, watch, _) {
                  return Text('${watch(calculateManager).delay}');
                }),
                IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      if (context.read(calculateManager).delay > 1)
                        context.read(calculateManager).delay--;
                    }),
                Text('Seconds'),
              ]),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                onPressed: () {
                  if (_form.currentState.validate()) {
                    context
                        .read(calculateManager)
                        .startBackgroundService(
                            double.parse(_firstController.text),
                            double.parse(_secondController.text));
                  }
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
