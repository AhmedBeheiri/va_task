import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/features/history/domain/use_cases/get_finished_jobs_usecase.dart';
import 'package:vaTask/features/history/domain/use_cases/get_pending_jobs_usecase.dart';

@injectable
class HistoryProvider extends ChangeNotifier {
  final GetFinishedJobsUseCase _finishedJobsUseCase;
  final GetPendingJobsUsCase _pendingJobsUsCase;

  List<DataBaseModel> _finishedData = List();
  List<DataBaseModel> get finishedData => _finishedData;

  List<DataBaseModel> _pendingData = List();
  List<DataBaseModel> get pendingData => _pendingData;

  HistoryProvider(
      this._finishedJobsUseCase, this._pendingJobsUsCase) {
    getFinishedJobs();
    getPendingJobs();
  }

  void getPendingJobs() async {
    final result = await _pendingJobsUsCase();
    result.fold((l) {
      print((l as CacheFailure).message);
    }, (r) {
      _pendingData = r;
      print("Data:$r");
      notifyListeners();
    });
  }

  void getFinishedJobs() async {
    final result = await _finishedJobsUseCase();
    result.fold((l) {
      print((l as CacheFailure).message);
    }, (r) {
      _finishedData = r;
      notifyListeners();
    });
  }
}
