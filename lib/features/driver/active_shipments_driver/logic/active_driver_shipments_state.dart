import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/active_driver_shipment_model.dart';

part 'active_driver_shipments_state.freezed.dart';

@freezed
class ActiveDriverShipmentsState with _$ActiveDriverShipmentsState {
  /// الحالة الأولية
  const factory ActiveDriverShipmentsState.initial() = _Initial;

  /// جاري التحميل (shimmer)
  const factory ActiveDriverShipmentsState.loading() = _Loading;

  /// لا توجد شحنات نشطة
  const factory ActiveDriverShipmentsState.empty() = _Empty;

  /// تم تحميل الشحنات بنجاح
  const factory ActiveDriverShipmentsState.loaded(
    List<ActiveDriverShipmentModel> shipments,
  ) = _Loaded;

  /// خطأ
  const factory ActiveDriverShipmentsState.error(ApiErrorModel error) = _Error;
}
