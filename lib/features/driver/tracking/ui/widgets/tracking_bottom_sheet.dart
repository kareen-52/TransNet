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
    currentStatus = widget.initialShipment.status; // 'جارية' أو 'قيد التوصيل'
  }

  void _onSuccessFinish() {
    // إزالة الشحنة من قائمة الهوم والعودة للخلف
    context.read<ActiveDriverShipmentsCubit>().removeShipment(widget.initialShipment.id);
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<DriverTrackingCubit, DriverTrackingState>(
      listener: (context, state) {
        state.whenOrNull(
          errorQr: (err) => SnackBarHelper.showError(context, err),
          errorPin: (err) => SnackBarHelper.showError(context, err),
          successQr: (msg) {
            SnackBarHelper.showSuccess(context, msg);
            setState(() => currentStatus = 'قيد التوصيل'); // تحديث الواجهة تلقائياً
          },
          successPin: (msg) {
            SnackBarHelper.showSuccess(context, msg);
            _onSuccessFinish(); // إنهاء الرحلة
          },
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تفاصيل مبسطة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.initialShipment.client?.fullName ?? 'عميل', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                Text('${widget.initialShipment.price.toStringAsFixed(0)} ل.س', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
              ],
            ),
            verticalSpace(8),
            Text('من: ${widget.initialShipment.startGovernorate} ➔ إلى: ${widget.initialShipment.endGovernorate}', style: theme.textTheme.bodyMedium),
            verticalSpace(24),

            // الأزرار الذكية تعتمد على currentStatus
            BlocBuilder<DriverTrackingCubit, DriverTrackingState>(
              builder: (context, state) {
                final isLoadingQr = state == const DriverTrackingState.loadingQr();
                final isLoadingPin = state == const DriverTrackingState.loadingPin();

                if (currentStatus == 'جارية') {
                  return Column(
                    children: [
                      AppTextButton(
                        text: 'مسح رمز الاستلام (QR)',
                        prefixIcon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                        isLoading: isLoadingQr,
                        onPressed: isLoadingPin ? null : () async {
                          // 1. فتح شاشة الكاميرا
                          final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const QRScannerScreen()));
                          if (result != null && result is String && context.mounted) {
                            // 2. إرسال الكود للباك إند
                            context.read<DriverTrackingCubit>().confirmPickup(widget.initialShipment.id, result);
                          }
                        },
                      ),
                      verticalSpace(12),
                      AppTextButton(
                        text: 'تخطي الاستلام وإدخال الـ PIN',
                        backgroundColor: Colors.transparent,
                        borderSide: BorderSide(color: theme.colorScheme.primary),
                        textStyle: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                        isLoading: isLoadingPin,
                        onPressed: isLoadingQr ? null : () => _showPinDialog(context),
                      ),
                    ],
                  );
                } else {
                  // الحالة: قيد التوصيل
                  return AppTextButton(
                    text: 'أدخل رمز التسليم (PIN)',
                    backgroundColor: Colors.green.shade600,
                    prefixIcon: const Icon(Icons.pin, color: Colors.white),
                    isLoading: isLoadingPin,
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

  void _showPinDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (ctx) => PinInputDialog(
        onCompleted: (pin) {
          Navigator.pop(ctx);
          parentContext.read<DriverTrackingCubit>().confirmDelivery(widget.initialShipment.id, pin);
        },
      ),
    );
  }
}