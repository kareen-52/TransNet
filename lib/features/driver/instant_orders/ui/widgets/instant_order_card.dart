import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/data/models/active_driver_shipment_model.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/logic/active_driver_shipments_cubit.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/models/instant_order_model.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/models/respond_response_model.dart';
import 'package:graduation_progect/features/driver/instant_orders/logic/instant_orders_cubit.dart';

class InstantOrderCard extends StatefulWidget {
  final InstantOrderModel orderData;
  final VoidCallback onOrderProcessed;

  const InstantOrderCard({
    super.key,
    required this.orderData,
    required this.onOrderProcessed,
  });

  @override
  State<InstantOrderCard> createState() => _InstantOrderCardState();
}

class _InstantOrderCardState extends State<InstantOrderCard> {
  bool _isLoadingAccept = false;
  bool _isLoadingReject = false;

  late Timer _countdownTimer;
  int _remainingSeconds = 600;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  void _calculateRemainingTime() {
    if (widget.orderData.expiresAt.isNotEmpty) {
      DateTime expiresAt = DateTime.parse(widget.orderData.expiresAt).toLocal();
      _remainingSeconds = expiresAt.difference(DateTime.now()).inSeconds;
      if (_remainingSeconds < 0) _remainingSeconds = 0;
    }
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        widget.onOrderProcessed();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  String get _formattedTime {
    int m = _remainingSeconds ~/ 60;
    int s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _showAcceptConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تأكيد القبول'),
        content: const Text(
          'هل أنت متأكد أنك تريد قبول هذا الطلب والتوجه لاستلام الشحنة؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _executeAccept();
            },
            child: const Text('نعم، قبول'),
          ),
        ],
      ),
    );
  }

  void _showRejectConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('رفض الطلب'),
        content: const Text('هل أنت متأكد أنك تريد رفض هذا الطلب؟.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _executeReject();
            },
            child: const Text('نعم، رفض', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _executeAccept() async {
    setState(() => _isLoadingAccept = true);
    final result = await context.read<InstantOrdersCubit>().respondToRequest(
      widget.orderData.userId,
      true,
    );

    if (!mounted) return;

    result.when(
      success: (response) {
        SnackBarHelper.showSuccess(context, response.message);
        // نأخذ نسخة الـ Navigator قبل الحذف من القائمة، لأن حذف الطلب
        // (onOrderProcessed) بيفكك هاد الكرت فورًا، وبعدها context ما يعود
        // صالح للتنقل.
        final navigator = Navigator.of(context);
        widget.onOrderProcessed();
        _goToTracking(response, navigator);
      },
      failure: (error) {
        setState(() => _isLoadingAccept = false);
        SnackBarHelper.showError(context, error.getAllErrorMessages());
      },
    );
  }

  void _goToTracking(
    RespondResponseModel response,
    NavigatorState navigator,
  ) {
    final shipmentsCubit = getIt<ActiveDriverShipmentsCubit>();

    // إذا كانت البيانات الكاملة (رقم الشحنة + العميل) موجودة عندنا مسبقًا
    // بالكاش، منستخدمها فورًا. غير هيك، منروح بشحنة مبدئية فيها بس الموقع
    // (المتوفر برد "قبول الطلب") وننتقل فورًا بدون أي انتظار لتجنب تأخير
    // الوصول لشاشة التتبع.
    ActiveDriverShipmentModel? cachedShipment;
    try {
      cachedShipment = shipmentsCubit.currentShipments.firstWhere(
        (s) => s.id == response.shipmentData!.id,
      );
    } catch (_) {
      cachedShipment = null;
    }

    final placeholderShipment =
        cachedShipment ??
        ActiveDriverShipmentModel(
          id: response.shipmentData!.id,
          userId: widget.orderData.userId,
          driverId: widget.orderData.driverId,
          shipmentNumber: 0,
          price: widget.orderData.price,
          status: 'جارية',
          startLat: response.shipmentData!.startLat,
          startLng: response.shipmentData!.startLng,
          endLat: response.shipmentData!.endLat,
          endLng: response.shipmentData!.endLng,
          startGovernorate: widget.orderData.fromLocation,
          endGovernorate: widget.orderData.toLocation,
          pathCoordinates: response.shipmentData!.pathCoordinates,
          client: null,
        );

    navigator.pushNamed(
      Routes.driverTrackingScreen,
      arguments: placeholderShipment,
    );

 
    shipmentsCubit.silentRefresh();
  }

  Future<void> _executeReject({bool autoExpired = false}) async {
    setState(() => _isLoadingReject = true);
    final result = await context.read<InstantOrdersCubit>().respondToRequest(
      widget.orderData.userId,
      false,
    );

    if (!mounted) return;

    if (autoExpired) {
      SnackBarHelper.showError(context, "انتهت مهلة الرد، تم تجاهل الطلب.");
    } else {
      result.when(
        success: (response) {
          SnackBarHelper.showSuccess(context, response.message);
        },
        failure: (error) {
          setState(() => _isLoadingReject = false);
          SnackBarHelper.showError(context, error.getAllErrorMessages());
        },
      );
    }

    widget.onOrderProcessed();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.secondary.withOpacity(0.6),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('طلب جديد!', style: theme.textTheme.bodyLarge),
              _buildTimer(),
            ],
          ),
          verticalSpace(24),
          _buildRouteSection(),
          verticalSpace(24),
          _buildInfoGrid(),
          verticalSpace(12),
          _buildExtraInfo(),
          verticalSpace(24),
          _buildPriceSection(),
          verticalSpace(24),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            color: Theme.of(context).colorScheme.error,
            size: 16.sp,
          ),
          horizontalSpace(6),
          Text(
            _formattedTime,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteSection() {
    final theme = Theme.of(context);
    return Row(
      children: [
        Column(
          children: [
            Icon(
              Icons.location_on,
              color: theme.colorScheme.primary,
              size: 23.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.h),
              width: 1,
              height: 35.h,
              color: theme.colorScheme.outline,
            ),
            Icon(Icons.flag, color: theme.colorScheme.primary, size: 23.sp),
          ],
        ),
        horizontalSpace(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('من', style: theme.textTheme.titleMedium),
              Text(
                widget.orderData.fromLocation,
                style: theme.textTheme.titleLarge,
              ),
              verticalSpace(16),
              Text('إلى', style: theme.textTheme.titleMedium),
              Text(
                widget.orderData.toLocation,
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid() {
    return Column(
      children: [
        Row(
          children: [
            _buildInfoBox(
              'لنقطة الانطلاق',
              '${widget.orderData.distanceToStart} كم',
            ),
            horizontalSpace(12),
            _buildInfoBox(
              'مسافة الشحنة',
              '${widget.orderData.shipmentDistance} كم',
            ),
          ],
        ),
        verticalSpace(12),
        Row(
          children: [
            _buildInfoBox('الوزن', '${widget.orderData.weight} كغ'),
            horizontalSpace(12),
            _buildInfoBox('الطول', '${widget.orderData.length}'),
          ],
        ),
        verticalSpace(12),

        Row(
          children: [
            _buildInfoBox('العرض', '${widget.orderData.width}'),
            horizontalSpace(12),
            _buildInfoBox('الارتفاع', '${widget.orderData.height}'),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoBox(String label, String value) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.bodySmall),
            verticalSpace(4),

            Text(value, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildExtraInfo() {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.2),

              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ماهية الغرض', style: theme.textTheme.bodySmall),
                verticalSpace(4),

                Text(widget.orderData.object, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        ),
        // horizontalSpace(12),
        // Expanded(
        //   flex: 1,
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        //     decoration: BoxDecoration(
        //       color: const Color(0xFFECFDF5),
        //       borderRadius: BorderRadius.circular(8.r),
        //     ),
        //     child: Row(
        //       children: [
        //         Icon(Icons.check_circle, color: AppColors.success, size: 18.sp),
        //         horizontalSpace(6),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text('تأمين', style: theme.textTheme.bodySmall),
                //     Text(
                //       widget.orderData.insurance ? 'نعم' : 'لا',
                //       style: TextStyle(
                //         color: const Color(0xFF065F46),
                //         fontSize: 13.sp,
                //         fontWeight: FontWeightHelper.bold,
                //       ),
                //     ),
                //   ],
                // ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildPriceSection() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('السعر المتوقع', style: theme.textTheme.titleMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${widget.orderData.price.round()}',
              style: theme.textTheme.displayLarge!.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
            horizontalSpace(8),
            Text(
              'ل.س',
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: _isLoadingAccept || _isLoadingReject
                ? null
                : _showRejectConfirmation,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFEBEE),
              foregroundColor: Theme.of(context).colorScheme.error,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: _isLoadingReject
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.error,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'رفض',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        horizontalSpace(12),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _isLoadingAccept || _isLoadingReject
                ? null
                : _showAcceptConfirmation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: _isLoadingAccept
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      horizontalSpace(8),
                      Text(
                        'قبول الطلب',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}