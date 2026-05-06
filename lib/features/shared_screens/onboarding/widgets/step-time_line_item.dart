import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class StepTimelineItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isLast;

  const StepTimelineItem({super.key, 
    required this.title,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
 

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12.w,
                height: 12.h,
                decoration:  BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: VerticalDivider(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    thickness: 2,
                  ),
                ),
            ],
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(4),
                Text(description, style: Theme.of(context).textTheme.bodyMedium),
                verticalSpace(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
