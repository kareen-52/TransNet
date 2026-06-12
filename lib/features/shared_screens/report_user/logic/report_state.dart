import 'package:freezed_annotation/freezed_annotation.dart';
part 'report_state.freezed.dart';

@freezed
class ReportState with _$ReportState {
  const factory ReportState.initial() = _Initial;
  const factory ReportState.loading() = _Loading;
  const factory ReportState.success(String message) = _Success;
  const factory ReportState.error(String error) = _Error;
}