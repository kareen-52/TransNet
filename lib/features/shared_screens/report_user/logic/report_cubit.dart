import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import '../data/repos/report_repo.dart';
import 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final ReportRepo _repo;
  ReportCubit(this._repo) : super(const ReportState.initial());

  Future<void> submitReport({required int reportedId, required String type, required String description}) async {
    if (description.trim().isEmpty) {
      emit(const ReportState.error("يرجى كتابة تفاصيل المشكلة أولاً."));
      return;
    }

    emit(const ReportState.loading());
    final result = await _repo.submitReport(reportedId: reportedId, type: type, description: description);

    result.when(
      success: (msg) => emit(ReportState.success(msg)),
      failure: (error) => emit(ReportState.error(error.getAllErrorMessages())),
    );
  }
}