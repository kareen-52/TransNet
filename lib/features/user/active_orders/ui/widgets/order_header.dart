import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';

class OrderHeader extends StatelessWidget {
  final String status;
  final int shipmentNumber;

  const OrderHeader({
    super.key,
    required this.status,
    required this.shipmentNumber,
  });

  Color _getStatusColor(ThemeData theme) {
    switch (status) {
      case 'جارية':
        return Colors.green;
      case 'قيد التوصيل':
        return Colors.orange;
      default:
        return theme.colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(theme);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'رقم الشحنة',
              style: TextStyle(
                fontSize: 12.sp,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            verticalSpace(4),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: '$shipmentNumber'));
                SnackBarHelper.showSuccess(context, 'تم نسخ رقم الشحنة');
              },
              child: Container(
                decoration: BoxDecoration(
                  // color: theme.colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '#$shipmentNumber',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    horizontalSpace(4),
                    Icon(
                      Icons.copy_rounded,
                      size: 14.sp,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: statusColor,
                ),
              ),

              horizontalSpace(6),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
