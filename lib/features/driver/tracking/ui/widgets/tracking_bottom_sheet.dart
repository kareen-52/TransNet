import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/data/models/active_driver_shipment_model.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/logic/active_driver_shipments_cubit.dart';
import 'package:graduation_progect/features/driver/tracking/logic/driver_tracking_cubit.dart';
import 'package:graduation_progect/features/driver/tracking/logic/driver_tracking_state.dart';
import 'package:graduation_progect/features/driver/tracking/ui/widgets/pin_input_dialog.dart';
import 'package:graduation_progect/features/driver/tracking/ui/widgets/qr_scanner_screen.dart';
import 'package:graduation_progect/features/user/active_orders/ui/helpers/shipment_status_helper.dart';

class TrackingBottomSheet extends StatefulWidget {
  final ActiveDriverShipmentModel initialShipment;
  const TrackingBottomSheet({super.key, required this.initialShipment});

  @override
  State<TrackingBottomSheet> createState() => _TrackingBottomSheetState();
}

class _TrackingBottomSheetState extends State<TrackingBottomSheet> {
  late String currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.initialShipment.status;
  }

  void _onSuccessFinish() {
    context.read<ActiveDriverShipmentsCubit>().removeShipment(
      widget.initialShipment.id,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = widget.initialShipment;

    return BlocListener<DriverTrackingCubit, DriverTrackingState>(
      listener: (context, state) {
        state.whenOrNull(
          successQr: (msg) {
            SnackBarHelper.showSuccess(context, msg);
            setState(() {
              currentStatus = 'قيد التوصيل';
            });
          },

          successPin: (msg) {
            SnackBarHelper.showSuccess(context, msg);
            _onSuccessFinish();
          },

          errorQr: (err) => SnackBarHelper.showError(context, err),
          errorPin: (err) => SnackBarHelper.showError(context, err),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── مقبض السحب ──
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            verticalSpace(16),

            // ── معلومات الشحنة ──
            _buildInfoRow(
              theme,
              "الحالة",
              currentStatus == 'جارية'
                  ? "جارية (بانتظار الاستلام)"
                  : "قيد التوصيل",
              color: ShipmentStatusHelper.getColor(currentStatus),
            ),
            _buildInfoRow(theme, "رقم الشحنة", "#${s.shipmentNumber}"),
            _buildInfoRow(theme, "العميل", s.client?.fullName ?? "غير معروف"),
            _buildInfoRow(theme, "السعر", "${s.price.toStringAsFixed(0)} ل.س"),

            verticalSpace(24),

            // ── الأزرار الذكية ──
            BlocBuilder<DriverTrackingCubit, DriverTrackingState>(
              builder: (context, state) {
                final loading = state.maybeWhen(
                  loadingQr: () => true,
                  loadingPin: () => true,
                  orElse: () => false,
                );

                // المرحلة الأولى: جارية (إما بيمسح QR أو بيتخطى)
                if (currentStatus == 'جارية') {
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: AppTextButton(
                          text: 'تأكيد الاستلام (QR)',
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                          isLoading: loading,
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const QRScannerScreen(),
                              ),
                            );
                            if (result != null && context.mounted) {
                              context.read<DriverTrackingCubit>().confirmPickup(
                                s.id,
                                result,
                              );
                            }
                          },
                        ),
                      ),
                      horizontalSpace(10),

                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: loading
                              ? null
                              : () {
                                  setState(() {
                                    currentStatus = 'قيد التوصيل';
                                  });
                                },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: BorderSide(color: theme.colorScheme.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Text(
                            'تخطي',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return AppTextButton(
                    text: 'تأكيد التسليم (PIN)',
                    prefixIcon: Icon(
                      Icons.pin,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    isLoading: loading,
                    onPressed: () => _showPinDialog(context),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // دالة بناء أسطر المعلومات
  Widget _buildInfoRow(
    ThemeData theme,
    String label,
    String value, {
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }


  void _showPinDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (ctx) => PinInputDialog(
        onCompleted: (pin) {
          Navigator.pop(ctx);

          parentContext.read<DriverTrackingCubit>().confirmDelivery(
            widget.initialShipment.id,
            pin,
          );
        },
      ),
    );
  }
}
