import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import '../../../../../../core/helpers/spacing.dart';

class ScheduledOrderCard extends StatelessWidget {
  final String price, date, from, to;
  final VoidCallback onTap;

  const ScheduledOrderCard({
    super.key,
    required this.price,
    required this.date,
    required this.from,
    required this.to,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateTag(date, context),
              Text(
                price,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          _buildRouteInfo(context),
          verticalSpace(16),
          AppTextButton(
            onPressed: onTap,
            text: 'عرض التفاصيل',
            suffixIcon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTag(String date, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            size: 14.sp,
            color: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          horizontalSpace(8),
          Text(date, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildRouteInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.swap_vert, color: Theme.of(context).colorScheme.primary),
        horizontalSpace(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              from,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            verticalSpace(8),
            Text(
              to,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
          ],
        ),
      ],
    );
  }
}
