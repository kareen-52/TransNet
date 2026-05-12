import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/active_order_model.dart';

class ActiveOrderCard extends StatelessWidget {
  final ActiveOrderModel order;
  const ActiveOrderCard({super.key, required this.order});

  int get _currentStep {
    switch (order.status) {
      case 'جارية':      return 1;
      case 'قيد التوصيل': return 2;
      default:            return 0;
    }
  }

  Color get _statusColor {
    switch (order.status) {
      case 'جارية':      return const Color(0xFF2196F3);
      case 'قيد التوصيل': return const Color(0xFF4CAF50);
      default:            return const Color(0xFFFF9800);
    }
  }

  static const List<String> _steps = ['تم الإرسال','تم القبول','قيد التوصيل','تم التسليم'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 290.w,
      margin: EdgeInsetsDirectional.only(end: 12.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(theme),
            SizedBox(height: 20.h),
            _buildProgressTracker(theme),
            SizedBox(height: 18.h),
            Divider(color: theme.dividerColor.withOpacity(0.4), height: 1),
            SizedBox(height: 14.h),
            _buildPriceRow(theme),
            SizedBox(height: 14.h),
            _buildDriverRow(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(color: _statusColor.withOpacity(0.12), borderRadius: BorderRadius.circular(20.r)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 7.w, height: 7.w, decoration: BoxDecoration(shape: BoxShape.circle, color: _statusColor)),
            SizedBox(width: 5.w),
            Text(order.status, style: TextStyle(fontSize: 11.sp, color: _statusColor, fontWeight: FontWeight.w600)),
          ]),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('رقم الشحنة', style: TextStyle(fontSize: 10.sp, color: theme.colorScheme.onSurface.withOpacity(0.5))),
          Text('#${order.shipmentNumber}', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
        ]),
      ],
    );
  }

  Widget _buildProgressTracker(ThemeData theme) {
    final primary = theme.colorScheme.primary;
    final inactive = theme.colorScheme.onSurface.withOpacity(0.12);
    return Column(children: [
      Row(children: List.generate(_steps.length, (i) {
        final isCompleted = i < _currentStep;
        final isCurrent = i == _currentStep;
        final isActive = i <= _currentStep;
        return Expanded(child: Row(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            width: isCurrent ? 18.w : 12.w,
            height: isCurrent ? 18.w : 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? primary : inactive,
              border: isCurrent ? Border.all(color: primary.withOpacity(0.2), width: 4) : null,
            ),
            child: isCompleted ? Center(child: Icon(Icons.check, color: Colors.white, size: 8.sp)) : null,
          ),
          if (i < _steps.length - 1)
            Expanded(child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              height: 3.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.r), color: i < _currentStep ? primary : inactive),
            )),
        ]));
      })),
      SizedBox(height: 8.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_steps.length, (i) {
          final isCurrent = i == _currentStep;
          return SizedBox(
            width: 62.w,
            child: Text(_steps[i], textAlign: TextAlign.center, style: TextStyle(
              fontSize: 9.sp,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: isCurrent ? primary : theme.colorScheme.onSurface.withOpacity(0.45),
            )),
          );
        }),
      ),
    ]);
  }

  Widget _buildPriceRow(ThemeData theme) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('${_formatPrice(order.price)} ل.س', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
      Text('السعر', style: TextStyle(fontSize: 11.sp, color: theme.colorScheme.onSurface.withOpacity(0.5))),
    ]);
  }

  Widget _buildDriverRow(ThemeData theme) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () => _callDriver(order.driver.phoneNumber),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
          decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
          child: Row(children: [
            Icon(Icons.phone_rounded, color: Colors.green[700], size: 15.sp),
            SizedBox(width: 5.w),
            Text('اتصال', style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600, fontSize: 12.sp)),
          ]),
        ),
      ),
      Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('${order.driver.firstName} ${order.driver.lastName}',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
            maxLines: 1, overflow: TextOverflow.ellipsis),
          Text('السائق', style: TextStyle(fontSize: 10.sp, color: theme.colorScheme.onSurface.withOpacity(0.45))),
        ]),
        SizedBox(width: 10.w),
        CircleAvatar(
          radius: 20.r,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          child: Icon(Icons.person_rounded, color: theme.colorScheme.primary, size: 22.sp),
        ),
      ]),
    ]);
  }

  String _formatPrice(double price) {
    if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(1)}M';
    if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
    return price.toStringAsFixed(0);
  }

  Future<void> _callDriver(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
