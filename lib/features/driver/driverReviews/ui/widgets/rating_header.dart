import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingHeader extends StatelessWidget {
  final double averageRate;
  final int reviewsCount;

  const RatingHeader({super.key, required this.averageRate, required this.reviewsCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Text(
            averageRate.toStringAsFixed(1),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starValue = index + 1;
              double rating = averageRate;
              IconData icon;
              if (rating >= starValue) {
                icon = Icons.star;
              } else if (rating >= starValue - 0.5) {
                icon = Icons.star_half;
              } else {
                icon = Icons.star_border;
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Icon(icon, color: Colors.amber, size: 28.sp),
              );
            }),
          ),
          SizedBox(height: 8.h),
          Text(
            '($reviewsCount تقييم)',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}