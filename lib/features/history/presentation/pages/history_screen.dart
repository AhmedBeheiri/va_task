import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:vaTask/features/history/presentation/manager/history_provider.dart';
import 'package:vaTask/features/history/presentation/widgets/history_row.dart';

import '../../../../injection_container.dart';

final historyManager =
    ChangeNotifierProvider((ref) => sl<HistoryProvider>());

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.pending)),
              Tab(icon: Icon(Icons.done)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Consumer(builder: (context, watch, child) {
              var list = watch(historyManager).pendingData;
              return ListView(
                children: list.map((e) => HistoryRow(e)).toList(),
              );
            }),
            Consumer(builder: (context, watch, child) {
              var list = watch(historyManager).finishedData;
              return ListView(
                children: list.map((e) => HistoryRow(e)).toList(),
              );
            })
          ],
        ),
      ),
    );
  }
}
